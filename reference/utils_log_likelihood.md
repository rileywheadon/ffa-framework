# Log-Likelihood Functions for Probability Models

Compute the log-likelihood for stationary and nonstationary probability
models.

**For NS-FFA**: To compute the log-likelihood for a nonstationary
probability model, include the observation years (`ns_years`) and the
nonstationary model structure (`ns_structure`).

## Usage

``` r
utils_log_likelihood(
  data,
  distribution,
  params,
  ns_years = NULL,
  ns_structure = NULL
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

- params:

  Numeric vector of distribution parameters, in the order (location,
  scale, shape). The length must be between 2 and 5, depending on the
  specified `distribution` and `structure`.

- ns_years:

  For NS-FFA only: Numeric vector of observation years corresponding to
  `data`. Must be the same length as `data` and strictly increasing.

- ns_structure:

  For NS-FFA only: Named list indicating which distribution parameters
  are modeled as nonstationary. Must contain two logical scalars:

  - `location`: If `TRUE`, the location parameter has a linear temporal
    trend.

  - `scale`: If `TRUE`, the scale parameter has a linear temporal trend.

## Value

Numeric scalar. The log-likelihood value.

## See also

[`utils_generalized_likelihood()`](https://rileywheadon.github.io/ffa-framework/reference/utils_generalized_likelihood.md)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
params <- c(100, 1, 10)
ns_years <- seq(from = 1901, to = 2000)
ns_structure <- list(location = TRUE, scale = FALSE)

# Compute the log-likelihood
utils_log_likelihood(data, "NOR", params, ns_years, ns_structure)
#> [1] -362.6374
```
