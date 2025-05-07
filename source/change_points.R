library(glue)
library(rmarkdown)
library(tinytex)
library(tools)
library(yaml)
library(knitr)


# Load configuration file
config <- yaml::read_yaml("config.yml")

# Create a reports directory for this data file if it doesn't already exist
csv_file_name <- tools::file_path_sans_ext(config$csv_file)
report_dir <- paste(config$report_dir, csv_file_name, sep="/")
if (!dir.exists(report_dir)) { dir.create(report_dir) }

# Create a directory for storing change point analysis if it doesn't already exist
change_point_dir <- paste(report_dir, "01_change_points", sep="/")
if (!dir.exists(change_point_dir)) { dir.create(change_point_dir) }


### Data Processing ###


# Filter the dataset on years without a NaN value for annual max streamflow
csv_path <- paste(config$data_dir, config$csv_file, sep="/")
csv_data <- read.csv(csv_path)
filtered_data <- csv_data[!is.na(csv_data$max), ]

# Get a full list of years that should be in the dataset
min_year <- min(filtered_data$Year)
max_year <- max(filtered_data$Year)
year_full <- seq(min_year, max_year, by=1)

# Add additional rows so that there are no missing years
year_data <- data.frame(Year = year_full)
data <- merge(year_data, filtered_data, by="Year", all.x=TRUE)


### Statistical Tests ###


# Command line arguments
args <- c(
	c("--input", csv_path),
	c("--config", "config.yml"),
	c("--output", change_point_dir)
)

# Perform tests
pettitt_report <- system2("Rscript", args=c("pettitt_test.R", args), stdout=TRUE)
mks_report <- system2("Rscript", args=c("mks_test.R", args), stdout=TRUE)


### Report Generation ###


# List of parameters to pass into the report
report_params = list(
	dataset = config$csv_file,
	min_year = min_year,
	max_year = max_year,
	total_count = length(data$max),
	na_count = sum(is.na(data$max)),
	pettitt_report = pettitt_report,
	mks_report = mks_report
)

# Copy report.rmd into the change_point_dir folder
rmd_path <- paste(change_point_dir, "report.rmd", sep="/")
invisible(file.copy("templates/change_point.rmd", rmd_path, overwrite=TRUE))

# Generate HTML and PDF reports
rmarkdown::render(rmd_path, params=report_params, output_format="all", quiet=TRUE)

# Inform the user that change point analysis is complete
cat(glue("
\nChange point analysis complete.
 - {pettitt_report}
 - {mks_report}
Report created in {change_point_dir}.\n
"))
