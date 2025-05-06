# Load configuration file and get the report path
config <- yaml::read_yaml("config.yml")
csv_file_name <- tools::file_path_sans_ext(config$csv_file)
report_path <- paste(config$report_folder, csv_file_name, sep="")


# Count the number of elements ams[j] where j < i such that ams[i] > ams[j]
s_statistics <- function(idx, ams) {
	n_i <- sapply(idx, function(i) sum(ams[i] > ams[1:i-1]))
	cumsum(n_i)
}


# Conduct the Mann-Kendall-Sneyers test on a given dataframe
mks_test <- function(data) {

	# Get the annual max streaflow column without NaN values
	filtered_data <- data[!is.na(data$max), ]
	ams <- filtered_data$max
	n <- length(ams)

	# Get the variance and expectation of the U-statistics
	idx = 2:n
	U_variance = (idx * (idx - 1) * ((2 * idx) + 5)) / 72
	U_expectation = idx * (idx - 1) / 4

	# Compute the progressive/regressive normalized U-statistis
	Uf <- (s_statistics(idx, ams) - U_expectation) / sqrt(U_variance)
	Ub <- rev((s_statistics(idx, rev(ams)) - U_expectation) / sqrt(U_variance))

	# Determine the number of crossings
	crossings <- which((Uf[-length(Uf)] > Ub[-length(Ub)]) & (Uf[-1] < Ub[-1]) |
					   (Uf[-length(Uf)] < Ub[-length(Ub)]) & (Uf[-1] > Ub[-1]))

	# Plot the results
	Years <- filtered_data$Year[idx]
	df <- data.frame(Years = Years, Uf = Uf, Ub = Ub)
	plot_mks_test(df)

	# Produce a report on the results
	n_crossings <- length(crossings)
	conclusion <- ifelse(
		n_crossings > 0,
		glue("there are {n_crossings} potential trends changes"),
		"there are no trends changes within the data"
	)

	return(glue(" - Using the MKS test, we conclude that {conclusion}."))

}


# Plot the results of the MKS test
plot_mks_test <- function(df) {

	# Get the confidence interval bounds
	lower_bound <- qnorm(config$alpha_eda / 2)
	upper_bound <- qnorm(1 - (config$alpha_eda / 2))
	confidence_df <- data.frame(y = c(lower_bound, upper_bound))

	# Compute the lower and upper bounds for the x-axis
	x_lower <- floor(min(df$Years) / 20) * 20
	x_upper <- ceiling(max(df$Years) / 20) * 20

	# Generate the y-axis label with proper formatting
	ut_label <- "Normalized Trend Statistic"

	# Draw the plot
	ggplot(df, aes(x = Years)) +
	geom_line(aes(color="black", y=Uf), linewidth=1.2) +
	geom_line(aes(color="blue", y=Ub), linewidth=1.2) +
	geom_hline(
		data=confidence_df,
		aes(yintercept=y, color="red"),
		linewidth=1.2,
		linetype = "dashed",
	) +
	labs(title="Mann-Kendall-Sneyers Test", x="Year", y=ut_label, color="Legend") +
	scale_color_manual(
		values = c("black"="black", "blue"="blue", "red"="red"),
		labels = c("Progressive Series", "Regressive Series", "Confidence Bounds")
	) +
	scale_x_continuous(
		breaks = seq(x_lower, x_upper, by = 20),
		labels = seq(x_lower, x_upper, by = 20),
		limits = c(x_lower, x_upper),
	) +
	scale_y_continuous(
		breaks = seq(-4, 4, by = 2),
		labels = seq(-4, 4, by = 2),
		limits = c(-4, 4),
	) +
	theme_minimal() +
	theme(
		plot.title = element_text(size = 20, hjust = 0.5),
		plot.margin = margin(5, 15, 5, 15),
		axis.title = element_text(size = 16),
		axis.text = element_text(size = 12),
		panel.grid.minor = element_blank(),
		legend.title = element_text(hjust = 0.5),
		legend.background = element_rect(fill = "white", color = "black"),
		legend.box.background = element_rect(color = "black"),
		legend.direction = "vertical"
	)

	ggsave("mks-test.png", path=report_path, width=10, height=5, bg="white")
	
}
