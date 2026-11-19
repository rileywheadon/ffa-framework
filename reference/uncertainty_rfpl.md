# Regula-Falsi Profile Likelihood Uncertainty Quantification

Calculates return level estimates and confidence intervals at specified
return periods (defaults to 2, 5, 10, 20, 50, and 100 years) using the
regula-falsi profile likelihood root‐finding method.

**For NS-FFA**: To perform uncertainty quantification for a
nonstationary model, include the observation years (`ns_years`), the
nonstationary model structure (`ns_structure`), and a list of years at
which to compute the return level estimates and confidence intervals
(`ns_slices`).

## Usage

``` r
uncertainty_rfpl(
  data,
  distribution,
  ns_years = NULL,
  ns_structure = NULL,
  ns_slices = NULL,
  alpha = 0.05,
  periods = c(2, 5, 10, 20, 50, 100),
  tolerance = 0.01
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

- periods:

  Numeric vector used to set the return periods for FFA. All entries
  must be greater than or equal to 1.

- tolerance:

  The log-likelihood tolerance for Regula-Falsi convergence (default is
  0.01).

## Value

A list containing the following four items:

- `method`: "RFPL"

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

1.  Uses
    [`fit_mle()`](https://rileywheadon.github.io/ffa-framework/reference/fit_mle.md)
    to obtain the maximum log‐likelihood.

2.  Defines an objective function \\f(y_p, p)\\ by reparameterizing the
    log-likelihood.

3.  Iteratively brackets the root by rescaling initial guesses by 0.05
    until \\f(y_p, p)\\ changes sign.

4.  Uses the regula-falsi method to solve \\f(y_p, p) = 0\\ for each
    return period probability.

5.  Returns lower and upper confidence bounds at significance level
    `alpha`.

## Note

RFPL uncertainty quantification can be numerically unstable for some
datasets. If this function encounters an issue, it will return an error
and recommend using the parametric bootstrap method
[`uncertainty_bootstrap()`](https://rileywheadon.github.io/ffa-framework/reference/uncertainty_bootstrap.md)
instead.

## References

Vidrio-Sahagún, C.T., He, J. Enhanced profile likelihood method for the
nonstationary hydrological frequency analysis, Advances in Water
Resources 161, 10451 (2022).
[doi:10.1016/j.advwatres.2022.104151](https://doi.org/10.1016/j.advwatres.2022.104151)

Vidrio-Sahagún, C.T., He, J. & Pietroniro, A. Multi-distribution
regula-falsi profile likelihood method for nonstationary hydrological
frequency analysis. Stochastic Environmental Research and Risk
Assessment 38, 843–867 (2024).
[doi:10.1007/s00477-023-02603-0](https://doi.org/10.1007/s00477-023-02603-0)

## See also

[`utils_quantiles()`](https://rileywheadon.github.io/ffa-framework/reference/utils_quantiles.md),
[`uncertainty_bootstrap()`](https://rileywheadon.github.io/ffa-framework/reference/uncertainty_bootstrap.md),
[`uncertainty_rfgpl()`](https://rileywheadon.github.io/ffa-framework/reference/uncertainty_rfgpl.md),
[`plot_sffa_estimates()`](https://rileywheadon.github.io/ffa-framework/reference/plot_sffa_estimates.md),
[`plot_nsffa_estimates()`](https://rileywheadon.github.io/ffa-framework/reference/plot_nsffa_estimates.md)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
uncertainty_rfpl(data, "GLO")
#> $method
#> [1] "RFPL"
#> 
#> $distribution
#> [1] "GLO"
#> 
#> $params
#> [1] 97.85184515  5.92545823  0.04966016
#> 
#> $ns_structure
#> NULL
#> 
#> $ns_slices
#> NULL
#> 
#> $ci
#>   periods estimates     lower     upper
#> 1       2  97.85185  95.68241  99.98175
#> 2       5 105.78990 103.61462 108.28786
#> 3      10 110.18624 107.66893 113.85957
#> 4      20 114.08339 110.91663 119.57562
#> 5      50 118.82109 114.39066 127.53540
#> 6     100 122.19679 116.56315 133.98842
#> 
```
