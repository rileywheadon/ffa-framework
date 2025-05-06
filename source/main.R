

### Import Libraries ###


library(ggplot2)
library(patchwork)
library(glue)
library(rmarkdown)


### Load data for FFA ###


# NOTE: Make sure to set data_folder and csv_file to the correct foler on your computer
data_folder <- "~/Code/ffa-framework/data/"
csv_file <- "Application_3.1.csv"
csv_path <- paste(data_folder, csv_file, sep="")
csv_data <- read.csv(csv_path, header = TRUE)


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
pettitt_report <- pettitt_test(data, alpha_eda)

# Perform the Mann-Kendall-Sneyers test
source("mks_test.R")
mks_report <- mks_test(data, alpha_eda)


### RMarkdown Report Generation ###


report <- glue("

# Report

Dataset: {csv_file}

## Data Preprocessing

- The processed data contains AMS measurements between {min_year} and {max_year}.
- There are {non_na_count} non-missing values and {na_count} missing values.

## Exploratory Data Analysis

### Mann-Whitney-Pettitt Test

The **Mann-Whitney-Pettitt** test is used to detect change points in the AMS data.

{pettitt_report}

![](pettitt-test.png)

")

writeLines(report, "eda/report.Rmd")
render("eda/report.Rmd", output_format = "html_document")
