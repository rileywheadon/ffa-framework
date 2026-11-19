# Theoretical L-moments of Probability Distributions

Computes the first four L-moments and L-moment ratios for *stationary*
probability models.

## Usage

``` r
utils_theoretical_lmoments(distribution, params)
```

## Arguments

- distribution:

  A three-character code indicating the distribution family. Must be
  `"GUM"`, `"NOR"`, `"LNO"`, `"GEV"`, `"GLO"`, `"GNO"`, `"PE3"`,
  `"LP3"`, or `"WEI"`.

- params:

  Numeric vector of distribution parameters, in the order (location,
  scale, shape). The length must be between 2 and 5, depending on the
  specified `distribution` and `structure`.

## Value

A numeric vector of with four elements:

- \\\lambda_1\\: L-mean

- \\\lambda_2\\: L-variance

- \\\tau_3\\: L-skewness

- \\\tau_4\\: L-kurtosis

## Details

The distributions `"GUM"`, `"NOR"`, `"GEV"`, `"GLO"`, and `"WEI"` have
closed-form solutions for the L-moments and L-moment ratios in terms of
the parameters. The distributions `"GNO"` and `"PE3"` use rational
approximations of the L-moment ratios from Hosking (1997). The L-moments
ratios for the `"LNO"` and `"LP3"` distributions are should be compared
to the log-transformed data and are thus identical to the `"NOR"` and
`"PE3"` distributions respectively.

## References

Hosking, J.R.M. & Wallis, J.R., 1997. Regional frequency analysis: an
approach based on L-Moments. Cambridge University Press, New York, USA.

## Examples

``` r
utils_theoretical_lmoments("GEV", c(1, 1, 1))
#> [1]  1.0000000  0.5000000 -0.3333333  0.1666667
```
