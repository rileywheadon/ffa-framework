# Quantile Functions for Probability Models

Compute the quantiles for stationary and nonstationary probability
models.

**For NS-FFA**: To compute the quantiles for a nonstationary probability
model, specify a time slice (`ns_slice`) and the nonstationary model
structure (`ns_structure`).

## Usage

``` r
utils_quantiles(p, distribution, params, ns_slice = 0, ns_structure = NULL)
```

## Arguments

- p:

  Numeric vector of probabilities between 0 and 1 with no missing
  values.

- distribution:

  A three-character code indicating the distribution family. Must be
  `"GUM"`, `"NOR"`, `"LNO"`, `"GEV"`, `"GLO"`, `"GNO"`, `"PE3"`,
  `"LP3"`, or `"WEI"`.

- params:

  Numeric vector of distribution parameters, in the order (location,
  scale, shape). The length must be between 2 and 5, depending on the
  specified `distribution` and `structure`.

- ns_slice:

  For NS-FFA only: Numeric scalar specifying the year at which to
  evaluate the quantiles of a nonstationary probability distribution.
  `ns_slice` does not have to be an element of the `ns_years` argument.

- ns_structure:

  For NS-FFA only: Named list indicating which distribution parameters
  are modeled as nonstationary. Must contain two logical scalars:

  - `location`: If `TRUE`, the location parameter has a linear temporal
    trend.

  - `scale`: If `TRUE`, the scale parameter has a linear temporal trend.

## Value

A numeric vector of quantiles with the same length as `p`.

## Examples

``` r
p <- runif(n = 100)
params <- c(1, 1, 1)
utils_quantiles(p, "GEV", params)
#>   [1]   30.0262898    5.7071768    1.2296162    0.9328966    0.7360122
#>   [6]    1.3922066    2.1551759    0.8071951    1.7285450    6.1540250
#>  [11]    1.2751348   20.3128709    1.9556752    1.0977995    1.3532663
#>  [16]   10.4834571    1.4851020    0.3140784    2.2249481    6.7166305
#>  [21]    1.3449819    0.7344494    4.0769569    2.2994879    2.6158512
#>  [26]    0.1695655   45.1327344    2.9983183    1.3189683    4.6175734
#>  [31]    1.3315546    0.6852679    1.8124340    0.4175969    0.6398164
#>  [36]   34.5159032   50.3173375    4.3483369    0.6101997    0.2500880
#>  [41]    1.1739395    0.7428364    1.0728715   75.8549479    1.4586535
#>  [46]    1.2039492    0.8868463    2.0170410    1.3105764    1.0685242
#>  [51]    0.7989876 7200.4444108   11.1169533    0.3016644    0.9091164
#>  [56]    3.3715132    1.2571642    1.8945534    2.1804621    0.4607803
#>  [61]    1.6424660   41.9321051   16.6766337    1.2167814    0.6046739
#>  [66]   22.5780999    1.7080234    0.6348811    3.4475021    0.4800481
#>  [71]    1.0977278    2.2192118    0.9586585    0.5658750    0.1823251
#>  [76]    0.8457249    2.1172983    4.2452326   11.6267695    0.8909347
#>  [81]    0.6587437    7.4258069    0.7932062    1.2843921   21.9776799
#>  [86]    0.5207196    0.5431810   16.6286952   22.0891054    4.5751031
#>  [91]    0.6644025    0.2859188    0.4482960    1.2424895    1.0083540
#>  [96]    1.1455489    1.5685678    0.2860527    1.6038001    0.6257317
```
