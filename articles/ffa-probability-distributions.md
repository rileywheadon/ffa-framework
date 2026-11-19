# Probability Distributions

The FFA framework considers nine candidate probability distributions:

| Distribution | Abbreviation | Parameters |
|----|----|----|
| Gumbel | `GUM` | \\\mu\\ (location), \\\sigma\\ (scale) |
| Normal | `NOR` | \\\mu\\ (location), \\\sigma\\ (scale) |
| Log-Normal | `LNO` | \\\mu\\ (location), \\\sigma\\ (scale) |
| Generalized Extreme Value | `GEV` | \\\mu\\ (location), \\\sigma\\ (scale), \\\kappa\\ (shape) |
| Generalized Logistic Value | `GLO` | \\\mu\\ (location), \\\sigma\\ (scale), \\\kappa\\ (shape) |
| Generalized Normal | `GNO` | \\\mu\\ (location), \\\sigma\\ (scale), \\\kappa\\ (shape) |
| Pearson Type III | `PE3` | \\\mu\\ (location), \\\sigma\\ (scale), \\\kappa\\ (shape) |
| Log-Pearson Type III | `LP3` | \\\mu\\ (location), \\\sigma\\ (scale), \\\kappa\\ (shape) |
| Weibull | `WEI` | \\\mu\\ (location), \\\sigma\\ (scale), \\\kappa\\ (shape) |

Each distribution also has three nonstationary variants:

1.  A trend in the location parameter \\\mu\\ (+1 parameter).
2.  A trend in the scale parameter \\\sigma\\ (+1 parameter).
3.  A trend in the location \\\mu\\ and the scale \\\sigma\\ (+2
    parameters).

The FFA framework also uses the four-parameter Kappa distribution (KAP)
for the
[Z-statistic](https://rileywheadon.github.io/ffa-framework/articles/model-selection.html#3-z-statistic)
selection metric. The Kappa distribution generalizes the nine
distributions listed above.

------------------------------------------------------------------------

## List of Distributions[^1]

### Gumbel (GUM) Distribution

**Support**

\\-\infty \< x \< \infty\\

**Quantiles**

\\x(F) = \mu - \sigma \log (-\log F)\\

**Likelihood Function**

Its probability density function (PDF) is:

\\ f(x\_{i} : \mu, \sigma) = \frac{1}{\sigma} \exp \left(-z\_{i} -
e^{-z\_{i}}\right) , \quad z\_{i} = \frac{x\_{i} - \mu}{\sigma } \\

Therefore, is Log-likelihood function is:

\\ \ell(x:\mu, \sigma) = \sum\_{i=1}^{n} \left\[-\ln \sigma - z\_{i} -
e^{-z\_{i}} \right\] \\

**L-Moments**

In the equations below, \\\gamma \approx 0.5772\\ is [Euler’s
constant](https://en.wikipedia.org/wiki/Euler%27s_constant).

- \\\lambda\_{1} = \mu + \sigma \gamma\\
- \\\lambda\_{2} = \sigma \log 2\\
- \\\tau\_{3} = \log(9/8)/\log 2 \approx 0.1699\\
- \\\tau\_{4} = (16 \log 2 - 10\log 3) / \log 2 \approx 0.1504\\

We can also express the parameters in terms of the L-moments:

- \\\sigma = \lambda\_{2} / \log 2\\
- \\\mu = \lambda\_{1} - \sigma \gamma\\

### Normal (NOR) Distribution

**Support**

\\-\infty \< x \< \infty\\

**Quantiles**

\\x(F) = \mu + \sigma \Phi^{-1}(F)\\

**Likelihood Function**

Its probability density function (PDF) is:

\\ f(x\_{i} : \mu, \sigma) = \frac{1}{\sigma \sqrt{2\pi
}}e^{-z\_{i}^2/2} , \quad z\_{i} = \frac{x\_{i} - \mu}{\sigma } \\

Therefore, its Log-likelihood function is:

\\ \ell(x:\mu, \sigma) = \sum\_{i=1}^{n} \left\[-\ln (\sigma \sqrt{2\pi
}) - \frac{z\_{i}^2}{2} \right\] \\

**L-Moments**

- \\\lambda\_{1} = \mu\\
- \\\lambda\_{2} = \pi^{-1/2}\sigma \approx 0.5642\sigma\\
- \\\tau\_{3} = 0\\
- \\\tau\_{4} = 30\pi^{-1}\arctan \sqrt{2} - 9 \approx 0.1226\\

We can also express the parameters in terms of the L-moments:

- \\\mu = \lambda\_{1}\\
- \\\sigma = \pi^{1/2}\lambda\_{2}\\

### Log-Normal (LNO) Distribution

**Support**

\\0 \< x \< \infty\\

**Quantiles**

\\x(F) = \exp(\mu + \sigma \Phi^{-1}(F))\\

**Likelihood Function**

To derive its likelihood, we use the fact that:

\\ \text{Data} \sim \text{LNO} \Leftrightarrow \ln (\text{Data}) \sim
\text{NOR} \\

Precisely, we require the change of variables formula, which states
that:

\\ \ell\_{\text{LNO}}(x ; \mu, \sigma) = \ell\_{\text{NOR}}(\ln x ; \mu
, \sigma) \left\|\frac{d}{dx} \ln x\right\| =
\frac{\ell\_{\text{NOR}}(\ln x ; \mu , \sigma)}{x} \\

**L-Moments**

See [Normal Distribution](#normal-nor-distribution).

### Generalized Extreme Value (GEV) Distribution

**Support**

\\ \begin{cases} \mu + (\sigma /\kappa) \leq x \< \infty & \kappa \> 0
\\\[5pt\] -\infty \< x \< \infty & \kappa = 0 \\\[5pt\] -\infty \< x
\leq \mu + (\sigma/\kappa ) &\kappa \< 0 \end{cases} \\

**Quantiles**

\\ x(F) = \begin{cases} \mu + \sigma (1 - (-\log F)^{\kappa })/\kappa
&\kappa \neq 0\\\[5pt\] \mu - \sigma \log (-\log F) &\kappa = 0
\end{cases} \\

**Likelihood Function**

Its probability density function (PDF) is (assume \\t\_{i} \> 0)\\:

\\ f(x\_{i} : \mu, \sigma, \kappa) = \frac{1}{\sigma}t\_{i}^{-1 -
(1/\kappa)} \exp (-t\_{i}^{-1/\kappa}), \quad t\_{i} = 1 + \kappa
\left(\frac{x\_{i} - \mu }{\sigma } \right) \\

Therefore, its Log-likelihood is:

\\ \ell(x:\mu, \sigma, \kappa) = \sum\_{i=1}^{n} \left\[-\ln \sigma -
\left(1 + \frac{1}{\kappa }\right) \ln t\_{i} -
t\_{i}^{-1/\kappa}\right\] \\

**L-Moments**

The L-moments are defined for \\\kappa \> -1\\:

- \\\lambda\_{1} = \mu + \sigma (1 - \Gamma (1 + \kappa)) / \kappa\\
- \\\lambda\_{2} = \sigma (1 - 2^{-\kappa })\Gamma (1 + \kappa) /
  \kappa\\
- \\\tau\_{3} = 2(1 - 3^{-\kappa})/(1 - 2^{-\kappa}) - 3\\
- \\\tau\_{4} = \[5(1 - 4^{-\kappa })-10(1-3^{-\kappa}) + 6(1-2^{-\kappa
  })\]/(1 - 2^{-\kappa })\\

To compute the parameters from the L-moments, we first compute \\c\\:

\\ c = \frac{2}{3 + \tau\_{3}} - \frac{\log 2}{\log 3} \\

Then, we use the following approximation[^2]:

\\ \begin{cases} \kappa \approx 7.8590c + 2.9554c^2 \\\[5pt\] \sigma
\approx \lambda\_{2}\kappa / (1 - 2^{-\kappa })\Gamma (1 + \kappa)
\\\[5pt\] \mu \approx \lambda\_{1} - \sigma (1 - \Gamma (1 + \kappa )) /
\kappa \end{cases} \\

**Note**: Other sources often use a different notation for the GEV
distribution in which the sign of the shape parameter \\\kappa\\ is
flipped.

### Generalized Logistic (GLO) Distribution

**Support**

\\ \begin{cases} -\infty \< x \leq \mu + (\sigma /\kappa ) & \kappa \> 0
\\\[5pt\] -\infty \< x \< \infty & \kappa = 0 \\\[5pt\] \mu + (\sigma
/\kappa ) \leq x \< \infty & \kappa \< 0 \end{cases} \\

**Quantiles**

\\ x(F) = \begin{cases} \mu +\sigma \[1 - ((1 - F) / F)^{\kappa}\] /
\kappa &\kappa \neq 0 \\\[5pt\] \mu - \sigma \log ((1 - F) / F) & k = 0
\end{cases} \\

**Likelihood Function**

Its probability density function (PDF) is (assume \\t\_{i} \> 0)\\:

\\ f(x\_{i} : \mu , \sigma , \kappa ) = \frac{1}{\sigma
}t\_{i}^{(1/\kappa) - 1} \left\[1 + t\_{i}^{1/\kappa}\right\]^{-2},
\quad t\_{i} = 1 - \kappa \left(\frac{x\_{i} - \mu }{\sigma }\right) \\

Therefore, its Log-likelihood function is:

\\ \ell(x:\mu, \sigma, \kappa) = \sum\_{i=1}^{n} \left\[-\ln \sigma +
\left(\frac{1}{\kappa }-1\right) \ln t\_{i} - 2 \ln \left(1 +
t\_{i}^{1/\kappa }\right) \right\] \\

**L-Moments**

The L-moments are defined for \\-1 \< \kappa \< 1\\:

- \\\lambda\_{1} = \mu +\sigma \[(1 / \kappa) - (\pi / \sin
  (\kappa\pi))\]\\
- \\\lambda\_{2} = \sigma \kappa \pi / \sin (\kappa \pi)\\
- \\\tau\_{3} = -\kappa\\
- \\\tau\_{4} = (1 + 5\kappa ^2) / 6\\

We can also express the parameters in terms of the L-moments:

- \\\kappa = -\tau\_{3}\\
- \\\sigma = \lambda\_{2}\sin (\kappa \pi ) / \kappa \pi\\
- \\\mu = \lambda\_{1} - \sigma \[(1 / \kappa) - (\pi / \sin
  (\kappa\pi))\]\\

### Generalized Normal (GNO) Distribution

**Support**

\\ \begin{cases} -\infty \< x \leq \mu + (\sigma /\kappa ) & \kappa \> 0
\\\[5pt\] -\infty \< x \< \infty & \kappa = 0 \\\[5pt\] \mu + (\sigma
/\kappa ) \leq x \< \infty & \kappa \< 0 \end{cases} \\

**Quantiles**

\\ x(F) = \begin{cases} \mu + \sigma \[1 - \exp(-\kappa \Phi^{-1}(F))\]
/ \kappa &\kappa \neq 0 \\\[5pt\] \mu + \sigma \Phi^{-1}(F) &\kappa = 0
\end{cases} \\

**Likelihood Function**

**L-Moments**

The L-moments are defined for all values of \\\kappa\\.

- \\\lambda\_{1} = \mu + \sigma (1 - e^{\kappa ^2/2}) / \kappa\\
- \\\lambda\_{2} = \sigma e^{-\kappa ^2/ 2}\[1 - 2\Phi (-\kappa /
  \sqrt{2})\] / \kappa\\

To compute \\\tau\_{3}\\ and \\\tau\_{4}\\ we use the following
approximation:

\\ \begin{aligned} \tau\_{3} &\approx -\kappa \left(\frac{A\_{0} +
A\_{1}\kappa ^2 + A\_{2}\kappa ^{4} + A\_{3}\kappa ^{6}}{1 +
B\_{1}\kappa ^2 + B\_{2}\kappa ^{4} + B\_{3}\kappa ^{6}}\right)
\\\[5pt\] \tau\_{4} &\approx \tau\_{4}^{0} + \kappa ^2
\left(\frac{C\_{0} + C\_{1}\kappa ^2 + C\_{2}\kappa ^{4} + C\_{3}\kappa
^{6}}{1 + D\_{1}\kappa ^2 + D\_{2}\kappa ^{4} + D\_{3}\kappa
^{6}}\right) \end{aligned} \\

To determine the parameters from the L-moments we also use a rational
approximation:

\\ \kappa \approx -\tau\_{3} \left(\frac{E\_{0} + E\_{1}\tau\_{3}^2 +
E\_{2}\tau\_{3}^{4} + E\_{3}\tau \_{3}^{6}}{1 + F\_{1}\tau \_{3}^2 +
F\_{2}\tau \_{3}^{4} + F\_{3}\tau \_{3}^{6}}\right) \\

Then, we can find \\\mu\\ and \\\sigma\\ as a function of \\\kappa\\:

\\ \sigma \approx \frac{\lambda\_{2}\kappa e^{-\kappa ^2 / 2}}{1 - 2\Phi
(-\kappa / \sqrt{2})}, \quad \mu \approx \lambda\_{1} - \frac{\sigma
}{\kappa }\left(1 - e^{-\kappa ^2 / 2 }\right) \\

The coefficients (\\A\_{i}\\, \\B\_{i}\\, \\C\_{i}\\, \\D\_{i}\\,
\\E\_{i}\\, \\F\_{i}\\, and \\\tau\_{4}^{0}\\) are defined in Appendix
A.8 of Hosking, 1997[^3]. Although this appendix covers the 3-parameter
log-normal distribution, the L-moments of the generalized normal
distribution are the same.

### Pearson Type III (PE3) Distribution

The Pearson Type III distribution is typically reparameterized as
follows for \\\kappa \neq 0\\:

\\ \begin{aligned} \alpha &= 4 / \kappa^2 \\\[5pt\] \beta &= \sigma
\|\kappa \| / 2 \\\[5pt\] \xi &= \mu - 2\sigma /\kappa \end{aligned} \\

**Support**

\\ \begin{cases} \xi \leq x \< \infty &\kappa \> 0 \\\[5pt\] -\infty \<
x \< \infty &\kappa =0 \\\[5pt\] -\infty \< x \leq \xi &\kappa \< 0
\end{cases} \\

**Quantiles**

\\ x(F) = \begin{cases} \mu - \alpha \beta + q(F, \alpha, \beta) &\kappa
\> 0\\\[5pt\] \mu + \sigma \Phi^{-1}(F) &\kappa = 0\\\[5pt\] \mu +
\alpha \beta - q(1 - F, \alpha, \beta) &\kappa \< 0 \end{cases} \\

In the equations above, \\q\\ is the quantile function of the Gamma
distribution with shape \\\alpha\\ and scale \\\beta\\. \\q\\ is defined
below, where \\\gamma\\ is the *lower incomplete Gamma function*.

\\q(F, \alpha, \beta) = \beta \gamma ^{-1}(\alpha, p \Gamma (\alpha))\\

**Likelihood Function**

The probability density function (PDF) of the PE3 distribution is given
below:

\\ f(x\_{i} : \mu , \sigma , \kappa ) = \frac{(x\_{i} - \xi)^{\alpha -
1}e^{-(x\_{i} - \xi )/\beta }}{\beta ^{\alpha } \Gamma (\alpha )} \\

Therefore, its Log-likelihood function is:

\\ \ell(x:\mu, \sigma, \kappa) = \sum\_{i=1}^{n} \left\[(\alpha - 1) \ln
\|x\_{i} - \xi \| - \frac{\|x\_{i} - \xi \|}{\beta } - \alpha \ln\beta -
\ln \Gamma (\alpha )\right\] \\

**L-Moments**

All subsequent definitions assume that \\\kappa \> 0\\. If \\\kappa \<
0\\, the L-moments can be obtained by changing the signs of
\\\lambda\_{1}\\, \\\tau\_{3}\\, and \\\xi\\ whenever they appear. If
\\\kappa = 0\\, the L-moments are the same as the [Normal
Distribution](#normal-nor-distribution). The first two L-moments are
defined as follows:

- \\\lambda\_{1} = \xi + \alpha \beta\\
- \\\lambda\_{2} = \pi ^{-1/2} \beta \Gamma (\alpha + 0.5) / \Gamma
  (\alpha )\\

Rational approximation is necessary to determine \\\tau\_{3}\\ and
\\\tau\_{4}\\. If \\\alpha \geq 1\\:

\\ \begin{aligned} \tau\_{3} &\approx \alpha^{-1/2} \left(\frac{A\_{0} +
A\_{1}\alpha^{-1} + A\_{2}\alpha^{-2} + A\_{3}\alpha^{-3}}{1 +
B\_{1}\alpha^{-1} + B\_{2}\alpha ^{-2}}\right) \\\[5pt\] \tau\_{4}
&\approx \frac{C\_{0} + C\_{1}\alpha^{-1} + C\_{2}\alpha ^{-2}
+C\_{3}\alpha ^{-3}}{1 + D\_{1}\alpha ^{-1} + D\_{2}\alpha ^{-2}}
\end{aligned} \\

If \\\alpha \< 1\\, we use a different set of coefficients:

\\ \begin{aligned} \tau\_{3} &\approx \frac{1 + E\_{1}\alpha +
E\_{2}\alpha ^2 + E\_{3}\alpha ^3}{1 + F\_{1}\alpha + F\_{2}\alpha ^2 +
F\_{3}\alpha ^3} \\\[5pt\] \tau\_{4} &\approx \frac{1 + G\_{1}\alpha +
G\_{2}\alpha ^2 + G\_{3}\alpha ^3}{1 + H\_{1}\alpha + H\_{2}\alpha ^2 +
H\_{3}\alpha ^3} \end{aligned} \\

Coefficients are given in Appendix A.9 of Hosking, 1997[^4]. To estimate
parameters from the L-moments, we use one of two approximations for
\\\alpha\\ depending on the value of \\\tau\_{3}\\:

\\ \alpha \approx \begin{cases} \frac{1 + 0.2906z}{z + 0.1882z^2 +
0.0442z^3}, &z = 3\pi \tau\_{3}^2, &0 \< \|\tau\_{3}\| \< \frac{1}{3}
\\\[5pt\] \frac{0.36067z - 0.59567z^2 + 0.25361z^3}{1 - 2.78861z +
2.56096z^2 - 0.77045z^3}, &z = 1 - \|\tau\_{3}\|, &\frac{1}{3} \leq
\|\tau\_{3}\| \< 1 \end{cases} \\

Then, we can determine the parameters from the approximated \\\alpha\\:

\\ \begin{aligned} \kappa &= 2\alpha ^{-1/2} \text{sign} (\tau\_{3})
\\\[5pt\] \sigma &= \lambda\_{2} \pi^{1/2}\alpha ^{1/2} \Gamma (\alpha
)/\Gamma (\alpha + 0.5)\\\[5pt\] \mu &= \lambda\_{1 } \end{aligned} \\

### Log-Pearson Type III (LP3) Distribution

The LP3 distribution uses the same reparameterization as the [PE3
distribution](#pearson-type-iii-pe3-distribution).

**Support**

\\ \begin{cases} \max(0, \xi) \leq x \< \infty &\kappa \> 0 \\\[5pt\] 0
\< x \< \infty &\kappa =0 \\\[5pt\] 0 \< x \leq \max(0, \xi) &\kappa \<
0 \end{cases} \\

**Quantiles**

\\x(F) = \exp(x\_{\text{PE3}}(F ))\\, where \\x\_{\text{PE3}}(F)\\ is
the quantile function of the [PE3
distribution](#pearson-type-iii-pe3-distribution).

**Likelihood Function**

To derive the likelihood of the LP3 distribution, we use the fact that:

\\ \text{Data} \sim \text{LP3} \Leftrightarrow \ln (\text{Data}) \sim
\text{PE3} \\

Precisely, we require the change of variables formula, which states
that:

\\ \ell\_{\text{LP3}}(x ; \mu, \sigma, \kappa) = \ell\_{\text{PE3}}(\ln
x ; \mu , \sigma, \kappa ) \left\|\frac{d}{dx} \ln x\right\| =
\frac{\ell\_{\text{PE3}}(\ln x ; \mu , \sigma, \kappa )}{x} \\

**L-Moments**

Same as the [PE3 distribution](#pearson-type-iii-pe3-distribution).

### Weibull (WEI) Distribution

The Weibull distribution is implemented as a reparameterized version of
the generalized extreme value distribution:

\\ \begin{aligned} \kappa &= 1 / \kappa\_{\text{GEV}} \\\[5pt\] \sigma
&= \kappa \sigma\_{\text{GEV} } \\\[5pt\] \mu &= \sigma +
\mu\_{\text{GEV} } \end{aligned} \\

Under this reparameterization, it is required that \\\sigma \> 0\\ and
\\\kappa \> 0\\.

**Support**

\\\mu \leq x \< \infty\\

**Quantiles**

\\x(F) = \mu + \sigma (-\log (1 - F))^{1/\kappa}\\

**Likelihood Function**

Its probability density function (PDF) is given below for \\x\_{i} \>
\mu\\:

\\ f(x\_{i} : \mu, \sigma, \kappa) = \frac{\kappa}{\sigma
}\left(\frac{x\_{i} - \mu}{\sigma }\right)^{\kappa -1} \exp \left( -
\left(\frac{x\_{i} - \mu}{\sigma }\right)^{\kappa } \right) \\

Therefore, its Log-likelihood function is:

\\ \ell(x:\mu, \sigma, \kappa) = \sum\_{i=1}^{n} \left\[\ln \kappa -
\kappa \ln \sigma +(\kappa -1)\ln (x\_{i}-\mu ) - \left(\frac{x\_{i} -
\mu }{\sigma }\right) ^{\kappa } \right\] \\

**L-Moments**

First, reparameterize the Weibull distribution to recover the GEV
parameters:

\\ \begin{aligned} \kappa\_{\text{GEV}} &= 1 / \kappa \\\[5pt\]
\sigma\_{\text{GEV}} &= \sigma / \kappa \\\[5pt\] \end{aligned} \\

Next, compute the L-moments for the [GEV
distribution](#generalized-extreme-value-gev-distribution) with
\\\mu\_{\text{GEV}} = 0\\. Then,

- \\\lambda\_{1} = \mu + \sigma - \lambda\_{1, \text{GEV}}\\
- \\\lambda\_{2} = \lambda\_{2, \text{GEV}}\\
- \\\tau\_{3} = -\tau\_{3, \text{GEV}}\\
- \\\tau\_{4} = \tau\_{4, \text{GEV} }\\

To compute the parameters from the L-moments, first flip the sign of
\\\lambda\_{1}\\ and \\\tau\_{3}\\. Then, estimate the parameters of the
GEV distribution to get \\\hat{\mu}\_{\text{GEV}}\\,
\\\hat{\sigma}\_{\text{GEV}}\\, and \\\hat{\kappa}\_{\text{GEV}}\\.
Finally, reparameterize the GEV parameters as shown
[here](#weibull-wei-distribution) and then flip the sign of \\\mu\\.

### Kappa (KAP) Distribution

The Kappa distribution has location \\\mu\\, scale \\\sigma\\, and two
shape parameters \\\kappa\\ and \\h\\.

**Support**

\\ \begin{cases} \mu + \sigma (1 - h^{-\kappa}) \leq x \leq \mu +
(\sigma /\kappa ) & \kappa \> 0, h \> 0 \\\[5pt\] -\infty \< x \leq
\mu + (\sigma /\kappa) & \kappa \> 0, h \leq 0 \\\[5pt\] \mu + \sigma
(1 - h^{-\kappa}) \leq x \< \infty &\kappa \leq 0, h \> 0 \\\[5pt\]
\mu + (\sigma / \kappa ) \leq x \<\infty &\kappa \leq 0, h \leq 0
\end{cases} \\

**Quantiles**

\\ x(F) = \mu + \frac{\sigma }{\kappa }\left\[1 - \left(\frac{1 -
F^{h}}{h}\right)^{\kappa }\right\] \\

**L-Moments**

The L-moments are defined if \\h \geq 0\\ and \\k \> -1\\ or if \\h \<
0\\ and \\-1 \< k \< -1/h\\.

- \\\lambda\_{1} = \mu + \sigma (1 - g\_{1})/\kappa\\
- \\\lambda\_{2} = \sigma(g\_{1} - g\_{2})/\kappa\\
- \\\tau\_{3} = (-g\_{1} + 3g\_{2} - 2g\_{3}) / (g\_{1} - g\_{2})\\
- \\\tau\_{4} = (-g\_{1} + 6g\_{2} - 10g\_{3} + 5g\_{4}) / (g\_{1} -
  g\_{2})\\

In the expression above, \\g\_{r}\\ is defined as follows:

\\ g\_{r} = \begin{cases} \frac{r\Gamma (1 + \kappa )\Gamma (r /
h)}{h^{1 + \kappa }\Gamma (1 + \kappa + r/h)} &h \> 0 \\\[5pt\]
\frac{r\Gamma (1 + \kappa ) \Gamma (-\kappa - r/h)}{(-h)^{1 + \kappa
}\Gamma (1 - r/h)} &h \< 0 \end{cases} \\

There is no closed-form solution for the parameters in terms of the
L-moments. However, \\\tau\_{3}\\ and \\\tau\_{4}\\ can be computed in
terms of \\\kappa\\ and \\h\\ using Newton-Raphson iteration.

## Sources

[^1]: Hosking, J.R.M. & Wallis, J.R., 1997. Regional frequency analysis:
    an approach based on L-Moments. Cambridge University Press, New
    York, USA.

[^2]: Hosking, J.R.M., Wallis, J.R., & Wood, E.F., 1985. Estimation of
    the generalized extreme-value distribution by the method of
    probability-weighted moments. Technometrics, 27, 251-61.

[^3]: Hosking, J.R.M. & Wallis, J.R., 1997. Regional frequency analysis:
    an approach based on L-Moments. Cambridge University Press, New
    York, USA.

[^4]: Hosking, J.R.M. & Wallis, J.R., 1997. Regional frequency analysis:
    an approach based on L-Moments. Cambridge University Press, New
    York, USA.
