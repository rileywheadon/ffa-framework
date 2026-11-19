# Orchestrate Exploratory Data Analysis

First, this method identifies change points in the original annual
maximum series data. Then, the user is given the option to split the
dataset into two or more homogenous subperiods (trend-free or with
monotonic trends). Finally, this method performs a collection of
statistical tests for identifying monotonic nonstationarity in the mean
and variability of each subperiod (if the dataset was split) or of the
entire dataset (if it was not split). The results of EDA can help guide
FFA approach selection (stationary or nonstationary) and FFA model
determination.

## Usage

``` r
framework_eda(
  data,
  years,
  ns_splits = NULL,
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

`eda_recommendations`: A list containing the recommended FFA approach,
split point(s) and nonstationary structure(s) from EDA:

- `approach`: Either "S-FFA", "NS-FFA" (for a single homogeneous
  period), or "Piecewise NS-FFA" (for multiple homogeneous subperiods).

- `ns_splits`: The split point(s) identified by the change point
  detection test with the the lowest statistically significant p-value,
  or `NULL` if no such point exists.

- `ns_structures`: A list of structure objects for each homogeneous
  subperiod. Each structure is a list with boolean items `location` and
  `scale`, which represent a linear trend in the in the mean or
  variability of the data, respectively. If no trends were found in any
  homogeneous subperiod, `ns_structures` will be `NULL`.

`submodule_results`: A list of lists of statistical tests. Each list
contains:

- `name`: Either "Change Point Detection" or "Trend Detection".

- `start`: The first year of the homogeneous subperiod.

- `end`: The last year of the homogeneous subperiod.

- Additional items from the statistical tests within the submodule.

## Optional Arguments

- `alpha`: The numeric significance level for all statistical tests
  (default is 0.05).

- `bbmk_samples`: The number of samples used in the Block-Bootstrap
  Mann-Kendall (BBMK) test (default is 10000). Must be an integer.

- `window_size`: The size of the window used to compute the variability
  series.

- `window_step`: The number of years between successive moving windows.
  Used to compute the variability series.

## See also

[`eda_pettitt_test()`](https://rileywheadon.github.io/ffa-framework/reference/eda_pettitt_test.md),
[`eda_mks_test()`](https://rileywheadon.github.io/ffa-framework/reference/eda_mks_test.md),
[`eda_mk_test()`](https://rileywheadon.github.io/ffa-framework/reference/eda_mk_test.md),
[`eda_spearman_test()`](https://rileywheadon.github.io/ffa-framework/reference/eda_spearman_test.md),
[`eda_bbmk_test()`](https://rileywheadon.github.io/ffa-framework/reference/eda_bbmk_test.md),
[`eda_pp_test()`](https://rileywheadon.github.io/ffa-framework/reference/eda_pp_test.md),
[`eda_kpss_test()`](https://rileywheadon.github.io/ffa-framework/reference/eda_kpss_test.md),
[`eda_sens_trend()`](https://rileywheadon.github.io/ffa-framework/reference/eda_sens_trend.md),
[`eda_runs_test()`](https://rileywheadon.github.io/ffa-framework/reference/eda_runs_test.md),
[`eda_white_test()`](https://rileywheadon.github.io/ffa-framework/reference/eda_white_test.md)

## Examples

``` r
# Get data for the BOW RIVER AT BANFF (05BB001)
df <- data_local("CAN-05BB001.csv")

# Run EDA (takes several minutes)
if (FALSE) framework_eda(df$max, df$year) # \dontrun{}
```
