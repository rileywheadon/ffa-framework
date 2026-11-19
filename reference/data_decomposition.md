# Decompose Annual Maximum Series

Decomposes a nonstationary annual maxima series to derive its stationary
stochastic component, which can be used to identify a best-fit
distribution using conventional stationary methods, like those based on
L-moments. The decomposition procedure follows that proposed by
Vidrio-Sahagún and He (2022), which relies on the statistical
representation of nonstationary stochastic processes.

## Usage

``` r
data_decomposition(data, ns_years, ns_structure)
```

## Arguments

- data:

  Numeric vector of observed annual maximum series values. Must be
  strictly positive, finite, and not missing.

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

Numeric vector of decomposed data.

## Details

Internally, the function does the following:

1.  If there is a trend in the location, fit Sen's trend estimator and
    subtract away the fitted trend.

2.  If there is a trend in the scale, estimate the variability of the
    data with
    [`data_mw_variability()`](https://rileywheadon.github.io/ffa-framework/reference/data_mw_variability.md),
    fit Sen's trend estimator to the variability vector, and rescale the
    data to remove the trend.

3.  If necessary, shift the data so that its minimum is at least 1.

## References

Vidrio-Sahagún, C. T., and He, J. (2022). The decomposition-based
nonstationary flood frequency analysis. Journal of Hydrology, 612
(September 2022), 128186.
[doi:10.1016/j.jhydrol.2022.128186](https://doi.org/10.1016/j.jhydrol.2022.128186)

## See also

[`data_mw_variability()`](https://rileywheadon.github.io/ffa-framework/reference/data_mw_variability.md),
[`eda_sens_trend()`](https://rileywheadon.github.io/ffa-framework/reference/eda_sens_trend.md)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
ns_years <- seq(from = 1901, to = 2000)
ns_structure <- list(location = TRUE, scale = FALSE)
data_decomposition(data, ns_years, ns_structure)
#>   [1]  85.92228 102.39860  75.39551  99.63515 105.82911 111.02042  81.24084
#>   [8]  96.90848  96.86246  96.40011  93.61289 105.36242 119.64557  82.60814
#>  [15] 103.96502  80.13335  93.46606  98.08288 103.96158  89.31359 103.05860
#>  [22] 101.92928  85.17705 105.52297 116.95297  97.01619  88.55488  97.67657
#>  [29]  89.49090  82.55751 106.95785  99.29182  99.88651 113.60786  98.41547
#>  [36]  95.87783  78.03965  94.27087  93.85150 107.58175  97.53174  90.36287
#>  [43]  96.17717  94.08470 100.97023 123.99915  96.83300 102.06750  97.39507
#>  [50]  77.01863 104.67942  93.54891  93.84312  96.01848  96.04503 101.17042
#>  [57]  72.85371 122.34315  91.82808  97.49657 106.02918  88.55756 106.27068
#>  [64]  92.59491  83.20096  85.14080 105.47260  96.06145  99.55375  77.59567
#>  [71]  79.80553  97.27711 107.73153  96.64801 107.38669  99.36557 100.11667
#>  [78]  92.87255  95.61644  92.91407 112.98349 106.64670 101.07341  99.07045
#>  [85]  87.94835 104.45899  67.15302  91.64214  97.46069  89.22500  97.20910
#>  [92] 103.52096 103.29979  92.35435  97.51958 109.30964  88.95992 101.88972
#>  [99] 105.51723  89.30528
```
