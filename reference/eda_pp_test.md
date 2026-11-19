# Phillips–Perron Unit Root Test

Applies the Phillips–Perron (PP) test to check for a unit root in annual
maximum series data. The null hypothesis assumes the time series
contains a unit root (also known as a stochastic trend). The alternative
hypothesis is that the time series is trend-stationary with a
deterministic linear trend.

## Usage

``` r
eda_pp_test(data, alpha = 0.05)
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

- `statistic`: The PP test statistic.

- `p_value`: Reported p-value from the test. See the details for more
  information.

- `reject`: If `TRUE`, the null hypothesis was rejected at significance
  `alpha`.

## Details

The implementation of this test is based on the 'aTSA' package, which
interpolates p-values from the table of critical values presented in
Fuller W. A. (1996). The critical values are only available for \\\alpha
\geq 0.01\\. Therefore, a reported p-value of 0.01 indicates that \\p
\leq 0.01\\.

## References

Fuller, W. A. (1976). Introduction to Statistical Time Series. New York:
John Wiley and Sons

Phillips, P. C. B.; Perron, P. (1988). Testing for a Unit Root in Time
Series Regression. Biometrika, 75 (2): 335-346

## See also

[`eda_kpss_test()`](https://rileywheadon.github.io/ffa-framework/reference/eda_kpss_test.md)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
eda_pp_test(data)
#> $data
#>   [1] 114.48573 104.01289 107.36656 106.75189 100.92422 105.71910  95.62950
#>   [8] 115.22793  90.09813 101.21090 105.45931 108.28352  94.04016  97.61715
#>  [15] 104.73747 103.40918  96.95804 107.33999 103.13770 111.29980 103.81615
#>  [22] 103.68654 108.84609 109.21164 117.78567  92.96911  75.93637  99.68249
#>  [29]  97.04275 106.00636 111.60364 100.56538  95.59872  98.35395  90.02786
#>  [36]  76.48258  97.01634  78.53935  97.08140  93.10026  94.97523 106.05890
#>  [43]  97.37607  96.90605 119.81818  94.51492  92.73484 101.06323 114.59809
#>  [50]  93.10381 114.15768 100.04895 101.07439  98.37847  89.26774 100.03078
#>  [57] 110.44615  98.93937 107.17062  87.33825  69.94219 108.75675 106.93614
#>  [64] 112.83858 109.99143  86.73613  81.15200 101.48586  99.01536  91.65490
#>  [71] 102.34030 104.16639  89.90877  92.40957  81.75752  98.91953 104.97110
#>  [78] 115.84434 105.76548 116.35644 105.87302  91.87373 100.21493 102.16915
#>  [85] 106.43384  90.75542 112.09305 115.66475 106.29210  93.57340 109.91148
#>  [92] 123.90197 111.88599 107.95127 112.67272  96.37174  90.85030 109.63619
#>  [99] 110.11232 103.51880
#> 
#> $alpha
#> [1] 0.05
#> 
#> $null_hypothesis
#> [1] "The time series has a unit root (stochastic trend)."
#> 
#> $alternative_hypothesis
#> [1] "The time series is trend-stationary."
#> 
#> $statistic
#> [1] -76.92581
#> 
#> $p_value
#> [1] 0.01
#> 
#> $reject
#> [1] TRUE
#> 
```
