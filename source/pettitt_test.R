# Import libraries
library(glue)
library(yaml)
library(ggplot2)
library(patchwork)
library(optparse)

# Create command line options
option_list <- list(
  make_option(c("-i","--input"), type="character", help="Data file."),
  make_option(c("-c","--config"), type="character", help="YAML confiugration file."),
  make_option(c("-o","--output"), type="character", help="Output directory for images.")
)

# Parse given command line arguments
args <- commandArgs(trailingOnly = TRUE)
opt_parser <- optparse::OptionParser(option_list = option_list)
opt <- optparse::parse_args(opt_parser)

# Check for required input argument
if (is.null(opt$input)) {
  print_help(opt_parser)
  stop("Missing required argument: --input")
}

# Get the significance level from the config file or default to 0.05
alpha <- 0.05
if (!is.null(opt$config)) {
	config <- yaml::read_yaml(opt$config)
	alpha <- config$alpha_eda
}

# Load data from the given input file and remove null values
df <- read.csv(opt$input)
df <- df[!is.na(df$max), ]


####################
# Statistical Test #
####################


# Compute the U-statistic for an index t and a list of means ams
u_statistic <- function(t, ams) {

	# Initialize length n and U-statistic U
	U <- 0
	n <- length(ams)

	# Iterate through all pairs according to the formula and add their sign
	for (i in 1:t) {
		for (j in min(t+1,n):n) {
			U = U + sign(ams[i] - ams[j])
		}
	}

	return(U)
}

# Compute the K-statistic by finding the maximum U-statistic
n <- length(df$max)
U_t <- abs(sapply(1:n, u_statistic, ams=df$max))
K <- max(U_t)

# Compute the p-value and corresponding K-statistic using an approximate formula
p_value <- round(exp((-6 * K^2) / (n^3 + n^2)), digits=3)
K_alpha <- (-log(alpha)*((n^3)+(n^2))/6)^0.5;


######################
# Results Generation #
######################


# Create a dataframe of results
test_df <- data.frame(Years=as.integer(df$Year), U_t=U_t, Flow=df$max)

# Get the change index if the change point is statistically significant
change_index <- ifelse(K > K_alpha, which.max(test_df$U_t), 0)
change_df <- test_df[change_index, ]

# Get the segment endpoints depending on whether there is a change point
ends <- if (change_index == 0) { c(1, n) } else { c(1, change_index, n) }
segments <- length(ends)

# Compute the segment means for the plot
annotation_df <- data.frame(
	x = test_df$Years[ends[-segments]],
	xend = test_df$Years[ends[-1]],
	y = sapply(1:(segments - 1), function(i) mean(test_df$Flow[ends[i]:ends[i + 1]]))
)

# Generate a report on the results of the statistical test 
change_points <- test_df$Years[change_index]
report <- if(K > K_alpha) {
	glue("There is a significant abrupt change point in {change_points}.\n")
} else {
	glue("No significant abrupt change points were found.\n")
}

# Write the result to stdout
cat(report)


############
# Plotting #
############


plot_pettitt_test <- function(df, change_df, annotation_df, K_alpha) {

	# Generate the labels with proper formatting
	ut_label <- expression(U[t] ~ Statistic)
	flow_label <- expression(AMS ~ m^3/s)

	# First subplot: Mann-Whitney-Pettitt Test
	p1 <- ggplot(df, aes(x = Years, y = U_t)) +
		geom_line(aes(color = "black"), linewidth = 1.2) +
		geom_hline(
			aes(yintercept = K_alpha, color = "red"),
			linewidth = 1.2,
			linetype = "dashed",
		) +
		geom_point(data=change_df, aes(color="blue"), size = 4) +
		labs(title="Mann-Whitney-Pettitt Test", x="Year", y=ut_label, color="Legend") +
		scale_color_manual(
			values = c("black"="black", "red"="red", "blue"="blue"),
			breaks = c("black", "red", "blue"),
			labels = c(ut_label, "Change Point Threshold", "Potential Change Point")
		) +
		scale_x_continuous(breaks = scales::pretty_breaks(n=10)) +
		scale_y_continuous(breaks = scales::pretty_breaks(n=10)) +
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

		
	# Also plot the original flow data and segment means
	p2 <- ggplot(df, aes(x = Years, y = Flow)) +
		geom_point(aes(color = "black")) +
		geom_segment(
			data = annotation_df, 
			aes(x=x, xend=xend, y=y, color="green4"),
			linewidth = 1.2 
		) + 
		geom_point(data = change_df, aes(color = "blue"), size = 4) +
		labs(x="Year", y=flow_label, color="Legend") +
		scale_color_manual(
			values = c("black"="black", "green4"="green4", "blue"="blue"),
			breaks = c("black", "green4", "blue"),
			labels = c(flow_label, "Segment Mean(s)", "Potential Change Point")
		) +
		scale_x_continuous(breaks = scales::pretty_breaks(n=10)) +
		scale_y_continuous(breaks = scales::pretty_breaks(n=10)) +
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
	
	# Stack plots on top of each other and add the theme
	p1 / p2

	# Save to the report directory
	ggsave("pettitt-test.png", path=opt$output, width=10, height=8, bg="white")

}

# Plot the results of the test if an output file is specified
if (!is.null(opt$output)) {
	plot_pettitt_test(test_df, change_df, annotation_df, K_alpha)
}

