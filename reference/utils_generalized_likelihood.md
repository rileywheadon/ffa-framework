# Generalized Log-Likelihood Functions for GEV Models

Computes the generalized log-likelihood for stationary and nonstationary
variants of the Generalized Extreme Value (GEV) distribution with a
geophysical (Beta) prior distribution for the shape parameter (Martins
and Stedinger, 2000).

**For NS-FFA**: To compute the generalized log-likelihood for a
nonstationary probability model, include the observation years
(`ns_years`) and the nonstationary model structure (`ns_structure`).

## Usage

``` r
utils_generalized_likelihood(
  data,
  params,
  prior,
  ns_years = NULL,
  ns_structure = NULL
)
```

## Arguments

- data:

  Numeric vector of observed annual maximum series values. Must be
  strictly positive, finite, and not missing.

- params:

  Numeric vector of distribution parameters, in the order (location,
  scale, shape). The length must be between 2 and 5, depending on the
  specified `distribution` and `structure`.

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

Numeric scalar. The generalized log-likelihood value.

## Details

The generalized log-likelihood is defined as sum of (1) the
log-likelihood and (2) the log-density of the Beta prior with parameters
\\(p, q)\\. The contribution of the prior is: \$\$\log \pi(\kappa) =
(p-1) \log(0.5-\kappa) + (q-1) \log(0.5+\kappa) - \log (\beta(p, q))\$\$

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

[`utils_log_likelihood()`](https://rileywheadon.github.io/ffa-framework/reference/utils_log_likelihood.md)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
params <- c(100, 10, 0.1)
prior <- c(1, 1)

# Compute the generalized log-likelihood
utils_generalized_likelihood(data, params, prior)
#> [1] -375.3252
```
