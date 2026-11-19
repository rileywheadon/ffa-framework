# Maximum Likelihood Parameter Estimation

Estimates the parameters of a probability distribution by maximizing the
log‐likelihood. Initial parameter estimates are obtained using the
method of L‐moments and optimization is performed via
[`stats::nlminb()`](https://rdrr.io/r/stats/nlminb.html) with repeated
perturbations if needed.

**For NS-FFA**: To estimate parameters for a nonstationary model,
include the observation years (`ns_years`) and the nonstationary model
structure (`ns_structure`).

## Usage

``` r
fit_mle(data, distribution, ns_years = NULL, ns_structure = NULL)
```

## Arguments

- data:

  Numeric vector of observed annual maximum series values. Must be
  strictly positive, finite, and not missing.

- distribution:

  A three-character code indicating the distribution family. Must be
  `"GUM"`, `"NOR"`, `"LNO"`, `"GEV"`, `"GLO"`, `"GNO"`, `"PE3"`,
  `"LP3"`, or `"WEI"`.

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

A list containing the results of parameter estimation:

- `data`: The `data` argument.

- `distribution`: The `distribution` argument.

- `ns_years`: The `ns_years` argument, if given.

- `ns_structure`: The `ns_structure` argument, if given.

- `method`: `"MLE"`.

- `params`: Numeric vector of estimated parameters.

- `mll`: The maximum value of the log‐likelihood.

## Details

1.  Calls
    [`fit_lmoments()`](https://rileywheadon.github.io/ffa-framework/reference/fit_lmoments.md)
    on `data` to obtain initial parameter estimates.

2.  Initializes trend parameters to zero if necessary.

3.  For `WEI` models, sets the location parameter to zero to ensure
    support.

4.  Defines an objective function using
    [`utils_log_likelihood()`](https://rileywheadon.github.io/ffa-framework/reference/utils_log_likelihood.md).

5.  Runs [`stats::nlminb()`](https://rdrr.io/r/stats/nlminb.html) with
    box constraints. Attempts minimization up to 100 times.

## See also

[`utils_log_likelihood()`](https://rileywheadon.github.io/ffa-framework/reference/utils_log_likelihood.md),
[`fit_lmoments()`](https://rileywheadon.github.io/ffa-framework/reference/fit_lmoments.md),
[`stats::nlminb()`](https://rdrr.io/r/stats/nlminb.html)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
ns_years <- seq(from = 1901, to = 2000)
ns_structure <- list(location = TRUE, scale = FALSE)
fit_mle(data, "GNO", ns_years, ns_structure)
#> $data
#>   [1]  85.38698 102.77775 112.91988  81.80512  94.74878 104.12961  86.15792
#>   [8]  93.61056  90.67634 107.98288  93.72856  93.11586 114.25064  96.89832
#>  [15]  85.21415 103.60718 118.07402  92.29831 116.30787  96.94046  88.75006
#>  [22] 110.70093 106.80362 106.80181  78.45343  90.59212 113.49160 107.58402
#>  [29] 105.77168  97.74529  92.92667  87.12961  97.34649 103.17341 114.52780
#>  [36] 114.82291  84.09064  97.41627  80.09692 112.52924  84.14193 105.79051
#>  [43]  92.79212  77.79175  94.06701  91.08944 102.43396 100.58815 112.30860
#>  [50]  93.74515 100.52105 103.26004 107.44203  97.91168 119.01198  86.81093
#>  [57]  95.02666  97.24043  78.01471 105.61307 103.25924 100.08636 111.09707
#>  [64] 127.78743  87.27984 123.72900  97.47131 102.77547  87.47706  94.13426
#>  [71]  96.19866 118.04711 105.96198 114.36962 115.87495 115.10900 108.80649
#>  [78] 109.96885 111.57981  94.25167  87.46057 106.31133 109.05409 107.89903
#>  [85] 114.14477 103.67402 102.26379 108.00647  94.50523  87.72731  99.77925
#>  [92] 108.63950 112.97008  96.02339  84.07061 102.54378  82.27624 100.78716
#>  [99]  86.00637 132.19060
#> 
#> $distribution
#> [1] "GNO"
#> 
#> $ns_years
#>   [1] 1901 1902 1903 1904 1905 1906 1907 1908 1909 1910 1911 1912 1913 1914 1915
#>  [16] 1916 1917 1918 1919 1920 1921 1922 1923 1924 1925 1926 1927 1928 1929 1930
#>  [31] 1931 1932 1933 1934 1935 1936 1937 1938 1939 1940 1941 1942 1943 1944 1945
#>  [46] 1946 1947 1948 1949 1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 1960
#>  [61] 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975
#>  [76] 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990
#>  [91] 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000
#> 
#> $ns_structure
#> $ns_structure$location
#> [1] TRUE
#> 
#> $ns_structure$scale
#> [1] FALSE
#> 
#> 
#> $prior
#> NULL
#> 
#> $method
#> [1] "MLE"
#> 
#> $params
#> [1] 97.21033938  6.28508222 11.39512609 -0.03537097
#> 
#> $mll
#> [1] -385.2123
#> 
```
