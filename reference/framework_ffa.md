# Orchestrate Flood Frequency Analysis

Performs frequency analysis of annual maximum series data including
distribution selection, parameter estimation, uncertainty
quantification, and model assessment. Supports both stationary (S-FFA)
or nonstationary (NS-FFA) flood frequency analysis.

## Usage

``` r
framework_ffa(
  data,
  years,
  ns_splits = NULL,
  ns_structures = NULL,
  generate_report = TRUE,
  report_path = NULL,
  report_formats = "html",
  ...
)
```

## Arguments

- data:

  Numeric vector of observed annual maximum series values. Must be
  strictly positive, finite, and not missing.

- years:

  Numeric vector of observation years corresponding to `data`. Must be
  the same length as `data` and strictly increasing.

- ns_splits:

  An integer vector of years used to split the data into homogeneous
  subperiods. For S-FFA, set to `NULL` (default). For NS-FFA, specify an
  *integer* vector of years with physical justification for change
  points, or `NULL` if no such years exist. In R, integers have the
  suffix `L`, so `1950L` is a valid input to `ns_splits`, but `1950` is
  not (since it may be interpreted as a floating point number).

- ns_structures:

  For S-FFA, set to `NULL` (default) to use a stationary model for all
  homogeneous subperiods. For NS-FFA, provide a list of
  `length(ns_splits) + 1` sublists specifying the nonstationary model
  structure for each homogeneous subperiod. Each sublist must contain
  logical elements `location` and `scale`, indicating monotonic trends
  in the mean and variability, respectively.

- generate_report:

  If `TRUE` (default), generate a report.

- report_path:

  A character scalar, the file path for the generated report. If `NULL`
  (default), the report will be saved to a new temporary directory.

- report_formats:

  A character vector specifying the output format for the report.
  Supported values are `"md"`, `"pdf"`, `"html"`, and `"json"`.

- ...:

  Additional arguments. See the "Optional Arguments" section for a
  complete list.

## Value

`modelling_assumptions`: A list describing the model(s) used for the
analysis.

- `approach`: Either "S-FFA", "NS-FFA", or "Piecewise NS-FFA".

- `ns_splits`: The `ns_splits` argument, if given.

- `ns_structures`: The `ns_structures` argument, if given.

`submodule_results`: A list of lists of containing the results of
frequency analysis. Each list contains:

- `name`: Either "Distribution Selection", "Parameter Estimation",
  "Uncertainty Quantification", or "Model Assessment".

- `start`: The first year of the homogeneous subperiod.

- `end`: The last year of the homogeneous subperiod.

- Additional items specific to the the submodule.

## Optional Arguments

- `selection`: Distribution selection method (default is
  `"L-distance"`). Must be one of `"L-distance"`, `"L-kurtosis"` or
  `"Z-statistic"`. Alternatively, set `selection` to a three-letter
  distribution code (e.g., `"GUM"`) to use a specific distribution.

- `s_estimation`: Parameter estimation method for S-FFA (default is
  `"L-moments"`). Must be `"L-moments"`, `"MLE"`, or `"GMLE"`. Method
  `"GMLE"` requires `selection = "GEV"`.

- `ns_estimation`: Parameter estimation method for NS-FFA (default is
  `"MLE"`). Must be `"MLE"` or `"GMLE"`. Method `"GMLE"` requires
  `selection = "GEV"`.

- `s_uncertainty`: Uncertainty quantification method for S-FFA (default
  is `"Bootstrap"`). Must be one of `"Bootstrap"`, `"RFPL"`, or
  `RFGPL"`. Using method `"RFPL"` requires `s_estimation = "MLE"` and
  method `"RFGPL"` requires `s_estimation = "GMLE"`.

- `ns_uncertainty`: Uncertainty quantification method for NS-FFA
  (default is `"RFPL"`). Must be one of `"Bootstrap"`, `"RFPL"`, or
  `RFGPL"`. Using method `"RFPL"` requires `ns_estimation = "MLE"` and
  method `"RFGPL"` requires `ns_estimation = "GMLE"`.

- `z_samples`: Integer number of bootstrap samples for selection method
  `"Z-statistic"` (default is 10000).

- `gev_prior`: Parameters for the prior distribution of the shape
  parameter of the GEV distribution (default is 6, 9). Used with
  estimation method `"GMLE"`.

- `return_periods`: Integer list of return periods (in years) for
  estimating return levels. Uses the 2, 5, 10, 20, 50, and 100 year
  return periods by default.

- `ns_slices`: Integer vector of years at which to estimate the return
  levels for nonstationary models. Slices outside of the period will be
  ignored (default is 1925, 1975, 2025).

- `bootstrap_samples`: Integer number of samples for uncertainty
  quantification method \`"Bootstrap" (default is 10000).

- `rfpl_tolerance`: Log-likelihood tolerance for uncertainty
  quantification method `"RFPL"`(default is 0.01).

- `pp_formula`: Plotting position formula for model assessment. Must be
  one of:

  - "Weibull" (default): \\i / (n + 1)\\

  - "Blom": \\(i - 0.375) / (n + 0.25)\\

  - "Cunnane": \\(i - 0.4) / (n + 0.2)\\

  - "Gringorten": \\(i - 0.44) / (n + 0.12)\\

  - "Hazen": \\(i - 0.5) / n\\

## See also

[`select_ldistance()`](https://rileywheadon.github.io/ffa-framework/reference/select_ldistance.md),
[`select_lkurtosis()`](https://rileywheadon.github.io/ffa-framework/reference/select_lkurtosis.md),
[`select_zstatistic()`](https://rileywheadon.github.io/ffa-framework/reference/select_zstatistic.md),
[`fit_lmoments()`](https://rileywheadon.github.io/ffa-framework/reference/fit_lmoments.md),
[`fit_mle()`](https://rileywheadon.github.io/ffa-framework/reference/fit_mle.md),
[`fit_gmle()`](https://rileywheadon.github.io/ffa-framework/reference/fit_gmle.md),
[`uncertainty_bootstrap()`](https://rileywheadon.github.io/ffa-framework/reference/uncertainty_bootstrap.md),
[`uncertainty_rfpl()`](https://rileywheadon.github.io/ffa-framework/reference/uncertainty_rfpl.md),
[`uncertainty_rfgpl()`](https://rileywheadon.github.io/ffa-framework/reference/uncertainty_rfgpl.md),
[`model_assessment()`](https://rileywheadon.github.io/ffa-framework/reference/model_assessment.md)

## Examples

``` r
# Get data for the BOW RIVER AT BANFF (05BB001)
df <- data_local("CAN-05BB001.csv")

# Run the FFA module (takes several minutes)
if (FALSE) framework_ffa(df$max, df$year) # \dontrun{}
```
