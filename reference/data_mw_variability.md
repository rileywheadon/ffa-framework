# Estimate Variance for Annual Maximum Series Data

Generates a time series of standard deviations using a moving window
algorithm, which can be used to explore potential evidence of
nonstationarity in the variability of a dataset. It returns a list that
pairs each window’s mean year with its window standard deviation. The
hyperparameters `size` and `step` control the behaviour of the moving
window. Following the simulation findings from Vidrio-Sahagún and He
(2022), the default window size and step are set to 10 and 5 years
respectively. However, these can be changed by the user.

## Usage

``` r
data_mw_variability(data, years, size = 10L, step = 5L)
```

## Arguments

- data:

  Numeric vector of observed annual maximum series values. Must be
  strictly positive, finite, and not missing.

- years:

  Numeric vector of observation years corresponding to `data`. Must be
  the same length as `data` and strictly increasing.

- size:

  Integer scalar. The number of years in each moving window. Must be a
  positive number less than or equal to `length(data)` (default is 10).

- step:

  Integer scalar. The offset (in years) between successive moving
  windows. Must be a positive number (default is 5).

## Value

A list with two entries:

- `years`: Numeric vector containing the mean year within each window.

- `std`: Numeric vector of standard deviations within each window.

## References

Vidrio-Sahagún, C. T., and He, J. (2022). The decomposition-based
nonstationary flood frequency analysis. Journal of Hydrology, 612
(September 2022), 128186.
[doi:10.1016/j.jhydrol.2022.128186](https://doi.org/10.1016/j.jhydrol.2022.128186)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
years <- seq(from = 1901, to = 2000)
data_mw_variability(data, years)
#> $std
#>  [1]  7.312305  6.950598 11.179270 10.996877  7.651039  7.292724  8.149288
#>  [8]  8.666798 11.801322 10.936034  7.005553 10.344956  9.741629  8.458761
#> [15] 11.068826 13.214713 14.345025 11.844711  8.698075
#> 
#> $year
#>  [1] 1905.5 1910.5 1915.5 1920.5 1925.5 1930.5 1935.5 1940.5 1945.5 1950.5
#> [11] 1955.5 1960.5 1965.5 1970.5 1975.5 1980.5 1985.5 1990.5 1995.5
#> 
```
