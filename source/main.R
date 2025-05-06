

### Import Libraries ###


library(ggplot2)
library(patchwork)
library(glue)
library(rmarkdown)
library(tinytex)
library(tools)
library(yaml)


### Load data for FFA ###


# Load configuration file
config <- yaml::read_yaml("config.yml")

# Load data from the given CISV file
csv_path <- paste(config$data_folder, config$csv_file, sep="")
csv_data <- read.csv(csv_path, header = TRUE)

# Create reports directory for this data file if it doesn't already exist
csv_file_name <- tools::file_path_sans_ext(config$csv_file)
report_path <- paste(config$report_folder, csv_file_name, sep="")
if (!dir.exists(report_path)) { dir.create(report_path) }


### Data Preprocessing ###


# Filter the dataset on years without a NaN value for annual max streamflow
filtered_data <- csv_data[!is.na(csv_data$max), ]

# Get a full list of years that should be in the dataset
min_year <- min(filtered_data$Year)
max_year <- max(filtered_data$Year)
year_full <- seq(min_year, max_year, by=1)

# Add additional rows so that there are no missing years
year_data <- data.frame(Year = year_full)
data <- merge(year_data, filtered_data, by="Year", all.x=TRUE)

# Get the number of missing and non-missing values
non_na_count <- sum(!is.na(data$max))
na_count <- sum(is.na(data$max))


### Exploratory Data Analysis ###


# Set parameters for EDA
alpha_eda <- 0.05         # Significance level for EDA
n_sim_eda <- 10000        # Number of simulations in BB-MK test
window_length_eda <- 10   # Window length in MW-MK test
window_step_eda <- 5      # Window step in MW-MK test

# Perform the Pettitt test for abrupt changes in the mean
source("pettitt_test.R")
pettitt_report <- pettitt_test(data)

# Perform the Mann-Kendall-Sneyers test
source("mks_test.R")
mks_report <- mks_test(data)


### RMarkdown Report Generation ###


rmd_report <- glue("

# Report

Dataset: {config$csv_file}

## Data Preprocessing

- The processed data contains AMS measurements between {min_year} and {max_year}.
- There are {non_na_count} non-missing values and {na_count} missing values.

## Exploratory Data Analysis

### Mann-Whitney-Pettitt Test

The **Mann-Whitney-Pettitt** test is used to detect abrupt changes in the AMS data.

{pettitt_report}

![](pettitt-test.png)

### Mann-Kendall-Sneyers Test

The **Mann-Kendall-Sneyers** test is used to detect the beginning of a change in trend.

{mks_report}

![](mks-test.png)

")

# Render the report as HTML and PDF
rmd_report_path <- paste(report_path, "report.Rmd", sep ="/")
writeLines(rmd_report, rmd_report_path)
rmarkdown::render(rmd_report_path, output_format = "html_document")
rmarkdown::render(rmd_report_path, output_format = "pdf_document")
