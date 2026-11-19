# Uncertainty Quantification

The FFA framework implements three methods for uncertainty
quantification:

1.  Parametric bootstrap
2.  Regula-falsi profile likelihood (RFPL)
3.  Regula-falsi generalized profile likelihood (RFGPL)

## Parametric Bootstrap

The parametric bootstrap is a flexible method for uncertainty
quantification that works with all probability models and parameter
estimation methods. Let \\n\\ be the size of the original dataset.

1.  Draw \\N\_{\text{sim}}\\ bootstrap samples of size \\n\\ from the
    selected probability distribution.
2.  Fit a probability distribution to each bootstrap sample using the
    same [model selection
    method](https://rileywheadon.github.io/ffa-framework/articles/model-selection.md)
    and [parameter estimation
    method](https://rileywheadon.github.io/ffa-framework/articles/parameter-estimation.md)
    that was used to generate the original distribution.
3.  Compute the quantiles for each of the bootstrapped distributions.
4.  Generate confidence intervals using the mean and variance of the
    bootstrapped quantiles.

**Warning**: The parametric bootstrap is known to give unreasonably wide
confidence intervals for small datasets. If the FFA framework detects a
confidence interval that is 5+ times wider than the return levels
themselves, it will return an error and recommend RFPL uncertainty
quantification[^1].

## Regula-Falsi Profile Likelihood (RFPL)

Consider a statistical model with parameters \\(\theta, \psi\_{1},
\dots, \psi\_{n})\\. The **Profile Likelihood** for the scalar parameter
\\\theta\\ and vector of nuisance parameters \\\psi\\ is defined as:

\\ \ell\_{p}(\theta) = \max\_{\psi } \ell(\theta , \psi) \\

Let \\\hat{\theta}\\ be MLE of \\\theta\\. To find a confidence interval
with significance \\1-\alpha\\, we find the two solutions to the
following equation (where \\\chi\_{1;1-\alpha}^2\\ is the \\1-\alpha\\
quantile of the [Chi-squared
distribution](https://en.wikipedia.org/wiki/Chi-squared_distribution)):

\\ 2\[\ell\_{p}(\hat{\theta }) - \ell\_{p}(\theta )\] =
\chi\_{1;1-\alpha }^2 \\

This is equivalent to finding the two points \\\theta\_{L} \<
\hat{\theta} \< \theta\_{U}\\ such that the profile log-likelihood has
dropped by \\\chi \_{1;1-\alpha }^2 / 2\\. To find \\\theta\_{L}\\ and
\\\theta\_{U}\\ we find the roots of \\f(\theta)\\ using a secant-based
algorithm.

\\ f(\theta) = \ell\_{p}(\theta) - \left\[\ell\_{p}(\hat{\theta}) -
\frac{\chi\_{1;1-\alpha }^2}{2}\right\] \\

In the FFA framework, we compute the profile likelihood of each quantile
\\y\\ by reparameterizing the location parameter \\\mu\\. Let \\q(p,
\mu, \psi)\\ be a function that takes an exceedance probability \\p\\,
location parameter \\\mu\\ and nuisance parameters \\\psi\\ and returns
a quantile \\y\\. All quantile functions satisfy:

\\ y = q(p, \mu, \psi) = \mu + q(p, 0, \psi) \\

Therefore, we can define \\\mu\\ as a function of \\(p, y, \psi)\\ as
shown below:

\\ \mu = y - q(p, 0, \psi) \\

We use this relationship to find the profile likelihood \\\ell\_{p}(y)\\
by evaluating \\\mu(p, y, \psi)\\ and substituting it into the
log-likelihood functions listed
[here](https://rileywheadon.github.io/ffa-framework/articles/parameter-estimation.html#maximum-likelihood-mle).

**Warning**: RFPL uncertainty quantification can be numerically unstable
for some datasets. If the FFA framework encounters an issue, it will
return an error and recommend the parametric bootstrap[^2].

### Handling the Weibull Distribution

Due to support issues, we use a different reparameterization for the
Weibull distribution:

\\ \begin{aligned} &y = (\mu\_{0} + \mu\_{1}t) + (\sigma\_{0} +
\sigma\_{1}t)(-\log (1 - p))^{1/\kappa} \\\[5pt\]
\Rightarrow\\&(\sigma\_{0} + \sigma\_{1}t) = \frac{y - (\mu\_{0} +
\mu\_{1}t)}{(-\log (1 - p))^{1/\kappa}} \\\[5pt\]
\Rightarrow\\&\sigma\_{0} = \frac{y - (\mu\_{0} + \mu\_{1}t)}{(-\log
(1 - p))^{1 / \kappa }} - \sigma\_{1}t \end{aligned} \\

The derivation above uses the Weibull distribution with a trend in both
the mean and the variability. However, the reparameterizations for other
nonstationary structures can be obtained easily by setting \\\sigma\_{1}
= 0\\ and/or \\\mu\_{1} = 0\\. After solving for \\\sigma\_{0}\\ in
terms of the other parameters, we can use the standard log-likelihood
function.

### Initialization Algorithm

Before we can find the roots of \\f\\, we need to identify initial
values for the regula-falsi algorithm:

- Let \\a\_{0}\\ be a number such that \\a\_{0} \< y\\ and \\f(a\_{0})
  \< 0\\.
- Let \\b\_{0}\\ be a number such that \\b\_{0} \> y\\ and \\f(b\_{0})
  \< 0\\.

To find \\a\_{0}\\, start by computing \\f(a^{\*})\\ for \\a^{\*} =
0.95y\\. If \\f(a^{\*}) \< 0\\, then assign \\a\_{0} = a^{\*}\\.
Otherwise, update \\a^{\*}\\ to \\0.95a^{\*}\\ until \\f(a^{\*}) \< 0\\.
To find \\b\_{0}\\, we use a similar process. However, instead of
iteratively revising \\b^{\*}\\ down, we revise it up to \\1.05b^{\*}\\.

### Iteration Algorithm

At iteration \\i\\, compute the following:

\\ c\_{i} = \frac{a\_{i-1}f(b\_{i-1}) -
b\_{i-1}f(a\_{i-1})}{f(b\_{i-1}) - f(a\_{i-1})} \\

Evaluate \\\ell\_{p}(c\_{i})\\ by maximizing over the nuisance
parameters \\\psi\\, then find \\f(c\_{i})\\.

If \\\|f(c\_{i})\| \< \epsilon\\ (where \\\epsilon\\ is small), then
stop. \\c\_{i}\\ is the confidence interval bound.

Otherwise, assign \\a\_{i} = c\_{i}\\ if \\f(c\_{i}) \< 0\\ and \\b\_{i}
= c\_{i}\\ if \\f(c\_{i}) \> 0\\ and continue to iteration \\i + 1\\.

## Regula-Falsi Generalized Profile Likelihood (RFGPL)

The regula-falsi generalized profile likelihood (RFGPL) method performs
the regula-falsi algorithm shown above on the GEV distributions with a
\\\text{Beta}(p, q)\\ prior for the shape parameter \\\kappa\\. For more
information about generalized parameter estimation, see
[here](https://rileywheadon.github.io/ffa-framework/articles/parameter-estimation.html#generalized-maximum-likelihood-gmle).

## Handling Nonstationarity

If the selected probability distribution is nonstationary, the quantiles
(and hence confidence intervals) for the bootstrapped distributions
change in time. See
[here](https://rileywheadon.github.io/ffa-framework/articles/ffa-introduction.html#handling-nonstationarity)
for a more detailed discussion of this idea. By default, the FFA
framework anchors uncertainty analysis at the *last* year of the
dataset. However, [model
assessment](https://rileywheadon.github.io/ffa-framework/articles/model-assessment.md)
requires confidence intervals for *every* year in the dataset.

**Note**: The parametric bootstrap algorithm is the fastest algorithm
for computing confidence intervals on all years in a dataset because the
probabilities used to generate the bootstrapped samples can be reused.
The RFPL and RFGPL algorithms are far slower, since they must be run
separately at each timestamp.

[^1]: For more information, please see the following references:

    Vidrio-Sahagún, C.T., He, J. Enhanced profile likelihood method for
    the nonstationary hydrological frequency analysis, Advances in Water
    Resources 161, 10451 (2022).
    <https://doi.org/10.1016/j.advwatres.2022.104151>

    Vidrio-Sahagún, C.T., He, J. & Pietroniro, A. Multi-distribution
    regula-falsi profile likelihood method for nonstationary
    hydrological frequency analysis. Stoch Environ Res Risk Assess 38,
    843–867 (2024). <https://doi.org/10.1007/s00477-023-02603-0>

[^2]: For more information, please see the following references:

    Vidrio-Sahagún, C.T., He, J. Enhanced profile likelihood method for
    the nonstationary hydrological frequency analysis, Advances in Water
    Resources 161, 10451 (2022).
    <https://doi.org/10.1016/j.advwatres.2022.104151>

    Vidrio-Sahagún, C.T., He, J. & Pietroniro, A. Multi-distribution
    regula-falsi profile likelihood method for nonstationary
    hydrological frequency analysis. Stoch Environ Res Risk Assess 38,
    843–867 (2024). <https://doi.org/10.1007/s00477-023-02603-0>
