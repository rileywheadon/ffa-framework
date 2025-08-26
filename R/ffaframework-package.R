#' Flood Frequency Analysis Framework
#'
#' @description
#' This package provides tools for stationary (S-FFA) and nonstationary (NS-FFA) 
#' flood flood frequency analysis of annual maximum series data. High-level wrapper 
#' functions with the `framework_*` prefix orchestrate the EDA and/or FFA modules from 
#' \href{doi:10.1016/j.envsoft.2024.105940}{Vidrio-Sahagún et al. (2024)} and generate
#' reports. Users who wish to develop customized workflows may use methods with 
#' the following prefixes:
#' 
#' 1. `eda_*`: Explore annual maximum series data for evidence of nonstationarity to 
#'    inform approach selection (S-FFA or NS-FFA):
#' 	  - Detect statistically significant change points.
#' 	  - Detect statistically significant temporal trends in the *mean* and *variability*.
#' 2. `select_*`: Select a suitable probability distribution using the L-moments.
#' 3. `fit_*`: Fit parameters given a distribution and approach (S-FFA or NS-FFA).
#' 4. `uncertainty_*`: Quantify uncertainty by computing confidence intervals.
#' 5. [model_assessment()] evaluates model performance using a variety of metrics.
#' 
#' Additional utility functions for visualization and computation are also available:
#' 
#' - `data_*` methods load, transform, and decompose annual maximum series data.
#' - `plot_*` methods produce diagnostic and summary plots.
#' - `utils_*` methods implement distribution-specific computations.
#'
#' Datasets from five hydrometric stations in Canada are provided as representative 
#' use cases (other datasets in `/inst/extdata` are for testing purposes only):
#' 
#' - Athabasca River at Athabasca (CAN-07BE001): An unregulated station with no 
#'   statistical evidence of trends or change points (S-FFA recommended).
#' - Kootenai River at Porthill (CAN-08NH21): A regulated station with
#'   evidence of an abrupt change in mean in 1972 (piecewise NS-FFA recommended).
#' - Bow River at Banff (CAN-05BB001). An unregulated station with statistical
#'   evidence of a trend in the mean (NS-FFA recommended).
#' - Chilliwack River at Chilliwack Lake (CAN-08MH016): An unregulated station
#'   with statistical evidence of a linear trend in variability (NS-FFA recommended).
#' - Okanagan River at Penticton (CAN-08NM050): A regulated station with statistical 
#'   evidence of a linear trend in both the mean and variability (NS-FFA recommended).
#' 
#' This package assumes familiarity with statistical techniques used in FFA, including 
#' parameter estimation (e.g., L-moments and maximum likelihood), dataset decomposition, 
#' and uncertainty quantification (parametric bootstrap and profile likelihood). For 
#' an explanation of these methods, see the 
#' [FFA Framework wiki](https://rileywheadon.github.io/ffa-framework/).
#' For examples, see the vignettes on exploratory data analysis and flood frequency 
#' analysis.
#'
#' @name ffaframework-package
#'
#' @keywords package
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
NULL
