# L-Moments Parameter Estimation for the Kappa Distribution

This function estimates the parameters of the four-parameter Kappa
distribution using the method of L-moments. Since no closed-form
solution for the parameters in terms of the L-moments is known, the
parameters are estimated numerically using Newton-Raphson iteration.

## Usage

``` r
fit_lmoments_kappa(data)
```

## Arguments

- data:

  Numeric vector of observed annual maximum series values. Must be
  strictly positive, finite, and not missing.

## Value

A list containing the results of parameter estimation:

- `data`: The `data` argument.

- `distribution`: `"KAP"`.

- `method`: `"L-moments"`.

- `params`: numeric vector of 4 parameters in the order location, scale,
  shape (2).

## Details

First, the sample L-moments of the data are computed using
[`utils_sample_lmoments()`](https://rileywheadon.github.io/ffa-framework/reference/utils_sample_lmoments.md).
Then, the [`stats::optim()`](https://rdrr.io/r/stats/optim.html)
function is used to determine the parameters by minimizing the euclidian
distance between the sample and theoretical L-moment ratios. The
implementation of this routine is based on the deprecated 'homtest'
package, formerly available at
<https://CRAN.R-project.org/package=homtest>.

## References

Hosking, J.R.M. & Wallis, J.R., 1997. Regional frequency analysis: an
approach based on L-Moments. Cambridge University Press, New York, USA.

## See also

[`utils_sample_lmoments()`](https://rileywheadon.github.io/ffa-framework/reference/utils_sample_lmoments.md),
[`fit_lmoments()`](https://rileywheadon.github.io/ffa-framework/reference/fit_lmoments.md)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
fit_lmoments_kappa(data)
#> $data
#>   [1]  99.43153  90.23783  79.33490 104.12935 107.77373 107.74647  90.52324
#>   [8] 104.05805 117.28742  90.72178 100.51341  95.89050  98.17972 102.58520
#>  [15]  96.10162 100.28579 103.75042 102.36861 106.81857  99.87023  93.63866
#>  [22] 103.16125 101.24585 114.56949  98.74122 108.01745  88.36622  92.08586
#>  [29]  94.85833  91.17829  79.81302 106.05510  87.84966  94.28917 115.41705
#>  [36] 104.91905 115.68214  86.67678 102.79631  92.60434 119.73140 117.24102
#>  [43] 108.36749 103.51559  79.13414 101.57273 110.01306  94.95882  94.36551
#>  [50]  98.49159 114.57832  82.77162  88.09108  95.81234  79.14392  84.59182
#>  [57]  98.12339  97.29406  89.23987 112.77777 111.88500 101.40517 109.86976
#>  [64]  97.46669 114.10414  99.06067 119.42181 104.18372 104.83997  95.58950
#>  [71]  98.99218  96.55484 115.53452 106.02357  81.50147  96.43393  86.41441
#>  [78]  94.61247  99.85326 107.39677  97.63858 114.23139  97.42237  87.23457
#>  [85] 102.19430 123.33102 129.98500 103.65176  96.13149 101.34976 127.82386
#>  [92]  93.53035  98.14358 108.50758  92.69139  99.54006 109.46315  97.90904
#>  [99]  95.27777  86.73009
#> 
#> $distribution
#> [1] "KAP"
#> 
#> $method
#> [1] "L-moments"
#> 
#> $params
#> [1] 98.61615443  7.15152548  0.02668048 -0.53572165
#> 
```
