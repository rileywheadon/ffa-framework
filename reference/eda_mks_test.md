# Mann–Kendall–Sneyers Test for Change Point Detection

Performs the Mann–Kendall–Sneyers (MKS) test to detect a trend change in
annual maximum series data. The test computes normalized progressive and
regressive Mann–Kendall statistics and identifies statistically
significant crossing points, indicating potential change points. Under
the null hypothesis, there are no trend changes.

## Usage

``` r
eda_mks_test(data, years, alpha = 0.05)
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

- `progressive_series`: Normalized progressive Mann–Kendall-Sneyers
  statistics.

- `regressive_series`: Normalized regressive Mann–Kendall-Sneyers
  statistics.

- `bound`: Critical confidence bound for significance based on `alpha`.

- `change_points`: A dataframe of potential change points.

- `p_value`: Two-sided p-value of the most significant crossing point.

- `reject`: If `TRUE`, the null hypothesis was rejected at significance
  `alpha`.

`change_points` contains the years, test statistics, and p-values of
each potential change point. If no change points were identified,
`change_points` is empty.

## Details

This function computes progressive and regressive Mann–Kendall-Sneyers
statistics, normalized by their expected values and variances under the
null hypothesis. The crossing points occur when the difference between
the progressive and regressive statistics switches sign. The
significance of detected crossing points is assessed using the quantiles
of the normal distribution.

## References

Sneyers, R. (1990). On the statistical analysis of series of
observations. Technical note No. 143, World Meteorological Organization,
Geneva.

## See also

[`plot_mks_test()`](https://rileywheadon.github.io/ffa-framework/reference/plot_mks_test.md),
[`eda_pettitt_test()`](https://rileywheadon.github.io/ffa-framework/reference/eda_pettitt_test.md)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
years <- seq(from = 1901, to = 2000)
eda_mks_test(data, years)
#> $data
#>   [1] 105.74684 107.53031  92.67545  85.09204  98.48259  96.75074 111.55520
#>   [8]  98.43460 110.63326 102.35489 120.92595  83.07251  89.94641 116.74478
#>  [15]  95.62255 113.27158 114.27544  84.60421 111.82677 106.54959 113.19297
#>  [22]  95.98798  94.25990  81.96696 100.44151 100.24345 111.49112  97.26690
#>  [29]  94.35158 107.04075 105.20372 107.43372 101.73053 109.10044  93.58330
#>  [36]  88.93986  92.14111 105.30740 112.18120  84.70178 105.51114  94.83542
#>  [43]  96.01779 103.24808 107.26851  96.57706  94.41080  96.02413  99.10775
#>  [50] 110.40952 102.40919  96.55350  91.02249  98.98338  92.13937  90.92910
#>  [57] 114.08476 102.50388  94.02291  94.74065  94.91006  92.55806  91.13979
#>  [64] 118.16085  83.30854 111.22617 107.17357  96.59280  99.14638 103.38835
#>  [71]  96.73917 101.31666  98.82788 108.98828 110.77115 107.69158  85.54915
#>  [78]  85.71614  97.22417 101.68775 109.77722 102.96900  97.91774  96.94300
#>  [85] 102.01555  89.55891 110.86274  85.63202 104.14338  97.27396 109.76791
#>  [92]  93.27818 107.34289 103.56664 101.41236 103.49810 109.90516  95.04841
#>  [99] 101.62542 115.25917
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
#> [1] "There are no trend changes in the data."
#> 
#> $alternative_hypothesis
#> [1] "There is at least one trend change in the data."
#> 
#> $progressive_series
#>   [1]  0.00000000  1.00000000 -0.52223297 -1.35873244 -0.97979590 -0.93933644
#>   [7]  0.15018785  0.00000000  0.62554324  0.62609903  1.32344821  0.41143529
#>  [13] -0.12201778  0.49270401  0.14846150  0.63031524  1.07100832  0.41665471
#>  [19]  0.73469700  0.77866282  1.08708920  0.76134410  0.39615685 -0.19843522
#>  [25] -0.18683975 -0.19837396  0.06254073 -0.07902608 -0.33764511 -0.16056928
#>  [31] -0.08498208  0.09729872  0.09296648  0.31131331 -0.01420143 -0.38138504
#>  [37] -0.68010182 -0.56573571 -0.20564683 -0.58255173 -0.47174140 -0.63940597
#>  [43] -0.74304486 -0.66754131 -0.46955135 -0.57755726 -0.76114764 -0.85325187
#>  [49] -0.84474389 -0.57717519 -0.51169930 -0.61550395 -0.88980153 -0.88778781
#>  [55] -1.13974779 -1.39937192 -1.01880964 -0.91899407 -1.10517334 -1.23731804
#>  [61] -1.34414958 -1.54889085 -1.77339579 -1.37888208 -1.68709278 -1.41119654
#>  [67] -1.21759260 -1.23865596 -1.19128883 -1.06969790 -1.09696220 -1.03058438
#>  [73] -1.01914006 -0.79801188 -0.55348937 -0.35878889 -0.63335620 -0.89310186
#>  [79] -0.91863151 -0.85586046 -0.63623142 -0.54861039 -0.57810877 -0.62582013
#>  [85] -0.56173287 -0.80191695 -0.56090888 -0.81452504 -0.70168074 -0.72841758
#>  [91] -0.52452347 -0.69479704 -0.53101179 -0.43441402 -0.40188633 -0.31019286
#>  [97] -0.10596615 -0.23019749 -0.20255007  0.07743104
#> 
#> $regressive_series
#>   [1] -0.07743104 -0.19650380 -0.35910808 -0.17453248  0.09495700  0.13181872
#>   [7]  0.21230761 -0.02655059  0.01349120 -0.20226722 -0.25442336 -0.57410243
#>  [13] -0.27391108 -0.02566250 -0.33941601 -0.21254757 -0.50992751 -0.82980239
#>  [19] -0.53259257 -0.83199493 -1.00542830 -1.33349735 -1.22963300 -1.06439027
#>  [25] -0.74448694 -0.76390681 -0.77934494 -1.10486212 -1.06947436 -0.89841701
#>  [31] -1.08997653 -1.26380206 -1.50332603 -1.59639919 -1.87606128 -1.70973832
#>  [37] -1.43681830 -1.21587337 -1.41526106 -1.79219944 -1.46692345 -1.69372719
#>  [43] -1.53612878 -1.40430518 -1.56899275 -1.82214456 -1.73827361 -1.56482337
#>  [49] -1.43617589 -1.45387579 -1.81517414 -1.96532251 -1.86648848 -1.60482935
#>  [55] -1.61905396 -1.36952477 -1.07211180 -1.51748597 -1.65812057 -1.43768808
#>  [61] -1.21170759 -0.97984668 -0.69145476 -0.36620867 -0.87173722 -0.41184153
#>  [67] -0.90429104 -1.17757536 -0.90812138 -0.83282443 -0.98125671 -0.71280635
#>  [73] -0.63220862 -0.52117275 -0.85962048 -1.40129810 -1.83552582 -1.34693328
#>  [79] -0.87413582 -0.60393844 -0.58399712 -1.08455271 -1.24996413 -1.15339358
#>  [85] -0.90045034 -0.94025615 -0.38321423 -1.09815998 -0.41143529 -0.70064905
#>  [91] -0.26832816 -0.83405766  0.00000000 -0.45056356 -0.93933644 -0.48989795
#>  [97] -0.67936622 -1.56669890 -1.00000000  0.00000000
#> 
#> $bound
#> [1] 1.959964
#> 
#> $change_points
#> [1] index     year      value     statistic p_value  
#> <0 rows> (or 0-length row.names)
#> 
#> $p_value
#> [1] 0.1663118
#> 
#> $reject
#> [1] FALSE
#> 
```
