#' Orchestrate the Full FFA Framework
#'
#' Runs the entire flood frequency analysis framework using the results of exploratory 
#' data analysis (EDA) to guide approach selection (stationary or nonstationary) and 
#' perform flood frequency analysis. Returns a comprehensive and reproducible summary 
#' of the results.
#'
#' @inheritParams param-data
#' @inheritParams param-years
#' @inheritParams param-ns-splits
#' @inheritParams param-ns-structures
#' @inheritParams param-generate-report
#' @inheritParams param-report-path
#' @inheritParams param-report-formats
#'
#' @param ... Additional arguments to be passed to the statistical tests and frequency
#' analysis functions. See the details of [framework_eda()] and [framework_ffa()] for a 
#' complete list.
#'
#' @return
#' `eda_recommendations`: See [framework_eda()]. 
#'
#' `modelling_assumptions`: See [framework_ffa()]. 
#'
#' `submodule_results`: A list of lists of results. Each list contains:
#' - `name`: Either "Change Point Detection", "Trend Detection", "Distribution 
#'   Selection", "Parameter Estimation", "Uncertainty Quantification", or "Model 
#'   Assessment".
#' - `start`: The first year of the homogeneous subperiod.
#' - `end`: The last year of the homogeneous subperiod.
#' - Additional items specific to the the submodule.
#'
#' @examples
#' # Get data for the BOW RIVER AT BANFF (05BB001)
#' df <- data_local("CAN-05BB001.csv")
#'
#' # Run the complete FFA framework (takes several minutes)
#' \dontrun{framework_full(df$max, df$year)}
#'
#' @seealso [framework_eda()], [framework_ffa()]
#'
#' @importFrom jsonlite write_json
#' @importFrom glue glue
#' @export
framework_full <- function(
	data,
	years,
	ns_splits = NULL,
	ns_structures = NULL,
	generate_report = TRUE,
	report_path = NULL,
	report_formats = "html",
	...
) {

	# Parmaeter validation
	data <- validate_numeric("data", data)
	years <- validate_numeric("years", years, size = length(data))

	# Framework setup
	setup <- framework_setup(generate_report, report_path, ...)
	options <- setup$options
	report_dir <- setup$report_dir
	img_dir <- setup$img_dir

	# Get the results of EDA and FFA
	eda <- framework_eda(data, years, ns_splits, FALSE, report_path)
	ffa <- framework_ffa(data, years, ns_splits, ns_structures, FALSE, report_path)

	# Combine the results of EDA and FFA into a single list
	results <- list(
		eda_recommendations = eda$eda_recommendations,
		modelling_assumptions = ffa$modelling_assumptions,
		submodule_results = c(eda$submodule_results, ffa$submodule_results)
	)

	# Generate the report(s)
	if (generate_report) {
		title <- "Full Framework Report"
		framework_report(report_formats, results, title, report_dir, img_dir)
	}

	# Return the results
	return (results)
}
