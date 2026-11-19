# L-Kurtosis Method for Distribution Selection

Selects a probability distribution by minimizing the absolute distance
between the theoretical L-kurtosis (\\\tau_4\\) and the sample
L-kurtosis (\\t_4\\). Only supports 3-parameter distributions.

**For NS-FFA**: To select a distribution for a nonstationary model,
include the observation years (`ns_years`) and the nonstationary model
structure (`ns_structure`). Then, this method will detrend the original,
nonstationary data internally using the
[`data_decomposition()`](https://rileywheadon.github.io/ffa-framework/reference/data_decomposition.md)
function prior to distribution selection.

## Usage

``` r
select_lkurtosis(data, ns_years = NULL, ns_structure = NULL)
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

A list with the results of distribution selection:

- `method`: `"L-kurtosis"`.

- `decomposed_data`: The detrended dataset used to compute the
  L-moments. For S-FFA, this is the `data` argument. For NS-FFA, it is
  output of
  [`data_decomposition()`](https://rileywheadon.github.io/ffa-framework/reference/data_decomposition.md).

- `metrics`: A list of L-kurtosis metrics for each distribution.

- `recommendation`: Name of the distribution with the smallest
  L-kurtosis metric.

## Details

This method computes the distance between the sample and theoretical
L-kurtosis values at a fixed L-skewness. For three parameter
distributions, the shape parameter that best replicates the sample
L-skewness is determined using
[`stats::optim()`](https://rdrr.io/r/stats/optim.html).

## References

Hosking, J.R.M. & Wallis, J.R., 1997. Regional frequency analysis: an
approach based on L-Moments. Cambridge University Press, New York, USA.

## See also

[`utils_sample_lmoments()`](https://rileywheadon.github.io/ffa-framework/reference/utils_sample_lmoments.md),
[`select_ldistance()`](https://rileywheadon.github.io/ffa-framework/reference/select_ldistance.md),
[`select_zstatistic()`](https://rileywheadon.github.io/ffa-framework/reference/select_zstatistic.md),
[`plot_lmom_diagram()`](https://rileywheadon.github.io/ffa-framework/reference/plot_lmom_diagram.md)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
select_lkurtosis(data)
#> $method
#> [1] "L-kurtosis"
#> 
#> $decomposed_data
#>   [1] 103.82881  84.75453 115.51908 108.93561  89.86434 102.83165  78.20002
#>   [8] 108.99179  91.82589 102.34030 111.68716  96.10071 118.55209 109.18841
#>  [15]  83.45883 103.40270 100.71761  85.07593  86.31258  94.63554 106.15587
#>  [22] 101.38895  79.15934  95.10840 100.35663  92.24307 103.70938 112.11483
#>  [29]  99.52266  93.14484  94.57107 115.62576 101.10043  93.86485  97.69509
#>  [36] 115.57164  91.51644 105.06033  73.66186  98.49019 106.03342 107.87635
#>  [43]  86.69727  92.54724  96.98353 109.47820 101.95475  99.28724  94.80794
#>  [50]  95.50190 101.68082  90.31569 106.15631 101.67551  92.93685 117.58527
#>  [57] 111.86822 103.96519 102.15224 112.82334  98.21783  99.48067 107.67090
#>  [64]  89.57803 115.78823 101.77697  83.27083 113.38399  91.05972 104.25011
#>  [71] 112.73349  95.75745  88.97253 115.88814 103.90974 101.54135 102.02457
#>  [78]  96.98622 111.39300 110.77746 113.94699 114.79593  99.69284 114.18542
#>  [85] 103.01583  81.78148 117.90761  96.04238  93.24670  99.57414  96.65362
#>  [92] 104.30347 103.65524 106.83606 102.14753 103.42027 101.48384  88.46055
#>  [99]  94.29753  94.27765
#> 
#> $metrics
#> $metrics$GEV
#> [1] 0.01354166
#> 
#> $metrics$GLO
#> [1] 0.05089873
#> 
#> $metrics$GNO
#> [1] 0.006741266
#> 
#> $metrics$PE3
#> [1] 0.005789274
#> 
#> $metrics$LP3
#> [1] 0.002985263
#> 
#> $metrics$WEI
#> [1] 0.003571968
#> 
#> 
#> $recommendation
#> [1] "LP3"
#> 
```
