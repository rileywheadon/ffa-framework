#' Parameter 'data'
#'
#' @param data Numeric vector of observed annual maximum series values.
#' Must be strictly positive, finite, and not missing.
#'
#' @name param-data
#'
#' @keywords internal
NULL

#' Parameter 'p'
#'
#' @param p Numeric vector of probabilities between 0 and 1 with no missing values.
#'
#' @name param-p
#'
#' @keywords internal
NULL

#' Parameter 'q'
#'
#' @param q Numeric vector of quantiles with no missing values.
#'
#' @name param-q
#'
#' @keywords internal
NULL

#' Parameter 'distribution'
#'
#' @param distribution A three-character code indicating the distribution family. 
#' Must be `"GUM"`, `"NOR"`, `"LNO"`, `"GEV"`, `"GLO"`, `"GNO"`, `"PE3"`, `"LP3"`, 
#' or `"WEI"`.
#'
#' @name param-distribution
#'
#' @keywords internal
NULL

#' Parameter 'method'
#'
#' @param method Character scalar specifying the estimation method.
#' Must be `"L-moments"`, `"MLE"`, or `"GMLE"`.
#' 
#' @name param-method
#'
#' @keywords internal
NULL

#' Parameter 'params'
#'
#' @param params Numeric vector of distribution parameters, in the order (location,
#' scale, shape). The length must be between 2 and 5, depending on the specified
#' `distribution` and `structure`.
#'
#' @name param-params
#'
#' @keywords internal
NULL

#' Parameter 'prior'
#'
#' @param prior Numeric vector of length 2. Specifies the parameters of the 
#' Beta prior for the shape parameter \eqn{\kappa}. 
#'
#' @name param-prior
#'
#' @keywords internal
NULL

#' Parameter 'years'
#'
#' @param years Numeric vector of observation years corresponding to `data`.
#' Must be the same length as `data` and strictly increasing.
#'
#' @name param-years
#'
#' @keywords internal
NULL

#' Parameter 'ns_years'
#'
#' @param ns_years For NS-FFA only: Numeric vector of observation years corresponding 
#' to `data`. Must be the same length as `data` and strictly increasing. 
#'
#' @name param-ns-years
#'
#' @keywords internal
NULL


#' Parameter 'ns_structure'
#'
#' @param ns_structure For NS-FFA only: Named list indicating which distribution 
#' parameters are modeled as nonstationary. Must contain two logical scalars:
#' - `location`: If `TRUE`, the location parameter has a linear temporal trend.
#' - `scale`: If `TRUE`, the scale parameter has a linear temporal trend.
#'
#' @name param-ns-structure
#'
#' @keywords internal
NULL

#' Parameter 'ns_slice'
#'
#' @param ns_slice For NS-FFA only: Numeric scalar specifying the year at which to 
#' evaluate  the quantiles of a nonstationary probability distribution. `ns_slice` 
#' does not have to be an element of the `ns_years` argument. 
#'
#' @name param-ns-slice
#'
#' @keywords internal
NULL 

#' Parameter 'ns_slices'
#'
#' @param ns_slices For NS-FFA only: Numeric vector specifying the years at which to 
#' evaluate the return levels confidence intervals of a nonstationary probability 
#' distribution. `ns_slices` do not have to be elements of the `ns_years` argument. 
#'
#' @name param-ns-slices
#'
#' @keywords internal
NULL 


#' Parameter 'alpha'
#'
#' @param alpha Numeric scalar in \eqn{[0.01, 0.1]}. The significance 
#' level for confidence intervals or hypothesis tests. Default is 0.05. 
#'
#' @name param-alpha
#'
#' @keywords internal
NULL

#' Parameter 'samples'
#'
#' @param samples Integer scalar. The number of bootstrap samples. Default is 10000.
#'
#' @name param-samples
#'
#' @keywords internal
NULL

#' Parameter 'periods'
#' 
#' @param periods Numeric vector used to set the return periods for FFA.
#' All entries must be greater than or equal to 1.
#'
#' @name param-periods
#'
#' @keywords internal
NULL

#' Parameter 'tolerance'
#' 
#' @param tolerance The log-likelihood tolerance for Regula-Falsi convergence 
#' (default is 0.01).
#'
#' @name param-tolerance
#'
#' @keywords internal
NULL

# Parameters for the high-level wrapper functions

#' Parameter 'ns_splits'
#'
#' @param ns_splits An integer vector of years used to split the data into homogeneous
#' subperiods. For S-FFA, set to `NULL` (default). For NS-FFA, specify an *integer* vector 
#' of years with physical justification for change points, or `NULL` if no such years exist. 
#' In R, integers have the suffix `L`, so `1950L` is a valid input to `ns_splits`, but `1950` 
#' is not (since it may be interpreted as a floating point number).
#'
#' @name param-ns-splits
#'
#' @keywords internal
NULL

#' Parameter 'ns_structures'
#'
#' @param ns_structures For S-FFA, set to `NULL` (default) to use a stationary model 
#' for all homogeneous subperiods. For NS-FFA, provide a list of `length(ns_splits) + 1` 
#' sublists specifying the nonstationary model structure for each homogeneous subperiod. 
#' Each sublist must contain logical elements `location` and `scale`, indicating 
#' monotonic trends in the mean and variability, respectively. 
#'
#' @name param-ns-structures
#'
#' @keywords internal
NULL

#' Parameter 'generate_report'
#'
#' @param generate_report If `TRUE` (default), generate a report.
#'
#' @name param-generate-report
#'
#' @keywords internal
NULL

#' Parameter 'report_path'
#'
#' @param report_path A character scalar, the file path for the generated report. 
#' If `NULL` (default), the report will be saved to a new temporary directory.
#'
#' @name param-report-path
#'
#' @keywords internal
NULL

#' Parameter 'report_formats'
#'
#' @param report_formats A character vector specifying the output format for the 
#' report. Supported values are `"md"`, `"pdf"`, `"html"`, and `"json"`.
#'
#' @name param-report-formats
#'
#' @keywords internal
NULL


