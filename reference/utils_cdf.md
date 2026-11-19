# Cumulative Distribution Functions for Probability Models

Compute probabilities from quantiles for both stationary and
nonstationary models.

**For NS-FFA**: To compute the probabilities for a nonstationary model,
specify a time slice (`ns_slice`) and the nonstationary model structure
(`ns_structure`).

## Usage

``` r
utils_cdf(q, distribution, params, ns_slice = 0, ns_structure = NULL)
```

## Arguments

- q:

  Numeric vector of quantiles with no missing values.

- distribution:

  A three-character code indicating the distribution family. Must be
  `"GUM"`, `"NOR"`, `"LNO"`, `"GEV"`, `"GLO"`, `"GNO"`, `"PE3"`,
  `"LP3"`, or `"WEI"`.

- params:

  Numeric vector of distribution parameters, in the order (location,
  scale, shape). The length must be between 2 and 5, depending on the
  specified `distribution` and `structure`.

- ns_slice:

  For NS-FFA only: Numeric scalar specifying the year at which to
  evaluate the quantiles of a nonstationary probability distribution.
  `ns_slice` does not have to be an element of the `ns_years` argument.

- ns_structure:

  For NS-FFA only: Named list indicating which distribution parameters
  are modeled as nonstationary. Must contain two logical scalars:

  - `location`: If `TRUE`, the location parameter has a linear temporal
    trend.

  - `scale`: If `TRUE`, the scale parameter has a linear temporal trend.

## Value

A numeric vector of quantiles with the same length as `q`.

## Examples

``` r
q <- seq(1, 10)
params <- c(1, 1, 1)
utils_cdf(q, "GEV", params)
#>  [1] 0.3678794 0.6065307 0.7165313 0.7788008 0.8187308 0.8464817 0.8668779
#>  [8] 0.8824969 0.8948393 0.9048374
```
