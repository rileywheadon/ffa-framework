# Load configuration file and get the report path
config <- yaml::read_yaml("config.yml")
csv_file_name <- tools::file_path_sans_ext(config$csv_file)
report_path <- paste(config$report_folder, csv_file_name, sep="")


# Compute the U-statistic for an index t and a list of means ams
u_statistic <- function(ams, t) {

	# Initialize length n and U-statistic U
	U <- 0
	n <- length(ams)

	# Iterate through all pairs according to the formula and add their sign
	for (i in 1:t) {
		for (j in (t+1):n) {
			U = U + sign(ams[i] - ams[j])
		}
	}

	return(U)
}

# Conduct the Pettitt test on a given dataframe
pettitt_test <- function(data) {

	# Get the annual max streaflow column without NaN values
	filtered_data <- data[!is.na(data$max), ]
	ams <- filtered_data$max
	n <- length(ams)

	# Compute the absolute U-statistic for all viable values of t
	Ut <- abs(sapply(1:(n-1), u_statistic, ams=ams))
	years <- filtered_data$Year[1:(n-1)]

	# Compute the K-statistic by finding the maximum U-statistic
	K <- max(Ut)

	# Compute the theoretical K-statistic at given significance
	K_alpha <- (-log(config$alpha_eda)*((n^3)+(n^2))/6)^0.5;

	# Plot the results
	df <- data.frame(Years = years, Ut = Ut, Flow = ams[1:(n-1)])
	plot_pettitt_test(df, K_alpha)
	
	# Compute the p-value using an approximate formula
	p_value <- round(exp((-6 * K^2) / (n^3 + n^2)), digits=3)

	# Generate a report on the results of the statistical test 
	change_year <- df$Years[which.max(df$Ut)]

	if (p_value < config$alpha_eda) {
		result <- "reject the null hypothesis"
		conclusion <- glue("there is a potential change point in {change_year}")
	} else {
		result <- "fail to reject the null hypothesis"
		conclusion <- "there are no change points"
	}

	return(glue("
	 - The computed K-statistic is {K} and the corresponding p-value is {p_value}.
	 - At a significance level of {config$alpha_eda}, we {result}.
	 - Therefore, we conclude that {conclusion}.
	"))

}

plot_pettitt_test <- function(df, K_alpha) {

	# Get the length and change index
	n <- length(df$Years)
	change_index <- which.max(df$Ut)

	# Highlight the change point
	change_df <- data.frame(
	  Years = df$Years[change_index],
	  Flow = df$Flow[change_index],
	  Ut = max(df$Ut),
	  label = "blue"
	)

	# Generate annotation data
	annotation_df <- data.frame(
		x = c(df$Years[1], df$Years[change_index]),
		xend = c(df$Years[change_index], df$Years[n]),
		y = c(mean(df$Flow[1:change_index]), mean(df$Flow[change_index:n]))
	)

	# Generate the labels with proper formatting
	ut_label <- expression(U[t] ~ Statistic)
	flow_label <- expression(AMS ~ m^3/s)

	# Compute the lower and upper bounds for the axes
	x_lower <- floor(min(df$Years) / 20) * 20
	x_upper <- ceiling(max(df$Years) / 20) * 20
	ut_upper <- ceiling(max(df$Ut) * 1.25 / 200) * 200
	flow_upper <- ceiling(max(df$Flow) * 1.25 / 100) * 100

	# First subplot: Mann-Whitney-Pettitt Test
	p1 <- ggplot(df, aes(x = Years, y = Ut)) +
		geom_point(aes(color = "black")) +
		geom_hline(
			aes(yintercept = K_alpha, color = "red"),
			linewidth = 1.2,
			linetype = "dashed",
		) +
		geom_point(data = change_df, aes(color = label), size = 3) +
		labs(title="Mann-Whitney-Pettitt Test", x="Year", y=ut_label, color="Legend") +
		scale_color_manual(
			values = c("black"="black", "blue"="blue", "red"="red"),
			labels = c(ut_label, "Potential Change Point", "Change Point Threshold")
		) +
		scale_x_continuous(
			breaks = seq(x_lower, x_upper, by = 20),
			labels = seq(x_lower, x_upper, by = 20),
			limits = c(x_lower, x_upper),
		) +
		scale_y_continuous(
			breaks = seq(0, ut_upper, by = 200),
			labels = seq(0, ut_upper, by = 200),
			limits = c(0, ut_upper),
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

	p2 <- ggplot(df, aes(x = Years, y = Flow)) +
		geom_point(aes(color = "black")) +
		geom_segment(
			data = annotation_df, 
			aes(x=x, xend=xend, y=y, color="green4"),
			linewidth = 1.2 
		) + 
		geom_point(data = change_df, aes(color = label), size = 3) +
		labs(x="Year", y=flow_label, color="Legend") +
		scale_color_manual(
			values = c("black"="black", "blue"="blue", "green4"="green4"),
			labels = c(flow_label, "Potential Change Point", "Segment Means")
		) +
		scale_x_continuous(
			breaks = seq(x_lower, x_upper, by = 20),
			labels = seq(x_lower, x_upper, by = 20),
			limits = c(x_lower, x_upper),
		) +
		scale_y_continuous(
			breaks = seq(0, flow_upper, by = 100),
			labels = seq(0, flow_upper, by = 100),
			limits = c(0, flow_upper),
		) +
		theme_minimal() +
		theme(
			plot.margin = margin(5, 15, 5, 15),
			axis.title = element_text(size = 16),
			axis.text = element_text(size = 12),
			panel.grid.minor = element_blank(),
			legend.title = element_text(hjust = 0.5),
			legend.background = element_rect(fill = "white", color = "black"),
			legend.box.background = element_rect(color = "black"),
			legend.direction = "vertical"
		)

	p1 / p2
	ggsave("pettitt-test.png", path=report_path, width=10, height=8, bg="white")

}

