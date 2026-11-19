# Parametric Bootstrap Uncertainty Quantification

Computes return level estimates and confidence intervals at the
specified return periods (defaults to 2, 5, 10, 20, 50, and 100 years)
using the parametric bootstrap. This function supports many probability
models and parameter estimation methods.

**For NS-FFA**: To perform uncertainty quantification for a
nonstationary model, include the observation years (`ns_years`), the
nonstationary model structure (`ns_structure`), and a list of years at
which to compute the return level estimates and confidence intervals
(`ns_slices`).

## Usage

``` r
uncertainty_bootstrap(
  data,
  distribution,
  method,
  prior = NULL,
  ns_years = NULL,
  ns_structure = NULL,
  ns_slices = NULL,
  alpha = 0.05,
  samples = 10000L,
  periods = c(2, 5, 10, 20, 50, 100)
)
```

## Arguments

- data:

  Numeric vector of observed annual maximum series values. Must be
  strictly positive, finite, and not missing.

- distribution:

  A three-character code indicating the distribution family. Must be
  `"GUM"`, `"NOR"`, `"LNO"`, `"GEV"`, `"GLO"`, `"GNO"`, `"PE3"`,
  `"LP3"`, or `"WEI"`.

- method:

  Character scalar specifying the estimation method. Must be
  `"L-moments"`, `"MLE"`, or `"GMLE"`.

- prior:

  Numeric vector of length 2. Specifies the parameters of the Beta prior
  for the shape parameter \\\kappa\\.

- ns_years:

  For NS-FFA only: Numeric vector of observation years corresponding to
  `data`. Must be the same length as `data` and strictly increasing.

- ns_structure:

  For NS-FFA only: Named list indicating which distribution parameters
  are modeled as nonstationary. Must contain two logical scalars:

  - `location`: If `TRUE`, the location parameter has a linear temporal
    trend.

  - `scale`: If `TRUE`, the scale parameter has a linear temporal trend.

- ns_slices:

  For NS-FFA only: Numeric vector specifying the years at which to
  evaluate the return levels confidence intervals of a nonstationary
  probability distribution. `ns_slices` do not have to be elements of
  the `ns_years` argument.

- alpha:

  Numeric scalar in \\\[0.01, 0.1\]\\. The significance level for
  confidence intervals or hypothesis tests. Default is 0.05.

- samples:

  Integer scalar. The number of bootstrap samples. Default is 10000.

- periods:

  Numeric vector used to set the return periods for FFA. All entries
  must be greater than or equal to 1.

## Value

A list containing the following six items:

- `method`: "Bootstrap"

- `distribution`: The `distribution` argument.

- `params`: The fitted parameters.

- `ns_structure`: The `ns_structure` argument, if given.

- `ns_slices`: The `ns_slices` argument, if given.

- `ci`: A dataframe containing confidence intervals (S-FFA only)

- `ci_list`: A list of dataframes containing confidence intervals
  (NS-FFA only).

The dataframe(s) in `ci` and `ci_list` have four columns:

- `estimates`: Estimated quantiles for each return period.

- `lower`: Lower bound of the confidence interval for each return
  period.

- `upper`: Upper bound of the confidence interval for each return
  period.

- `periods`: The `periods` argument.

## Details

Bootstrap samples are obtained from the fitted distribution via inverse
transform sampling. For each bootstrapped sample, the parameters are
re-estimated based on the `method` argument. Then, the bootstrapped
parameters are used to compute a new set of bootstrapped quantiles.
Confidence intervals are obtained from the empirical nonexceedance
probabilities of the bootstrapped quantiles.

## Note

The parametric bootstrap is known to give unreasonably wide confidence
intervals for small datasets. If this method yields a confidence
interval that is at least 5 times greater than the magnitude of the
return levels, it will return an error and recommend
[`uncertainty_rfpl()`](https://rileywheadon.github.io/ffa-framework/reference/uncertainty_rfpl.md)
or
[`uncertainty_rfgpl()`](https://rileywheadon.github.io/ffa-framework/reference/uncertainty_rfgpl.md)
as alternatives.

## References

Vidrio-Sahagún, C.T., He, J. Enhanced profile likelihood method for the
nonstationary hydrological frequency analysis, Advances in Water
Resources 161, 10451 (2022).
[doi:10.1016/j.advwatres.2022.104151](https://doi.org/10.1016/j.advwatres.2022.104151)

## See also

[`fit_lmoments()`](https://rileywheadon.github.io/ffa-framework/reference/fit_lmoments.md),
[`fit_mle()`](https://rileywheadon.github.io/ffa-framework/reference/fit_mle.md),
[`fit_gmle()`](https://rileywheadon.github.io/ffa-framework/reference/fit_gmle.md),
[`utils_sample_lmoments()`](https://rileywheadon.github.io/ffa-framework/reference/utils_sample_lmoments.md)
[`utils_quantiles()`](https://rileywheadon.github.io/ffa-framework/reference/utils_quantiles.md),
[`plot_sffa_estimates()`](https://rileywheadon.github.io/ffa-framework/reference/plot_sffa_estimates.md),
[`plot_nsffa_estimates()`](https://rileywheadon.github.io/ffa-framework/reference/plot_nsffa_estimates.md)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
uncertainty_bootstrap(data, "WEI", "L-moments")
#> $method
#> [1] "Bootstrap"
#> 
#> $distribution
#> [1] "WEI"
#> 
#> $params
#> [1] 59.828456 44.790325  4.175832
#> 
#> $ns_structure
#> NULL
#> 
#> $ns_slices
#> NULL
#> 
#> $ci
#>   periods estimates     lower    upper
#> 1       2  100.8551  98.38518 103.2619
#> 2       5  110.0254 107.57738 112.4230
#> 3      10  114.5206 111.77266 117.2988
#> 4      20  118.0782 114.86841 121.4467
#> 5      50  121.9223 118.02634 126.2194
#> 6     100  124.3959 119.96383 129.4447
#> 
```
