library(glue)
library(rmarkdown)
library(tinytex)
library(tools)
library(yaml)
library(knitr)


# Load configuration file
config <- yaml::read_yaml("config.yml")
csv_file_name <- tools::file_path_sans_ext(config$csv_file)

# Ask the user which stage of the analysis they would like to perform:
print(glue("

Welcome to the FFA framework. You are analyzing {csv_file_name}.

If you would like to analyze a different file, edit config.yml.

This script will perform the following three analyses:
 (1) Change point analysis
 (2) Trend analysis
 (3) Frequency analysis
"))

cat("\nPress any key to begin change point analysis. ")
action <- readLines("stdin",n=1);

cat("\nRunning change point analysis...")
source("change_points.R")

