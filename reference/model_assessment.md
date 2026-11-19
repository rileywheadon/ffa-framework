# Model Assessment

Computes various metrics for assessing the quality of a fitted flood
frequency model. Metrics include accuracy (residual statistics), fitting
efficiency (information criteria), and uncertainty (coverage based
metrics using confidence intervals).

**For NS-FFA**: The metrics are computed from the normalized
empirical/theoretical quantiles, which are determined based on the
selected distribution family. Therefore, metrics from stationary and
nonstationary models should not be compared.

## Usage

``` r
model_assessment(
  data,
  distribution,
  method,
  prior = NULL,
  ns_years = NULL,
  ns_structure = NULL,
  alpha = 0.05,
  pp_formula = "Weibull",
  ci = NULL
)
```

## Arguments

- data:

  Numeric vector of observed annual maximum series values. Must be
  strictly positive, finite, and not missing.

- distribution:

  A three-character code indicating the distribution family. Must be
  `"GUM"`, `"NOR"`, `"LNO"`, `"GEV"`, `"GLO"`, `"GNO"`, `"PE3"`,
  `"LP3"`, or `"WEI"`.

- method:

  Character scalar specifying the estimation method. Must be
  `"L-moments"`, `"MLE"`, or `"GMLE"`.

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

- alpha:

  Numeric scalar in \\\[0.01, 0.1\]\\. The significance level for
  confidence intervals or hypothesis tests. Default is 0.05.

- pp_formula:

  Character string specifying the plotting position formula. Must
  `"Weibull"` (default), `"Blom"`, `"Cunnane"`, `"Gringorten"`, or
  `"Hazen"`.

- ci:

  **For S-FFA only**. Dataframe containing return periods (in the column
  `periods`) and confidence intervals (in the columns `lower` and
  `upper`). Dataframes in this format can be generated with
  [`uncertainty_bootstrap()`](https://rileywheadon.github.io/ffa-framework/reference/uncertainty_bootstrap.md),
  [`uncertainty_rfpl()`](https://rileywheadon.github.io/ffa-framework/reference/uncertainty_rfpl.md),
  or
  [`uncertainty_rfgpl()`](https://rileywheadon.github.io/ffa-framework/reference/uncertainty_rfgpl.md).

## Value

List containing the results of model assessment:

- `data`: The `data` argument.

- `q_theoretical`: The theoretical return level estimates based on the
  plotting positions. Normalized for nonstationary models.

- `q_empirical`: The empirical return levels. Normalized for
  nonstationary models.

- `metrics`: A list of model assessment metrics (see details).

## Details

These metrics are are computed for all models:

- `AIC_MLL`: Akaike Information Criterion, computed using the maximum
  log-likelihood.

- `BIC_MLL`: Bayesian Information Criterion, computed using the maximum
  log-likelihood.

- `R2`: Coefficient of determination from linear regression of estimates
  vs. data.

- `RMSE`: Root mean squared error of quantile estimates.

- `bias`: Mean bias of quantile estimates.

- `AIC_RMSE`: Akaike Information Criterion, computed using the RMSE.

- `BIC_RMSE`: Bayesian Information Criterion, computed using the RMSE.

These metrics are only computed *if the `ci` argument is provided*:

- `AW`: Average width of the confidence interval(s).

- `POC`: Percent of observations covered by the confidence interval(s).

- `CWI`: Confidence width index, a metric that combines `AW` and `POC`.

## See also

[`uncertainty_bootstrap()`](https://rileywheadon.github.io/ffa-framework/reference/uncertainty_bootstrap.md),
[`uncertainty_rfpl()`](https://rileywheadon.github.io/ffa-framework/reference/uncertainty_rfpl.md),
[`uncertainty_rfgpl()`](https://rileywheadon.github.io/ffa-framework/reference/uncertainty_rfgpl.md),
[`plot_sffa_assessment()`](https://rileywheadon.github.io/ffa-framework/reference/plot_sffa_assessment.md),
[`plot_nsffa_assessment()`](https://rileywheadon.github.io/ffa-framework/reference/plot_nsffa_assessment.md)

## Examples

``` r
# Initialize example data and params
data <- rnorm(n = 100, mean = 100, sd = 10)
params <- c(100, 10)

# Perform uncertainty analysis
ci <- uncertainty_bootstrap(data, "NOR", "L-moments")$ci

# Run model assessment
model_assessment(data, "NOR", "L-moments", ci = ci)
#> $data
#>   [1]  91.81452 100.36118  94.42961  91.78141 112.85518  87.10887  98.47703
#>   [8]  90.29603 115.85079  96.85944  90.73756 113.84408  89.75266  84.38758
#>  [15] 103.32694  83.67615 110.88718 105.92150  88.93916  97.37292 105.86291
#>  [22]  91.23258 108.51698  99.39284  95.83097 107.19835  85.08089 100.34346
#>  [29]  97.53211 119.54145 100.09658 113.11216  88.64854  95.31387 103.40441
#>  [36]  98.21043 116.15922  99.69659 110.39512 102.20352 109.53315 111.88895
#>  [43]  95.33576 116.22845  92.46341 108.04747  93.51511  94.71189  76.80314
#>  [50] 111.49970  97.32005 113.35798 103.04911 110.48993  92.94706 100.24797
#>  [57] 100.81656 105.06131  94.48316 107.03604 101.50665  81.50408  96.53061
#>  [64]  99.56023  98.79920  92.41629 110.41362 100.44308 108.27265  98.96216
#>  [71]  92.11579 108.29480 116.68956 102.13646 111.57535  89.21120 113.15584
#>  [78]  93.25724  93.56120 100.40112 108.21379 114.65366 104.47294 103.40752
#>  [85] 120.89891 103.25784 105.00181 108.11776  98.44905  91.99071  75.23320
#>  [92]  86.10714 108.21163  99.17586  93.73108  89.23005  93.14664 103.55095
#>  [99] 109.96582 109.94133
#> 
#> $q_theoretical
#>   [1] 123.25967 120.60867 118.92706 117.66227 116.63363 115.75823 114.99077
#>   [8] 114.30370 113.67892 113.10388 112.56951 112.06902 111.59719 111.14992
#>  [15] 110.72393 110.31653 109.92552 109.54903 109.18552 108.83363 108.49222
#>  [22] 108.16027 107.83693 107.52140 107.21301 106.91115 106.61526 106.32485
#>  [29] 106.03947 105.75872 105.48221 105.20961 104.94060 104.67489 104.41220
#>  [36] 104.15228 103.89488 103.63979 103.38679 103.13568 102.88626 102.63836
#>  [43] 102.39179 102.14638 101.90197 101.65840 101.41551 101.17314 100.93115
#>  [50] 100.68938 100.44769 100.20592  99.96393  99.72157  99.47867  99.23510
#>  [57]  98.99069  98.74529  98.49872  98.25081  98.00139  97.75028  97.49728
#>  [64]  97.24219  96.98480  96.72488  96.46219  96.19647  95.92746  95.65486
#>  [71]  95.37836  95.09760  94.81223  94.52182  94.22593  93.92406  93.61567
#>  [78]  93.30015  92.97680  92.64486  92.30345  91.95156  91.58804  91.21156
#>  [85]  90.82054  90.41315  89.98715  89.53989  89.06806  88.56757  88.03320
#>  [92]  87.45816  86.83337  86.14630  85.37885  84.50344  83.47480  82.21002
#>  [99]  80.52841  77.87741
#> 
#> $q_empirical
#>   [1] 120.89891 119.54145 116.68956 116.22845 116.15922 115.85079 114.65366
#>   [8] 113.84408 113.35798 113.15584 113.11216 112.85518 111.88895 111.57535
#>  [15] 111.49970 110.88718 110.48993 110.41362 110.39512 109.96582 109.94133
#>  [22] 109.53315 108.51698 108.29480 108.27265 108.21379 108.21163 108.11776
#>  [29] 108.04747 107.19835 107.03604 105.92150 105.86291 105.06131 105.00181
#>  [36] 104.47294 103.55095 103.40752 103.40441 103.32694 103.25784 103.04911
#>  [43] 102.20352 102.13646 101.50665 100.81656 100.44308 100.40112 100.36118
#>  [50] 100.34346 100.24797 100.09658  99.69659  99.56023  99.39284  99.17586
#>  [57]  98.96216  98.79920  98.47703  98.44905  98.21043  97.53211  97.37292
#>  [64]  97.32005  96.85944  96.53061  95.83097  95.33576  95.31387  94.71189
#>  [71]  94.48316  94.42961  93.73108  93.56120  93.51511  93.25724  93.14664
#>  [78]  92.94706  92.46341  92.41629  92.11579  91.99071  91.81452  91.78141
#>  [85]  91.23258  90.73756  90.29603  89.75266  89.23005  89.21120  88.93916
#>  [92]  88.64854  87.10887  86.10714  85.08089  84.38758  83.67615  81.50408
#>  [99]  76.80314  75.23320
#> 
#> $metrics
#> $metrics$AIC_MLL
#> [1] 739.4155
#> 
#> $metrics$BIC_MLL
#> [1] 744.6258
#> 
#> $metrics$R2
#> [1] 0.9914969
#> 
#> $metrics$RMSE
#> [1] 0.898231
#> 
#> $metrics$bias
#> [1] 1.136821e-15
#> 
#> $metrics$AIC_RMSE
#> [1] -6.732806
#> 
#> $metrics$BIC_RMSE
#> [1] -1.522465
#> 
#> $metrics$AW
#> [1] 4.51276
#> 
#> $metrics$POC
#> [1] 93.87755
#> 
#> $metrics$CWI
#> [1] 4.615212
#> 
#> 
```
