# White Test for Heteroskedasticity

Performs the White test for heteroskedasticity by regressing the squared
residuals of a linear model on the original regressors and their squared
terms. The null hypothesis is homoskedasticity.

## Usage

``` r
eda_white_test(data, years, alpha = 0.05)
```

## Arguments

- data:

  Numeric vector of observed annual maximum series values. Must be
  strictly positive, finite, and not missing.

- years:

  Numeric vector of observation years corresponding to `data`. Must be
  the same length as `data` and strictly increasing.

- alpha:

  Numeric scalar in \\\[0.01, 0.1\]\\. The significance level for
  confidence intervals or hypothesis tests. Default is 0.05.

## Value

A list containing the results of the White test:

- `data`: The `data` argument.

- `years`: The `years` argument.

- `alpha`: The significance level as specified in the `alpha` argument.

- `null_hypothesis`: A string describing the null hypothesis.

- `alternative_hypothesis`: A string describing the alternative
  hypothesis.

- `statistic`: White test statistic based on sample size and
  `r_squared`.

- `p_value`: The p-value derived from a Chi-squared distribution with
  `df = 2`.

- `reject`: If `TRUE`, the null hypothesis was rejected at significance
  `alpha`.

## Details

The White test regresses the squared residuals from a primary linear
model `lm(data ~ years)` against both the original regressor and its
square. The test statistic is calculated as \\nR^2\\, where \\R^2\\ is
the coefficient of determination from the auxiliary regression and \\n\\
is the number of elements in the time series. Under the null hypothesis,
the test statistic has the \\\chi^2\\ distribution with 2 degrees of
freedom.

## References

White, H. (1980). A heteroskedasticity-consistent covariance matrix
estimator and a direct test for heteroskedasticity. *Econometrica*,
48(4), 817–838.

## See also

[`stats::lm()`](https://rdrr.io/r/stats/lm.html),
[`stats::pchisq()`](https://rdrr.io/r/stats/Chisquare.html)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
years <- seq(from = 1901, to = 2000)
eda_white_test(data, years)
#> $data
#>   [1] 100.08714  87.93782  95.52039  88.28031 107.00460 115.12215 101.99070
#>   [8]  93.67655  94.53010 106.48141 101.00782  82.42012 109.38275  84.40313
#>  [15]  97.26097 107.97217  96.08833 109.67785  93.54223 100.93528 107.62956
#>  [22]  94.67642  97.07130 102.06642  79.20201 108.58147 107.13222  84.83731
#>  [29] 109.16774  89.74668  91.85919 108.46643  94.93178 107.50644 106.77331
#>  [36] 101.41293  85.65508  86.16541  92.84438 122.92140  90.07804 104.59519
#>  [43]  97.62281 108.35991  93.65053  80.76932  98.64659 108.60061 113.31049
#>  [50]  83.67603  97.24631  97.62521 107.06400  99.04726 127.25076 106.30267
#>  [57]  88.88680  96.44126 110.38200  87.75264  93.26501 118.97439  96.53224
#>  [64]  78.59880 124.76428  95.97234 103.79369  92.51198 105.05991  94.64354
#>  [71] 103.41252  92.41732  95.76410  88.48226 115.30293 101.12761  98.74202
#>  [78]  85.32868 109.61289 109.64497 112.58596  84.62194 107.85550 103.97192
#>  [85] 106.98846 104.50714 106.40800 112.20660 110.78431  96.80989  87.26127
#>  [92]  93.49333  92.57200  87.74771  96.87723 110.71671  98.46020  91.09966
#>  [99]  84.26416 105.62013
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
#> [1] "The data is homoskedastic."
#> 
#> $alternative_hypothesis
#> [1] "The data is heteroskedastic."
#> 
#> $statistic
#> [1] 2.484357
#> 
#> $p_value
#> [1] 0.2887545
#> 
#> $reject
#> [1] FALSE
#> 
```
