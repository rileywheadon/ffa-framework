# Setup (argument parsing and directory creation) for a framework_* method
framework_setup <- function(generate_report, report_path, ...) {

	# Get the configuration options
	args <- list(...)
	config <- generate_config(args)
	options <- validate_config(config)

	# Get/create the report/image directories
	if (generate_report) {
		report_dir <- if (is.null(report_path)) tempdir() else report_path 
		img_dir <- paste0(report_dir, "/img")
		if (!dir.exists(img_dir)) dir.create(img_dir)
		message(paste0("Saving report to '", report_dir, "'"))
	} 

	# Otherwise set report_dir and img_dir to NULL
	else {
		report_dir <- NULL
		img_dir <- NULL
	}

	# Return the results as a list
	list(options = options, report_dir = report_dir, img_dir = img_dir)

}


# Report generation for a framework_* method
framework_report <- function(report_formats, results, title, report_dir, img_dir) {

	for (format in report_formats) {
		if (format == "json") {
			write_json(
				results, 
				path = glue("{report_dir}/report.json"),
				pretty = TRUE,
				auto_unbox = TRUE
			)
		} else {
			rmarkdown::render(
				system.file("templates", "_master.Rmd", package = "ffaframework"),
				params = c(results, list(title = title, img_dir = img_dir)),
				output_format = glue("{format}_document"),
				output_dir = report_dir,
				output_file = "report",
				quiet = TRUE
			)
		} 
	}

}
