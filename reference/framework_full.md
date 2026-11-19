# Orchestrate the Full FFA Framework

Runs the entire flood frequency analysis framework using the results of
exploratory data analysis (EDA) to guide approach selection (stationary
or nonstationary) and perform flood frequency analysis. Returns a
comprehensive and reproducible summary of the results.

## Usage

``` r
framework_full(
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

  Additional arguments to be passed to the statistical tests and
  frequency analysis functions. See the details of
  [`framework_eda()`](https://rileywheadon.github.io/ffa-framework/reference/framework_eda.md)
  and
  [`framework_ffa()`](https://rileywheadon.github.io/ffa-framework/reference/framework_ffa.md)
  for a complete list.

## Value

`eda_recommendations`: See
[`framework_eda()`](https://rileywheadon.github.io/ffa-framework/reference/framework_eda.md).

`modelling_assumptions`: See
[`framework_ffa()`](https://rileywheadon.github.io/ffa-framework/reference/framework_ffa.md).

`submodule_results`: A list of lists of results. Each list contains:

- `name`: Either "Change Point Detection", "Trend Detection",
  "Distribution Selection", "Parameter Estimation", "Uncertainty
  Quantification", or "Model Assessment".

- `start`: The first year of the homogeneous subperiod.

- `end`: The last year of the homogeneous subperiod.

- Additional items specific to the the submodule.

## See also

[`framework_eda()`](https://rileywheadon.github.io/ffa-framework/reference/framework_eda.md),
[`framework_ffa()`](https://rileywheadon.github.io/ffa-framework/reference/framework_ffa.md)

## Examples

``` r
# Get data for the BOW RIVER AT BANFF (05BB001)
df <- data_local("CAN-05BB001.csv")

# Run the complete FFA framework (takes several minutes)
if (FALSE) framework_full(df$max, df$year) # \dontrun{}
```
