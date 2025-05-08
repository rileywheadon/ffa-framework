library(ggplot2)

# Source the plot theme (path is relative to /source)
source("stats/plot-theme.R")

# Plot the results of the Mann-Whitney-Pettitt test for abrupt changes in the mean
plot <- function(df, results) {

	# Load the results of the test into the environment
	list2env(results, envir = environment())

	# First subplot: Spearman's Rho Autocorrelation
	p1 <- ggplot() +
		geom_histogram(aes(x = s_bootstrap, color = "gray"), fill = "lightgray")  +
		geom_vline(aes(xintercept = bounds, color = "red")) + 
		geom_vline(aes(xintercept = s_statistic, color = "black")) + 
		labs(
			title = "Block-Bootstrap Mann-Kendall Test",
			x = "S-Statistic",
			y = "Frequency",
			color = "Legend"
		) + 
		scale_color_manual(
			values = c("gray" = "gray", "black" = "black", "red" = "red"),
			breaks = c("gray", "black", "red"),
			labels = c("Bootstrapped Statistics", "S-Statistic", "Confidence Bounds"),
		)

	# Return the plot with added theme
	add_theme(p1)

}

