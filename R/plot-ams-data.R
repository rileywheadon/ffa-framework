#' Plot Annual Maximum Series Data
#'
#' Produces a scatterplot of annual maximum series data against time, optionally overlaid
#' with the sample mean/variability or Sen's trend estimator of the mean/variability.
#'
#' @inheritParams param-data
#' @inheritParams param-years
#'
#' @param plot_mean If "None" (default), the mean will not be plotted. If `"Constant"`,
#' a black line is plotted at the sample mean. If `"Trend"`, the trend in the mean is
#' estimated using [eda_sens_trend()] and plotted as a blue line.
#'
#' @param plot_variability If "None" (default), the variability will not be plotted.
#' If `"Constant"`, dashed black lines are plotted at one standard deviation above/below
#' the sample mean. If `"Trend"`, the trend in variability is estimated with
#' [data_mw_variability()] and [eda_sens_trend()] and plotted as a dashed blue line.
#'
#' @param show_line If `TRUE` (default), a fitted line is drawn through the data.
#'
#' @param ... Optional named arguments: 'title', 'xlabel', and 'ylabel'.
#'
#' @return `ggplot`; a plot containing:
#' - Gray points for each year’s annual maximum series value.
#' - A gray line connecting the data if `show_line = TRUE`.
#' - A solid black line representing a constant mean, if `plot_mean == "Constant"`.
#' - A solid blue line representing a trend in the mean, if `plot_mean == "Trend"`.
#' - A dashed black line representing constant variability, if `plot_variability == "Constant"`.
#' - A dashed blue line representing a trend in variability, if `plot_variability == "Trend"`.
#'
#' @seealso [eda_sens_trend()], [data_mw_variability()]
#'
#' @examples
#' data <- rnorm(n = 100, mean = 100, sd = 10)
#' years <- seq(from = 1901, to = 2000)
#' plot_ams_data(data, years, plot_mean = "Trend", plot_variability = "Constant")
#'
#' @import ggplot2
#' @importFrom grid textGrob
#' @export

plot_ams_data <- function(
	data,
	years,
	plot_mean = "None",
	plot_variability = "None",
	show_line = TRUE,
	...
) {

	# Get the equation for the trend in the mean
	if (plot_mean == "Trend") {
		mean_trend <- eda_sens_trend(data, years)
		m1 <- mean_trend$slope
		m2 <- mean_trend$intercept
	} else {
		m1 <- 0
		m2 <- mean(data)
	}

	# Get the equation for the trend in the variance
	if (plot_variability == "Trend") {
		variability <- data_mw_variability(data, years)
		variability_trend <- eda_sens_trend(variability$std, variability$year)
		v1 <- variability_trend$slope
		v2 <- variability_trend$intercept
	} else {
		v1 <- 0
		v2 <- sd(data)
	}

	# Capture optional arguments
	args <- list(...)

	# Set labels and title
	title <- args$title %||% "Annual Maximum Series"
	xlabel <- args$xlabel %||% "Year"
	ylabel <- args$ylabel %||% expression(Streamflow ~ m^3/s)

	# Generate dataframes for the trend estimate, data
	x <- get_covariates(years)

	df <- data.frame(
		x = years,
		y_data = data,
		y_upper = (m1 * x) + m2 + ((v1 * x) + v2),
		y_trend = (m1 * x) + m2,
		y_lower = (m1 * x) + m2 - ((v1 * x) + v2)
	)

	# Plot of Sen's trend estimator
	p <- ggplot(df, aes(x = .data$x)) +
		geom_point(
			aes(y = .data$y_data),
			color = "dimgray",
			size = 2.25
		) +
		( if (show_line) geom_line(
			aes(y = .data$y_data),
			color = "dimgray",
			linewidth = 1
		) else NULL ) +
		( if (plot_mean != "None") geom_line(
			aes(y = .data$y_trend),
			color = if (plot_mean == "Constant") "black" else "blue",
			linewidth = 1.2
		) else NULL ) +
		( if (plot_variability != "None") geom_line(
			aes(y = .data$y_upper),
			color = if (plot_variability == "Constant") "black" else "blue",
			linetype = "dashed",
			linewidth = 1.2
		) else NULL ) + 
		( if (plot_variability != "None") geom_line(
			aes(y = .data$y_lower),
			color = if (plot_variability == "Constant") "black" else "blue",
			linetype = "dashed",
			linewidth = 1.2
		) else NULL ) +
		labs(title = title, x = xlabel, y = ylabel)

	# Add scales and theme
	add_theme(add_scales(p))

}
