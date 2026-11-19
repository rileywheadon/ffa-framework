# L-Distance Method for Distribution Selection

Selects a distribution from a set of candidate distributions by
minimizing the Euclidean distance between the theoretical L-moment
ratios \\(\tau_3, \tau_4)\\ and the sample L-moment ratios \\(t_3,
t_4)\\.

**For NS-FFA**: To select a distribution for a nonstationary model,
include the observation years (`ns_years`) and the nonstationary model
structure (`ns_structure`). Then, this method will detrend the original,
nonstationary data internally using the
[`data_decomposition()`](https://rileywheadon.github.io/ffa-framework/reference/data_decomposition.md)
function prior to distribution selection.

## Usage

``` r
select_ldistance(data, ns_years = NULL, ns_structure = NULL)
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

- `method`: `"L-distance"`.

- `decomposed_data`: The detrended dataset used to compute the
  L-moments. For S-FFA, this is the `data` argument. For NS-FFA, it is
  output of
  [`data_decomposition()`](https://rileywheadon.github.io/ffa-framework/reference/data_decomposition.md).

- `metrics`: A list of L-distance metrics for each candidate
  distribution.

- `recommendation`: The name of the distribution with the smallest
  L-distance.

## Details

For each candidate distribution, this method computes the Euclidean
distance between sample L-moment ratios (\\\tau_3\\, \\\tau_4\\) and the
closest point on the theoretical distribution's L-moment curve. For
two-parameter distributions (Gumbel, Normal, Log-Normal), the
theoretical L-moment ratios are compared directly with the sample
L-moment ratios. The distribution with the minimum distance is selected.
If a distribution is fit to log-transformed data (Log-Normal or
Log-Pearson Type III), the L-moment ratios for the log-transformed
sample are used instead.

## References

Hosking, J.R.M. & Wallis, J.R., 1997. Regional frequency analysis: an
approach based on L-Moments. Cambridge University Press, New York, USA.

## See also

[`utils_sample_lmoments()`](https://rileywheadon.github.io/ffa-framework/reference/utils_sample_lmoments.md),
[`select_lkurtosis()`](https://rileywheadon.github.io/ffa-framework/reference/select_lkurtosis.md),
[`select_zstatistic()`](https://rileywheadon.github.io/ffa-framework/reference/select_zstatistic.md),
[`plot_lmom_diagram()`](https://rileywheadon.github.io/ffa-framework/reference/plot_lmom_diagram.md)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
select_ldistance(data)
#> $method
#> [1] "L-distance"
#> 
#> $decomposed_data
#>   [1] 106.41730  97.50642  92.20363  99.21899  96.04957 114.14774 101.63967
#>   [8] 104.77651 111.50617  93.01748 108.43079 101.83940  84.74015 100.30502
#>  [15] 103.91364 111.68783 102.70442  99.99870 103.99856 104.26275 100.95241
#>  [22]  93.06944  99.79682  84.36760 116.78766 115.72828 108.47402 101.86506
#>  [29] 100.83907 100.44835  92.16388 104.37525 100.64526 117.51374 123.93920
#>  [36]  86.48650  91.23583 100.06926 118.90688 108.71241 107.99039  90.80398
#>  [43]  97.22992 105.48696  99.87668 100.29321  82.87574  99.85701  97.24858
#>  [50]  91.63018 102.20153  88.79010 113.90488 105.58278 106.03350  93.29528
#>  [57]  87.69856  90.69000  94.56297 102.55919 100.97977  90.50982  84.67961
#>  [64] 100.37997  98.56589  92.15985  83.43505  83.47542 110.29180 105.63245
#>  [71] 104.67738 103.79357 102.88949  96.73298  87.81372  93.62839  99.68228
#>  [78] 105.76224 102.39219  93.81425  88.49694  93.53972 118.18144 100.28286
#>  [85] 101.79684 107.31351 106.59529  83.27724 105.07029  91.57636  93.13937
#>  [92]  92.67738  87.11110  86.76845 100.65329  93.10729 109.80518  91.62498
#>  [99] 106.26097  95.87355
#> 
#> $metrics
#> $metrics$GUM
#> [1] 0.1530925
#> 
#> $metrics$NOR
#> [1] 0.02007175
#> 
#> $metrics$LNO
#> [1] 0.02349555
#> 
#> $metrics$GEV
#> [1] 0.01003558
#> 
#> $metrics$GLO
#> [1] 0.04705083
#> 
#> $metrics$GNO
#> [1] 0.002989556
#> 
#> $metrics$PE3
#> [1] 0.002796653
#> 
#> $metrics$LP3
#> [1] 0.006788691
#> 
#> $metrics$WEI
#> [1] 0.01459919
#> 
#> 
#> $recommendation
#> [1] "PE3"
#> 
```
