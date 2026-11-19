# Sample L-moments

Computes the first four sample L-moments and L-moment ratios from a
numeric vector of data. L-moments are linear combinations of order
statistics that provide robust alternatives to conventional moments,
with advantages in parameter estimation for heavy-tailed and skewed
distributions.

## Usage

``` r
utils_sample_lmoments(data)
```

## Arguments

- data:

  Numeric vector of observed annual maximum series values. Must be
  strictly positive, finite, and not missing.

## Value

A numeric vector containing the first four sample L-moments and L-moment
ratios:

- \\l_1\\: L-mean

- \\l_2\\: L-variance

- \\t_3\\: L-skewness

- \\t_4\\: L-kurtosis

## Details

Given probability weighted moments \\\beta_0, \beta_1, \beta_2,
\beta_3\\, the first four sample L-moments are:

- \\l_1 = \beta_0\\

- \\l_2 = 2\beta_1 - \beta_0\\

- \\l_3 = 6\beta_2 - 6\beta_1 + \beta_0\\

- \\l_4 = 20\beta_3 - 30\beta_2 + 12\beta_1 - \beta_0\\

Then, the sample L-skewness is \\t_3 = l_3 / l_2\\ and the sample
L-kurtosis is \\t_4 = l_4 / l_2\\.

## References

Hosking, J. R. M. (1990). L-moments: Analysis and estimation of
distributions using linear combinations of order statistics. *Journal of
the Royal Statistical Society: Series B (Methodological)*, 52(1),
105–124.

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
utils_sample_lmoments(data)
#> [1] 98.41945208  5.99026068 -0.04533105  0.08566707
```
