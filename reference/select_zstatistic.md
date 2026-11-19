# Z-Statistic Method for Distribution Selection

Selects the best-fit distribution by comparing a bias-corrected
Z-statistic for the sample L-kurtosis (\\\tau_4\\) against the
theoretical L-moments for a set of candidate distributions. The
distribution with the smallest absolute Z-statistic is selected.

**For NS-FFA**: To select a distribution for a nonstationary model,
include the observation years (`ns_years`) and the nonstationary model
structure (`ns_structure`). Then, this method will detrend the original,
nonstationary data internally using the
[`data_decomposition()`](https://rileywheadon.github.io/ffa-framework/reference/data_decomposition.md)
function prior to distribution selection.

## Usage

``` r
select_zstatistic(data, ns_years = NULL, ns_structure = NULL, samples = 10000L)
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

- samples:

  Integer scalar. The number of bootstrap samples. Default is 10000.

## Value

A list with the results of distribution selection:

- `method`: `"Z-selection"`.

- `decomposed_data`: The detrended dataset used to compute the
  L-moments. For S-FFA, this is the `data` argument. For NS-FFA, it is
  output of
  [`data_decomposition()`](https://rileywheadon.github.io/ffa-framework/reference/data_decomposition.md).

- `metrics`: List of computed Z-statistics for each candidate
  distribution.

- `recommendation`: Name of the distribution with the smallest
  Z-statistic.

- `reg_params`: Kappa distribution parameters for the data.

- `reg_bias_t4`: Bias of the L-kurtosis from the bootstrap.

- `reg_std_t4`: Standard deviation of the L-kurtosis from the bootstrap.

- `log_params`: Kappa distribution parameters for the log-transformed
  data.

- `log_bias_t4`: Bias of the L-kurtosis from the bootstrap using
  `log_params`.

- `log_std_t4`: Standard deviation of the L-kurtosis from the bootstrap
  using `log_params`.

## Details

First, this method fits a four-parameter Kappa distribution to both the
original and log-transformed data. Then, bootstrapping is used to
estimate the bias and variance of the L-kurtosis. These values, along
with the difference between the sample and theoretical L-kurtosis, are
used to compute the Z-statistic for each distribution.

## References

Hosking, J.R.M. & Wallis, J.R., 1997. Regional frequency analysis: an
approach based on L-Moments. Cambridge University Press, New York, USA.

## See also

[`select_ldistance()`](https://rileywheadon.github.io/ffa-framework/reference/select_ldistance.md),
[`select_lkurtosis()`](https://rileywheadon.github.io/ffa-framework/reference/select_lkurtosis.md),
[`fit_lmoments_kappa()`](https://rileywheadon.github.io/ffa-framework/reference/fit_lmoments_kappa.md),
[`utils_quantiles()`](https://rileywheadon.github.io/ffa-framework/reference/utils_quantiles.md),
[`plot_lmom_diagram()`](https://rileywheadon.github.io/ffa-framework/reference/plot_lmom_diagram.md)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
select_zstatistic(data)
#> $method
#> [1] "Z-statistic"
#> 
#> $decomposed_data
#>   [1]  95.18266  84.88822  98.73177  90.61345  85.76046 109.30882  98.50952
#>   [8] 103.29830  99.29804 107.43773 106.53436 101.94005  94.43396  88.62446
#>  [15]  86.15113  87.34794  97.29279  93.59332  89.98599  94.51522  91.89217
#>  [22] 123.51861  94.62130 104.34007  93.78040 112.96217 107.54607  82.36077
#>  [29]  94.59060  93.65830  91.73357  97.10894 113.28727  93.76409 109.79780
#>  [36]  90.23266 108.78808  86.65743  98.03980 102.97228  92.41951 101.42918
#>  [43]  91.31669 107.23347 107.56052  95.12877  82.15242 112.71417 103.79248
#>  [50] 101.49773  95.78656 118.39799  84.69241 102.53432 103.22255 107.71944
#>  [57] 115.23447 120.55768  77.45147 118.89402 110.88989 108.19190  99.01436
#>  [64]  87.34524 112.53774 102.87017  98.92801 109.99006 102.05745  96.85081
#>  [71]  92.73547  90.02870  90.91388 112.39229 101.70026  87.05973 109.39383
#>  [78] 107.86668  98.00884  87.27867  87.88891  99.74621  85.82340 113.05842
#>  [85]  97.47827 113.70727  96.49615 106.12335 117.50175  99.07591 103.09165
#>  [92]  86.96846 123.66781  78.52859 105.84705 106.37111 100.60616  98.57401
#>  [99] 109.41655 100.81120
#> 
#> $metrics
#> $metrics$GEV
#> [1] 0.9013136
#> 
#> $metrics$GLO
#> [1] 2.886692
#> 
#> $metrics$GNO
#> [1] 1.324017
#> 
#> $metrics$PE3
#> [1] 1.308088
#> 
#> $metrics$LP3
#> [1] 1.309811
#> 
#> $metrics$WEI
#> [1] 0.6586037
#> 
#> 
#> $recommendation
#> [1] "WEI"
#> 
#> $reg_params
#> [1] 94.3021894 12.3980034  0.3440470  0.2378584
#> 
#> $reg_bias_t4
#> [1] 0.001223716
#> 
#> $reg_std_t4
#> [1] 0.02822636
#> 
#> $log_params
#> [1] 4.5507975 0.1243812 0.4051046 0.1754390
#> 
#> $log_bias_t4
#> [1] 0.001024138
#> 
#> $log_std_t4
#> [1] 0.02804789
#> 
```
