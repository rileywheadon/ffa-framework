# Import libraries
library(yaml)
library(ggplot2)
library(patchwork)
library(glue)
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


# Compute number of elements such that ams[i] > ams[j] for all j < i < t for all t.
s_statistic <- function(vt, ams) {

	# Computes the number of elements such that ams[i] > ams[j] for j < i (given i).
	sum_i <- function(i) sum(ams[i] > ams[1:i-1])

	# Applies the sum_i function to a vector values.
	n_i <- sapply(vt, sum_i)

	# Compute cumulative sum of n_i values to get the S-statistic for all t.
	cumsum(n_i)
}


# Get the variance and expectation of the S-statistics
idx = 1:length(df$max)
S_expectation = idx * (idx - 1) / 4
S_variance = (idx * (idx - 1) * ((2 * idx) + 5)) / 72

# Prevent a division by zero error at idx = 1
S_variance[S_variance == 0] <- 1

# Compute the progressive and regressive non-normalized S-statistics 
S_prog_non_normal <- s_statistic(idx, df$max)
S_regr_non_normal <- s_statistic(idx, rev(df$max))

# Compute the normalized progressive and regressive S-statistics
S_prog <- (S_prog_non_normal - S_expectation) / sqrt(S_variance)
S_regr <- rev((S_regr_non_normal - S_expectation) / sqrt(S_variance))

# Compute confidence bounds for the normalized S-statistics
bound <- qnorm(1 - (alpha / 2))
bound_df <- data.frame(y = c(-bound, bound))

# Find the statistically significant crossings between progressive/regressive series
S_sign <- sign(S_prog - S_regr)
cross <- which(S_sign[-1] != S_sign[-length(S_sign)])
cross <- cross[abs(S_prog[cross]) > bound & abs(S_regr[cross]) > bound]


######################
# Results Generation #
######################


# Create a dataframe with the test statistics and corresponding year/flow
test_df <- data.frame(
	Year = as.integer(df$Year),
	Flow = df$max,
	S_prog = S_prog,
	Sr = S_regr
)

# Create a dataframe with all of the statistically significant crossings
crossing_df <- data.frame(
	Year = test_df[cross, "Year"],
	Statistic = ((S_prog + S_regr) / 2)[cross],
	Flow = test_df[cross, "Flow"]
)

# Generate a report on the result
n_cross <- length(cross) 
cross_str <- paste(unlist(df$Year[cross]), collapse = ", ")

report <- if (n_cross > 1) {
	glue("There are {n_cross} significant trend changes in {cross_str}.\n")
} else if (n_cross > 0) {
	glue("There is 1 significant trend change in {cross_str}.\n")
} else {
	glue("There are no significant trend changes.\n")
}

# Write the result to stdout
cat(report)


############
# Plotting #
############


# Plot the results of the MKS test
plot_mks_test <- function(df, crossing_df, bound_df) {

	# Generate the y-axis label with proper formatting
	ut_label <- "Normalized Trend Statistic"
	flow_label <- expression(AMS ~ m^3/s)
	series_labels <- c("Progressive Series", "Regressive Series")

	# Plot the normalized trend statistics and confidence bands
	p1 <- ggplot(df, aes(x = Year)) +
		geom_line(aes(color = "black", y = S_prog), linewidth=1.2) +
		geom_line(aes(color = "gray", y = S_regr), linewidth=1.2) +
		geom_hline(
			data=bound_df,
			aes(yintercept=y, color="red"),
			linewidth=1.2,
			linetype = "dashed",
		) +
		geom_point(data=crossing_df, aes(color="blue", y=Statistic), size=4) +
		labs(title="Mann-Kendall-Sneyers Test", x="Year", y=ut_label, color="Legend") +
		scale_color_manual(
			values = c("black"="black","gray"="gray","blue"="blue","red"="red"),
			breaks = c("black", "gray", "red", "blue"),
			labels = c(series_labels, "Confidence Bounds", "Potential Trend Change")
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

	# Plot the change points on the original dataset
	p2 <- ggplot(df, aes(x=Year, y=Flow)) +
		geom_point(aes(color="black")) +
		geom_point(data=crossing_df, aes(color="blue"), size=4) +
		labs(x="Year", y=flow_label, color="Legend") +
		scale_color_manual(
			values = c("black"="black", "blue"="blue"),
			breaks = c("black", "blue"),
			labels = c(flow_label, "Potential Change Point")
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
	
	# Stack plots on top of each other
	p1 / p2

	# Save to the output directory
	ggsave("mks-test.png", path=opt$output, width=10, height=8, bg="white")
	
}


# Plot the results of the test if an output file is specified
if (!is.null(opt$output)) {
	plot_mks_test(test_df, crossing_df, bound_df)
}

