# MATLAB Version

## Changes from MATLAB Version

This page documents changes from [original MATLAB
code](https://zenodo.org/records/8012096).

### Exploratory Data Analysis (EDA)

#### Bug Fixes

- Only show statistically significant change points for the Pettitt and
  MKS plots.
- Fix bug causing the MKS test to only identify one change point, even
  if multiple change points were found to be above the threshold for
  statistical significance.
- Fix major bug causing the MKS test to identify change points based on
  the progressive series instead of the z-statistics of the crossing
  points.
- Remove unnecessary rounding in the moving window algorithm for
  estimating variability.
- Re-implement the Phillips-Perron and KPSS tests to account for drift
  and trend.

#### Framework Changes

- If serial correlation is identified, do not run the Phillips-Perron
  and KPSS tests.
- Add the the Runs test to detect nonlinearity after fitting Sen’s trend
  estimator.
- Run change point detection in multiple stages to prevent
  overpartitioning.

### Flood Frequency Analysis (FFA)

#### Distribution Changes

The R version adds the three parameter Weibull distribution (with
location, scale, and shape) parameters.

#### Model Selection Changes

The L-distance and L-kurtosis selection methods have been improved by
using an optimization algorithm to find the parameters with the closest
L-moments to the data instead of using a brute force approach. This is
more computationally efficient and gives more precise results.

The procedure for computing the Z-statistic selection metric has been
changed. If the L-moments of the dataset do not satisfy \\\tau\_{4} \leq
(1 + 5\tau \_{3}^2)/6\\, then the Kappa distribution will not be fitted
and the candidate distributions that use the dataset will be omitted.

#### Parameter Estimation Changes

Parameterization of the PE3/LP3 distributions fails for some datasets
because MATLAB is unable to handle the large numbers created by the
gamma function. To manage this issue, the MATLAB version used the
conventional moments (i.e. sample mean/variance/skewness) when this
occurred. We avoid this problem in the R version by using the `lgamma`
(log-gamma) function.

The R implementation uses L-BFGS-B for MLE/GMLE parameter estimation
instead of Nelder-Mead, since the gradient is well defined for the
likelihood functions we are working with. Additionally, the L-BFGS-B
method makes it possible to assign bounds to the variables. This
modification produced slight improvements to the MLL/GMLL for some
datasets.

#### Uncertainty Quantification

Implement RFPL uncertainty quantification for the Weibull distribution.

#### Model Assessment Changes

Use the built-in R function
[`approx()`](https://rdrr.io/r/stats/approxfun.html) to perform
log-linear interpolation of the return periods. The MATLAB
implementation uses a hard-coded algorithm which behaves unpredictably
when the original and interpolated \\x\\-values are equal.
