# Wald–Wolfowitz Runs Test for Randomness

Applies the Wald–Wolfowitz runs test to a numeric vector in order to
assess whether it behaves as a random sequence. The test statistic and
p-value is computed using the number of runs (sequences of values above
or below the median). Under the null hypothesis, the data is random. The
runs test can be used to assess whether the residuals of a nonstationary
model are random, indicating the suitability of the assumed
nonstationary structure (e.g., linear).

## Usage

``` r
eda_runs_test(values, years, alpha = 0.05)
```

## Arguments

- values:

  A numeric vector of values to check for randomness.

- years:

  Numeric vector of observation years corresponding to `data`. Must be
  the same length as `data` and strictly increasing.

- alpha:

  Numeric scalar in \\\[0.01, 0.1\]\\. The significance level for
  confidence intervals or hypothesis tests. Default is 0.05.

## Value

A list containing the test results, including:

- `values`: The `values` argument.

- `years`: The `years` argument.

- `alpha`: The significance level as specified in the `alpha` argument.

- `null_hypothesis`: A string describing the null hypothesis.

- `alternative_hypothesis`: A string describing the alternative
  hypothesis.

- `n`: The length of the input vector after removing the median.

- `runs`: The number of runs in the transformed sequence of residuals.

- `statistic`: The runs test statistic, computed using `runs` and `n`.

- `p_value`: The p-value derived from the normally distributed test
  statistic.

- `reject`: If `TRUE`, the null hypothesis was rejected at significance
  `alpha`.

## References

Wald, A. and Wolfowitz, J. (1940). On a test whether two samples are
from the same population. Annals of Mathematical Statistics, 11(2),
147–162.

## See also

[`plot_runs_test()`](https://rileywheadon.github.io/ffa-framework/reference/plot_runs_test.md),
[`eda_sens_trend()`](https://rileywheadon.github.io/ffa-framework/reference/eda_sens_trend.md)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
years <- seq(from = 1901, to = 2000)
sens_trend <- eda_sens_trend(data, years)
eda_runs_test(sens_trend$residuals, years)
#> $values
#>   [1] -11.1811504   0.1813396   4.7454730 -10.8880522  14.1009983  -6.9744116
#>   [7]   3.8594646   0.1179816   4.4232752  -5.3944831  -3.8118586   6.0796046
#>  [13]  18.6109728   8.0523176 -19.1905649   3.3475184  -4.7300758 -13.9068704
#>  [19]  15.9657215   9.7464862   7.7745552  -2.6473865  12.3617314   5.2088744
#>  [25]   5.8794926  -0.4998067  -9.0551466   0.2994776  -3.0885424  -7.2914623
#>  [31]  -6.6800494   3.9648871  -0.1103550  13.8614350 -13.4078925  -2.8416450
#>  [37]  -6.7959925 -13.7380449  -5.5134050 -12.4892024  -4.4211694  -6.2902870
#>  [43]   3.9400006   7.0702324   9.7560836  10.2978077  -3.9575196   1.6099458
#>  [49] -11.1824095   8.0327728   1.1820968  -5.3976147  19.1468697   2.8173864
#>  [55]  -3.4920803 -10.5430969 -10.0687441 -17.7297570 -13.6401057   0.1103550
#>  [61]  13.1555327   4.4518997  -3.9178251  -8.8086801  -0.7179394  17.0858322
#>  [67] -15.1442591  -6.5591243   8.0105343   6.1723651 -11.3495674   6.8525739
#>  [73]  -1.6239892   2.3815087  13.1740005  -2.3523493   1.4719670   5.4961329
#>  [79]  11.0722922  22.2410008 -13.2386646 -12.3409635 -12.8754792  -4.8746026
#>  [85]  -4.6004829   4.6351329 -16.2437076   1.6228738  -2.3394821  -8.8800255
#>  [91]   4.0648925   4.2647139  -9.1577516  14.3062453 -10.8856651   2.9131349
#>  [97]  11.4939467  21.7255980  16.2202639 -17.4777905
#> 
#> $years
#>   [1] 1901 1902 1903 1904 1905 1906 1907 1908 1909 1910 1911 1912 1913 1914 1915
#>  [16] 1916 1917 1918 1919 1920 1921 1922 1923 1924 1925 1926 1927 1928 1929 1930
#>  [31] 1931 1932 1933 1934 1935 1936 1937 1938 1939 1940 1941 1942 1943 1944 1945
#>  [46] 1946 1947 1948 1949 1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 1960
#>  [61] 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975
#>  [76] 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990
#>  [91] 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000
#> 
#> $alpha
#> [1] 0.05
#> 
#> $null_hypothesis
#> [1] "The input vector is random."
#> 
#> $alternative_hypothesis
#> [1] "The input vector is not random."
#> 
#> $n
#> [1] 100
#> 
#> $runs
#> [1] 51
#> 
#> $statistic
#> [1] 0
#> 
#> $p_value
#> [1] 1
#> 
#> $reject
#> [1] FALSE
#> 
```
