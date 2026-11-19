# L-Moments Parameter Estimation

**For S-FFA only**: Estimates the parameters of a *stationary*
probability model using the L-moments.

## Usage

``` r
fit_lmoments(data, distribution)
```

## Arguments

- data:

  Numeric vector of observed annual maximum series values. Must be
  strictly positive, finite, and not missing.

- distribution:

  A three-character code indicating the distribution family. Must be
  `"GUM"`, `"NOR"`, `"LNO"`, `"GEV"`, `"GLO"`, `"GNO"`, `"PE3"`,
  `"LP3"`, or `"WEI"`.

## Value

A list containing the results of parameter estimation:

- `data`: The `data` argument.

- `distribution`: The `distribution` argument.

- `method`: `"L-moments"`.

- `params`: Numeric vector of estimated parameters.

## Details

First, the sample L-moments of the data are computed using
[`utils_sample_lmoments()`](https://rileywheadon.github.io/ffa-framework/reference/utils_sample_lmoments.md).
Then, formulas from Hosking (1997) are used to match the parameters to
the sample L-moments. The distributions `"GNO"`, `"PE3"`, and `"LP3"`
use a rational approximation of the parameters since no closed-form
expression is known.

## References

Hosking, J.R.M. & Wallis, J.R., 1997. Regional frequency analysis: an
approach based on L-Moments. Cambridge University Press, New York, USA.

## See also

[`fit_lmoments_kappa()`](https://rileywheadon.github.io/ffa-framework/reference/fit_lmoments_kappa.md),
[`fit_mle()`](https://rileywheadon.github.io/ffa-framework/reference/fit_mle.md),
[`fit_gmle()`](https://rileywheadon.github.io/ffa-framework/reference/fit_gmle.md)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
fit_lmoments(data, "GUM")
#> $data
#>   [1] 106.89636  99.71902  80.10229  92.36063  83.85098 121.10798 108.58506
#>   [8] 108.31253  94.26097 100.53390 120.76441 107.26516 109.96803  91.08321
#>  [15] 105.39807  99.44333 100.16600 118.61687 110.21902 114.73549 100.36435
#>  [22]  86.31768 109.19317 116.28756 101.60625  90.94688 102.68745  97.00890
#>  [29]  89.48579 117.41882  98.48603  99.31366  86.91908 101.22587 118.70062
#>  [36]  97.80619 109.65154 107.82251  88.81587  75.86941  85.69462  97.30973
#>  [43]  99.80566 112.09757  91.36437  95.86744  92.77654 104.87393 102.51375
#>  [50] 100.99291  95.86417  99.78147 104.83921 110.42958 109.35107  97.67290
#>  [57] 104.29871 109.35454  92.24086 108.62367  85.20797  90.62383 102.25252
#>  [64] 105.23610  94.18402 101.79172 103.95063 112.68783  95.59487  92.48007
#>  [71]  94.78395  94.88289 106.87342 107.67279 115.10075 114.32144 118.17319
#>  [78] 100.70136 102.34274  96.87547 115.08114 108.78293 105.86041  85.56727
#>  [85] 120.00224 103.56648  97.37379  91.94665 108.82779  82.40831  94.94096
#>  [92]  90.56819 102.17673  92.68039  98.05867  99.08948 100.12524 115.71024
#>  [99]  96.13517 111.17732
#> 
#> $distribution
#> [1] "GUM"
#> 
#> $method
#> [1] "L-moments"
#> 
#> $params
#> [1] 96.7344  8.0983
#> 
```
