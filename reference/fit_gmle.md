# Generalized Maximum Likelihood Parameter Estimation

Estimates the parameters of the generalized extreme value (GEV)
distribution by maximizing the generalized log‐likelihood, which
incorporates a Beta prior on the shape parameter. Initial parameter
estimates are obtained using the method of L‐moments and optimization is
performed via [`stats::nlminb()`](https://rdrr.io/r/stats/nlminb.html)
with repeated perturbations if needed.

**For NS-FFA**: To estimate parameters for a nonstationary model,
include the observation years (`ns_years`) and the nonstationary model
structure (`ns_structure`).

## Usage

``` r
fit_gmle(data, prior, ns_years = NULL, ns_structure = NULL)
```

## Arguments

- data:

  Numeric vector of observed annual maximum series values. Must be
  strictly positive, finite, and not missing.

- prior:

  Numeric vector of length 2. Specifies the parameters of the Beta prior
  for the shape parameter \\\kappa\\.

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

- `prior`: The `prior` argument.

- `ns_years`: The `ns_years` argument, if given.

- `ns_structure`: The `ns_structure` argument, if given.

- `method`: `"GMLE"`.

- `params`: Numeric vector of estimated parameters.

- `mll`: The maximum value of the generalized log‐likelihood.

## Details

1.  Calls
    [`fit_lmoments()`](https://rileywheadon.github.io/ffa-framework/reference/fit_lmoments.md)
    on the data to obtain initial parameter estimates.

2.  Initializes trend parameters to zero if necessary.

3.  Defines an objective function using
    [`utils_generalized_likelihood()`](https://rileywheadon.github.io/ffa-framework/reference/utils_generalized_likelihood.md).

4.  Runs [`stats::nlminb()`](https://rdrr.io/r/stats/nlminb.html) with
    box constraints. Attempts minimization up to 100 times.

## References

El Adlouni, S., Ouarda, T.B.M.J., Zhang, X., Roy, R., Bobee, B., 2007.
Generalized maximum likelihood estimators for the nonstationary
generalized extreme value model. Water Resources Research 43 (3), 1–13.
[doi:10.1029/2005WR004545](https://doi.org/10.1029/2005WR004545)

Martins, E. S., and Stedinger, J. R. (2000). Generalized
maximum-likelihood generalized extreme-value quantile estimators for
hydrologic data. Water Resources Research, 36(3), 737–744.
[doi:10.1029/1999WR900330](https://doi.org/10.1029/1999WR900330)

## See also

[`utils_generalized_likelihood()`](https://rileywheadon.github.io/ffa-framework/reference/utils_generalized_likelihood.md),
[`fit_lmoments()`](https://rileywheadon.github.io/ffa-framework/reference/fit_lmoments.md),
[`stats::nlminb()`](https://rdrr.io/r/stats/nlminb.html)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
prior <- c(6, 9)
ns_years <- seq(from = 1901, to = 2000)
ns_structure <- list(location = TRUE, scale = FALSE)
fit_gmle(data, prior, ns_years, ns_structure)
#> $data
#>   [1]  94.57179 111.64665 103.88534 108.28514 100.32738  93.51255  98.24003
#>   [8]  91.33492 102.79443  74.37330 105.36249 117.23348  98.92870 105.61287
#>  [15]  89.23935 100.82991 101.78167  91.55114 117.67981  82.68244 112.11189
#>  [22] 107.36570 111.29951  90.78180 101.56818  80.14524 110.30039 112.91148
#>  [29] 105.00442 110.39921  87.44111  98.86676 101.12835 111.51733  85.58585
#>  [36] 103.89748 107.29353  86.04344  96.94657 110.95199  88.58207  91.29411
#>  [43] 109.85239  91.61905  91.71838 110.01256 111.97043  95.29367  84.88836
#>  [50] 103.47476  95.94925  96.50217  84.59143  95.90070  89.02645 100.54988
#>  [57]  90.44008 109.84374 109.39418  87.61338  86.89788  92.04935  93.35320
#>  [64] 108.44849  94.79207 103.34544  93.20054  96.88521 113.29437 103.96915
#>  [71]  98.51686  92.26959 118.54612 111.78232 105.47654 106.94876 108.49706
#>  [78] 103.51722 104.15862  84.53482  87.53159 104.64329 108.85733  94.02569
#>  [85] 107.12776  93.87376 107.84242  97.69873 125.24530 103.56465  93.36118
#>  [92] 109.48751 103.26694  96.17233 113.48133  86.81124 108.93587 112.09918
#>  [99]  97.40808  85.91189
#> 
#> $distribution
#> [1] "GEV"
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
#> [1] 6 9
#> 
#> $method
#> [1] "GMLE"
#> 
#> $params
#> [1] 91.8560207  5.8190957  9.7532285  0.1078057
#> 
#> $mll
#> [1] -267.971
#> 
```
