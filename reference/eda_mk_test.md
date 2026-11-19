# Mann–Kendall Trend Test

Performs the Mann–Kendall trend test on a numeric vector to detect the
presence of an increasing or decreasing monotonic trend over time. The
test is nonparametric and accounts for tied observations in the data.
The null hypothesis assumes there is no monotonic trend.

## Usage

``` r
eda_mk_test(data, alpha = 0.05)
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

- `statistic`: The Mann–Kendall test statistic.

- `variance`: The variance of the test statistic under the null
  hypothesis.

- `p_value`: The p-value associated with the two-sided hypothesis test.

- `reject`: Logical. If `TRUE`, the null hypothesis is rejected at
  `alpha`.

## Details

The test statistic \\S\\ is the sum over all pairs \\i \< j\\ of *the
sign of the difference* \\x_j - x_i\\. Ties are explicitly accounted for
when calculating the variance of \\S\\, using grouped frequencies of
tied observations. The test statistic \\Z\\ is then computed based on
the sign and magnitude of \\S\\, and the p-value is derived from the
standard normal distribution.

## References

Kendall, M. (1975). Rank Correlation Methods. Griffin, London, 202 pp.

Mann, H. B. (1945). Nonparametric Tests Against Trend. Econometrica,
13(3): 245-25

## See also

[`eda_bbmk_test()`](https://rileywheadon.github.io/ffa-framework/reference/eda_bbmk_test.md)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
eda_mk_test(data)
#> $data
#>   [1] 104.28256  89.53636 116.11412  90.69241 103.37862 105.22782  82.64148
#>   [8] 109.39183 105.45024  84.75166  94.25823 111.23967  86.69933  97.37938
#>  [15]  96.58283 111.08042 114.25324  99.55259  98.79250 106.57130 110.35033
#>  [22]  88.61991  93.08293 100.83571 104.75665 102.37172  92.25124 103.24165
#>  [29] 108.40478 116.61977 111.01600 108.00191 104.89789 108.15966  75.26442
#>  [36]  89.19149 105.21227  86.71029 118.16608 102.27068  87.32682 106.03875
#>  [43]  88.81822 103.22338 102.98355 114.61274 119.20752  89.24305  93.12479
#>  [50] 106.15612  99.96043 100.60333  97.72133  91.09217  99.29099  87.82165
#>  [57]  96.03174 116.78254 119.72330  98.41525  96.38403  92.93475 108.29597
#>  [64]  92.21121  96.49941  94.03990  95.46888  87.32682  93.65167 106.19333
#>  [71] 105.58708  99.05894  99.19472 100.19550  97.85936 107.34841  99.84156
#>  [78]  88.23479  97.79369 115.64516 111.22041 104.63076 106.33357  95.12631
#>  [85]  89.60322  75.68793 102.59373  96.36258 110.89977 107.88251 105.74549
#>  [92]  98.24206 100.42963 101.62222  97.24310  99.82175 102.24486  83.05105
#>  [99]  98.18668 108.51155
#> 
#> $alpha
#> [1] 0.05
#> 
#> $null_hypothesis
#> [1] "There is no monotonic trend in the mean of the data."
#> 
#> $alternative_hypothesis
#> [1] "There is a monotonic trend in the mean of the data."
#> 
#> $statistic
#> [1] -116
#> 
#> $variance
#> [1] 112750
#> 
#> $p_value
#> [1] 0.7319871
#> 
#> $reject
#> [1] FALSE
#> 
```
