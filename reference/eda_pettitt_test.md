# Pettitt Test for Abrupt Changes in the Mean of a Time Series

Performs the nonparametric Pettitt test to detect a single abrupt change
in the central tendency of a time series. Under the null hypothesis,
there is no change.

## Usage

``` r
eda_pettitt_test(data, years, alpha = 0.05)
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

A list containing the test results, including:

- `data`: The `data` argument.

- `years`: The `years` argument.

- `alpha`: The significance level as specified in the `alpha` argument.

- `null_hypothesis`: A string describing the null hypothesis.

- `alternative_hypothesis`: A string describing the alternative
  hypothesis.

- `u_series`: Numeric vector of absolute U-statistics for all years.

- `statistic`: The test statistic and maximum absolute U-statistic.

- `bound`: The critical value of the test statistic based on `alpha`.

- `change_points`: A dataframe containing the potential change point.

- `p_value`: An asymptotic approximation of the p-value for the test.

- `reject`: Logical scalar. If `TRUE`, the null hypothesis was rejected.

`change_points` contains the years, test statistics, and p-values of
each potential change point. If no change points were identified,
`change_points` is empty.

## References

Pettitt, A.N., 1979. A Non-parametric Approach to the Change-point
Problem. J. Royal Statistics Society 28 (2), 126–135.
<http://www.jstor.org/stable/2346729>

## See also

[`plot_pettitt_test()`](https://rileywheadon.github.io/ffa-framework/reference/plot_pettitt_test.md),
[`eda_mks_test()`](https://rileywheadon.github.io/ffa-framework/reference/eda_mks_test.md)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
years <- seq(from = 1901, to = 2000)
eda_pettitt_test(data, years)
#> $data
#>   [1] 102.32179  94.17772  98.77404 105.29167 110.10684 109.21671  99.00200
#>   [8]  94.00343  89.97952  96.54386  96.87132 118.40742  81.72863 100.76640
#>  [15] 100.55287 103.52433  99.65863 104.98293 123.86866  86.82425  89.81833
#>  [22]  78.07199 109.07017 105.91076  95.54329 109.39690  79.70020  95.64596
#>  [29]  94.12719 107.52656 106.84281  90.71340 103.15814 101.68861  89.16990
#>  [36]  94.98362 107.85188 104.65562 106.01239  98.39976  97.98901 103.80865
#>  [43] 104.51256  96.98454  85.77457  88.90572  99.96630 121.10423 111.00964
#>  [50]  87.02501  87.80226  95.98337 124.83532 100.11715  88.47333 112.44132
#>  [57] 119.73193  89.69074 106.60512 106.76343 112.06801  90.97239 104.50397
#>  [64] 107.26423 112.04740 113.73421  93.75126 100.81992 112.55942  88.79528
#>  [71]  87.33852 100.56045 113.85555  98.87681  79.61201  93.19376  92.09872
#>  [78]  93.18624 103.82141 102.02935 112.10449  85.42835 107.26397  88.20753
#>  [85] 108.59298 100.01181  90.54158 111.24859 116.50599  99.71808  95.68262
#>  [92] 109.62970 101.42725  92.26551  98.38343 102.72831 111.78279  99.34285
#>  [99]  96.73675 106.16976
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
#> [1] "There are no abrupt changes in the mean of the data."
#> 
#> $alternative_hypothesis
#> [1] "There is one abrupt change in the mean of the data."
#> 
#> $u_series
#>   [1]  15  28  45  10  57 118 105  58   7  38  65  26  67  62  61  40  49  16
#>  [19]  81   6  73 172 113  76 115  52 147 184 229 176 129 190 171 160 231 272
#>  [37] 217 186 147 166 189 166 137 162 251 324 329 234 165 250 331 364 265 266
#>  [55] 343 262 169 238 195 150  73 132 105  54  21 106  57  64 147  72  11   8
#>  [73]  79  64  33  84 141 194 169 156  77 168 119 198 141 144 207 136  47  54
#>  [91]  89  24  15  70  91  74   1  12  41  41
#> 
#> $statistic
#> [1] 364
#> 
#> $bound
#> [1] 710.1279
#> 
#> $p_value
#> [1] 0.455
#> 
#> $change_points
#> [1] index     year      value     statistic p_value  
#> <0 rows> (or 0-length row.names)
#> 
#> $reject
#> [1] FALSE
#> 
```
