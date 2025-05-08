# Import libraries
library(yaml)
library(optparse)
library(glue)
library(patchwork)
library(ggplot2)
library(tools)

# Create command line options
option_list <- list(
  make_option(c("-n","--name"), type="character", help="Name of statistical test."),
  make_option(c("-c","--config"), type="character", help="YAML confiugration file.")
)

# Parse given command line arguments
args <- commandArgs(trailingOnly = TRUE)
opt_parser <- OptionParser(option_list = option_list)
opt <- parse_args(opt_parser)

# Check for required test name argument
if (is.null(opt$name)) {
	print_help(opt_parser)
	stop("Missing required argument: --name")
}

# Check for required config argument and then load the configuration file
if (is.null(opt$config)) {
	print_help(opt_parser)
	stop("Missing required argument: --config")
} else {
	config <- yaml::read_yaml(opt$config)
	list2env(config, envir = environment())
}

# Create a directory for storing reports for this csv_file
csv_name <- file_path_sans_ext(basename(csv_file))
report_path <- glue("{report_dir}/{csv_name}")
if (!dir.exists(report_path)) dir.create(report_path)

# Load data from the given input file and remove null values
df <- read.csv(csv_file)
df <- df[!is.na(df$max), ]

# Run the statistical test
test_path <- glue("stats/{opt$name}/{opt$name}-test.R")

if (file.exists(test_path)) {
	source(test_path)
	result <- test(df, alpha)
	print(result)
} else {
	print(glue("/stats/{opt$name} does not have a testing script."))
}


# Generate a plot 
plot_path <- glue("stats/{opt$name}/{opt$name}-plot.R")

if (file.exists(plot_path)) {
	source(plot_path)
	plot(df, result)

	# Save the plot to the report directory
	plot_name <- glue("{opt$name}-test.png")
	ggsave(plot_name, path = report_path, width = 10, height = 8, bg = "white")
} else {
	print(glue("/stats/{opt$name} does not have a plotting script."))
}
