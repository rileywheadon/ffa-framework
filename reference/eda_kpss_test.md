# Kwiatkowski–Phillips–Schmidt–Shin (KPSS) Unit Root Test

Performs the KPSS unit root test on annual maximum series data. The null
hypothesis is that the time series is trend-stationary with a linear
deterministic trend and constant drift. The alternative hypothesis is
that the time series has a unit root (also known as a stochastic trend).

## Usage

``` r
eda_kpss_test(data, alpha = 0.05)
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

- `statistic`: The KPSS test statistic.

- `p_value`: The interpolated p-value. See the details for more
  information.

- `reject`: If `TRUE`, the null hypothesis was rejected at significance
  `alpha`.

## Details

The implementation of the KPSS test is based on the 'aTSA' package,
which interpolates a significance table from Hobijn et al. (2004).
Therefore, a result of \\p = 0.01\\ implies that \\p \leq 0.01\\ and a
result of \\p = 0.10\\ implies that \\p \geq 0.10\\.

## References

Hobijn, B., Franses, P.H. and Ooms, M. (2004), Generalizations of the
KPSS-test for stationarity. Statistica Neerlandica, 58: 483-502.

Kwiatkowski, D.; Phillips, P. C. B.; Schmidt, P.; Shin, Y. (1992).
Testing the null hypothesis of stationarity against the alternative of a
unit root. Journal of Econometrics, 54 (1-3): 159-178.

## See also

[`eda_pp_test()`](https://rileywheadon.github.io/ffa-framework/reference/eda_pp_test.md)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
eda_kpss_test(data)
#> $data
#>   [1]  97.99669  87.50984 102.95252  90.26103  73.53136 100.23273 111.47362
#>   [8] 115.61049  87.35983  88.33181  91.75555  94.76172  98.89976 121.99260
#>  [15]  95.34879 120.36984 100.39004  87.96905 119.83484  90.29670  85.67438
#>  [22] 104.83300 101.28824  84.71710 104.98693  86.50927  97.41662  83.55172
#>  [29]  98.98267  97.63843 106.02731 109.66670 107.35570 109.18831 102.81522
#>  [36] 109.64195  94.23139  97.94809 107.97812 108.19274 121.59665 104.90342
#>  [43] 111.42943 100.70440  93.71694  99.09350 105.10520  98.99026  81.75223
#>  [50] 112.77722  88.81335 110.26617 106.83853  90.09093  93.36497  98.52802
#>  [57]  99.89112 118.42932 103.24793 102.18773 106.94797  95.30401 100.08250
#>  [64]  80.78876 100.51796  94.84747  95.93285  92.80528  94.86763 105.97930
#>  [71] 109.77976  99.80091 114.75578 101.09780 100.12387  98.95186 107.50888
#>  [78]  97.77118  93.79625 113.14000 116.23621  88.10228 101.15881 116.18140
#>  [85]  99.90063  92.66700 106.42069 108.95565  91.35165 100.35780 107.02140
#>  [92] 110.87775 110.32847 112.30771  90.03516  90.82555  94.35715 103.97653
#>  [99]  99.42904  94.74145
#> 
#> $alpha
#> [1] 0.05
#> 
#> $null_hypothesis
#> [1] "The time series is trend-stationary."
#> 
#> $alternative_hypothesis
#> [1] "The time series has a unit root (stochastic trend)."
#> 
#> $statistic
#> [1] 0.05878783
#> 
#> $p_value
#> [1] 0.1
#> 
#> $reject
#> [1] FALSE
#> 
```
