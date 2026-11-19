# Plot Annual Maximum Series Data

Produces a scatterplot of annual maximum series data against time,
optionally overlaid with the sample mean/variability or Sen's trend
estimator of the mean/variability.

## Usage

``` r
plot_ams_data(
  data,
  years,
  plot_mean = "None",
  plot_variability = "None",
  show_line = TRUE,
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

- plot_mean:

  If "None" (default), the mean will not be plotted. If `"Constant"`, a
  black line is plotted at the sample mean. If `"Trend"`, the trend in
  the mean is estimated using
  [`eda_sens_trend()`](https://rileywheadon.github.io/ffa-framework/reference/eda_sens_trend.md)
  and plotted as a blue line.

- plot_variability:

  If "None" (default), the variability will not be plotted. If
  `"Constant"`, dashed black lines are plotted at one standard deviation
  above/below the sample mean. If `"Trend"`, the trend in variability is
  estimated with
  [`data_mw_variability()`](https://rileywheadon.github.io/ffa-framework/reference/data_mw_variability.md)
  and
  [`eda_sens_trend()`](https://rileywheadon.github.io/ffa-framework/reference/eda_sens_trend.md)
  and plotted as a dashed blue line.

- show_line:

  If `TRUE` (default), a fitted line is drawn through the data.

- ...:

  Optional named arguments: 'title', 'xlabel', and 'ylabel'.

## Value

`ggplot`; a plot containing:

- Gray points for each year’s annual maximum series value.

- A gray line connecting the data if `show_line = TRUE`.

- A solid black line representing a constant mean, if
  `plot_mean == "Constant"`.

- A solid blue line representing a trend in the mean, if
  `plot_mean == "Trend"`.

- A dashed black line representing constant variability, if
  `plot_variability == "Constant"`.

- A dashed blue line representing a trend in variability, if
  `plot_variability == "Trend"`.

## See also

[`eda_sens_trend()`](https://rileywheadon.github.io/ffa-framework/reference/eda_sens_trend.md),
[`data_mw_variability()`](https://rileywheadon.github.io/ffa-framework/reference/data_mw_variability.md)

## Examples

``` r
data <- rnorm(n = 100, mean = 100, sd = 10)
years <- seq(from = 1901, to = 2000)
plot_ams_data(data, years, plot_mean = "Trend", plot_variability = "Constant")

```
