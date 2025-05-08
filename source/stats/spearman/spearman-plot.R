library(ggplot2)

# Source the plot theme (path is relative to /source)
source("stats/plot-theme.R")

# Plot the results of the Mann-Whitney-Pettitt test for abrupt changes in the mean
plot <- function(df, results) {

	# Load the results of the test into the environment
	list2env(results, envir = environment())

	# Add u_t to df and create change point df (if change point is significant)
	rho_df <- data.frame(
		lag = 1:length(rho),
		rho = rho,
		sig = sig
	)

	# First subplot: Spearman's Rho Autocorrelation
	p1 <- ggplot(rho_df, aes(x = lag, y = rho)) +
		geom_segment(aes(x = lag, xend = lag, y = 0, yend = rho)) +
		geom_point(
			aes(fill = sig),
			shape = 21,
			size = 3,
			stroke = 1.2
		) +
		labs(
			title = "Spearman's rho Autocorrelation",
			x = "Lag",
			y = "Spearman's rho",
			fill = "Legend"
		) + 
		scale_fill_manual(
			values = c(`TRUE` = "black", `FALSE` = "white"),
			labels = c("No Serial Correlation", "Serial Correlation"),
		)

	# Return the plot with added theme
	add_theme(p1)

}

 
