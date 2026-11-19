# Spearman Test for Autocorrelation

Performs the Spearman serial correlation test on annual maximum series
data to check for serial correlation at various lags. Reports the
smallest lag where the serial correlation is not statistically
significant at the given significance level (the *least insignificant
lag*).

## Usage

``` r
eda_spearman_test(data, alpha = 0.05)
```

## Arguments

- data:

  Numeric vector of observed annual maximum series values. Must be
  strictly positive, finite, and not missing.

- alpha:

  Numeric scalar in \\\[0.01, 0.1\]\\. The significance level for
  confidence intervals or hypothesis tests. Default is 0.05.

## Value

A list containing the test results, including:

- `data`: The `data` argument.

- `alpha`: The significance level as specified in the `alpha` argument.

- `null_hypothesis`: A string describing the null hypothesis.

- `alternative_hypothesis`: A string describing the alternative
  hypothesis.

- `rho`: Numeric vector of serial correlation estimates for lags \\1\\
  to \\n-3\\.

- `least_lag`: The smallest lag at which the serial correlation is
  insignificant.

- `significant`: Indicates whether the serial correlation is significant
  at each lag.

- `reject`: If `TRUE`, the null hypothesis was rejected at significance
  `alpha`.

## See also

[`stats::cor.test()`](https://rdrr.io/r/stats/cor.test.html),
[`eda_bbmk_test()`](https://rileywheadon.github.io/ffa-framework/reference/eda_bbmk_test.md),
[`plot_spearman_test()`](https://rileywheadon.github.io/ffa-framework/reference/plot_spearman_test.md)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
eda_spearman_test(data)
#> $data
#>   [1] 106.31107 111.51340 102.09891  98.66040 107.10639 102.32650  93.56602
#>   [8]  82.17235 115.53949  97.62048  91.48151 103.99375  78.75553 109.02592
#>  [15] 109.87513  91.57034  75.35796  83.06758 111.02988 110.79918  97.81132
#>  [22] 115.99110  97.49414 114.96522 104.48972 101.82078  93.83436  86.25984
#>  [29]  92.93219 108.05278 101.79365 100.54119  84.71055 104.00399  96.18705
#>  [36] 100.58256 103.80280 101.53855 114.89921 104.92200 103.21021 101.94214
#>  [43] 107.42460 116.84394  92.50584 104.87693 100.38928  91.57844 110.66950
#>  [50] 112.50907  99.43985 111.01152 108.60272  94.35932  79.94742 102.48602
#>  [57] 102.09311 105.64982 104.92798  97.24127 102.44770 101.24951 102.63553
#>  [64]  93.00900  79.43679 102.37812  99.58353 106.73590  90.05232 106.93567
#>  [71] 105.46208 113.96973  95.44503 104.04250 103.99922  76.23319 104.59000
#>  [78] 111.99336 106.43052 102.14418 113.51713  86.05348  86.47162 106.82030
#>  [85]  93.79462 101.08264 111.23510  95.33119 103.83775  77.06348 117.92758
#>  [92]  78.22464  91.43614 109.47363 105.26578  81.73983 112.47440  99.33391
#>  [99] 109.85445 112.67286
#> 
#> $alpha
#> [1] 0.05
#> 
#> $null_hypothesis
#> [1] "There is no autocorrelation in the data."
#> 
#> $alternative_hypothesis
#> [1] "There is autocorrelation in the data."
#> 
#> $rho
#>  [1] -0.121311070 -0.102882390  0.059028508 -0.060200760 -0.056438970
#>  [6]  0.033370661 -0.028229537 -0.117180155 -0.005621914  0.260764703
#> [11] -0.220020429 -0.158060653  0.047222425 -0.107806972 -0.103752199
#> [16] -0.022840944 -0.056084967 -0.057955399  0.230691057  0.139357712
#> [21] -0.015262902  0.102998268 -0.102345023 -0.142829802  0.118833570
#> [26] -0.216349500 -0.007065284  0.295324458  0.169986586 -0.100481148
#> [31]  0.039313117 -0.049776692 -0.230505228  0.079344536  0.027884615
#> [36] -0.227884615  0.122743856  0.296265518 -0.158963511 -0.153876077
#> [41]  0.102805377 -0.048140515 -0.162172673  0.055297334 -0.129581530
#> [46] -0.308252335  0.298661506  0.306838555 -0.096289593  0.090708283
#> [51]  0.048571429 -0.111159357  0.013644773 -0.048535307  0.011198946
#> [56]  0.133333333  0.257173059  0.009318532  0.085888502 -0.014446529
#> [61] -0.051012146 -0.135353977  0.017069701 -0.242985843  0.170308123
#> [66] -0.055156608  0.021724599 -0.255865103  0.281854839 -0.086095662
#> [71] -0.260098522  0.275862069 -0.108669109 -0.333333333  0.393846154
#> [76]  0.066956522  0.106719368  0.046866177  0.262337662  0.063157895
#> [81] -0.305263158  0.219814241 -0.328431373 -0.326470588  0.532142857
#> [86]  0.129670330 -0.538461538  0.041958042 -0.145454545 -0.187878788
#> [91] -0.100000000 -0.166666667 -0.607142857 -0.314285714  0.500000000
#> [96] -0.800000000 -0.500000000
#> 
#> $least_lag
#> [1] 1
#> 
#> $significant
#>  [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE FALSE
#> [13] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
#> [25] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
#> [37] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE
#> [49] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
#> [61] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
#> [73] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
#> [85]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
#> [97] FALSE
#> 
#> $reject
#> [1] FALSE
#> 
```
