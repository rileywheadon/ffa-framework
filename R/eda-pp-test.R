#' Phillips–Perron Unit Root Test
#'
#' Applies the Phillips–Perron (PP) test to check for a unit root in annual
#' maximum series data. The null hypothesis assumes the time series contains a 
#' unit root (also known as a stochastic trend). The alternative hypothesis is that
#' the time series is trend-stationary with a deterministic linear trend.
#'
#' @inheritParams param-data
#' @inheritParams param-alpha
#'
#' @return A list containing the test results, including:
#' - `data`: The `data` argument.
#' - `alpha`: The significance level as specified in the `alpha` argument.
#' - `null_hypothesis`: A string describing the null hypothesis.
#' - `alternative_hypothesis`: A string describing the alternative hypothesis.
#' - `statistic`: The PP test statistic.
#' - `p_value`: Reported p-value from the test. See the details for more information.
#' - `reject`: If `TRUE`, the null hypothesis was rejected at significance `alpha`.
#'
#' @details
#' The implementation of this test is based on the 'aTSA' package, which 
#' interpolates p-values from the table of critical values presented in Fuller W. 
#' A. (1996). The critical values are only available for \eqn{\alpha \geq 0.01}. 
#' Therefore, a reported p-value of 0.01 indicates that \eqn{p \leq 0.01}.
#'
#' @references
#' Fuller, W. A. (1976). Introduction to Statistical Time Series. New York: 
#' John Wiley and Sons
#'
#' Phillips, P. C. B.; Perron, P. (1988). Testing for a Unit Root in Time Series 
#' Regression. Biometrika, 75 (2): 335-346
#'
#' @seealso [eda_kpss_test()]
#'
#' @examples
#' data <- rnorm(n = 100, mean = 100, sd = 10)
#' eda_pp_test(data)
#'
#' @importFrom stats embed
#' @export

eda_pp_test <- function(data, alpha = 0.05) {

	data <- validate_numeric("data", data, bounds = c(0, Inf))
	alpha <- validate_float("alpha", alpha, bounds = c(0.01, 0.1))

	# Construct time series yt and shifted time series yt1
	z <- embed(data ,2)
    yt <- z[,1]
    yt1 <- z[,2]

	# Set the number of Newey-West lags proportional to n^(1/4)
    n <- length(yt)
    q <- floor(4 * (n / 100)^0.25)

	# Create an autoregressive model with drift and trend 
    t <- 1:n
	model <- lm(yt ~ yt1 + t)

	# Get the residuals, estimate for rho, and estimate for the SE of rho
	residuals <- resid(model)
	rho <- summary(model)$coefficients[2,1]
	se_rho <- summary(model)$coefficients[2,2]

	# Compute the variance of the residuals (with n-3 degrees of freedom)
	sigma <- sum(residuals^2)/(n - 3)

	# Calculate the sample autocovariances and store them in a vector gamma
	gamma <- numeric(q + 1)
	for (i in 1:(q + 1)) {
		u <- embed(residuals, i)
		gamma[i] = sum(u[,1] * u[,i]) / n
	}

	# Compute an estimator of the long-run variance
	lambda <- gamma[1] + 2 * sum((1 - 1:q / (q + 1)) * gamma[-1])

	# Compute the test statistic z_rho
	z_rho <- n * (rho - 1) - (n^2 * se_rho^2) / sigma * (lambda - gamma[1]) / 2

	# Define table of Rho statistics from Fuller W. A. (1996) for model with drift and trend
    table_rho <- rbind(
		c(-22.5, -20.0, -17.9, -15.6, -8.49, -3.65, -2.51, -1.53, -0.46),
        c(-25.8, -22.4, -19.7, -16.8, -8.80, -3.71, -2.60, -1.67, -0.67),
        c(-27.4, -23.7, -20.6, -17.5, -8.96, -3.74, -2.63, -1.74, -0.76),
        c(-28.5, -24.4, -21.3, -17.9, -9.05, -3.76, -2.65, -1.79, -0.83),
        c(-28.9, -24.7, -21.5, -18.1, -9.08, -3.76, -2.66, -1.80, -0.86),
        c(-29.4, -25.0, -21.7, -18.3, -9.11, -3.77, -2.67, -1.81, -0.88)
	)
	
	# Define the columns, sizes, and quantiles used in the table
	columns <- ncol(table_rho)
	sizes <- c(25, 50, 100, 250, 500, 1000)
	quantiles <- c(.01, .025, .05, .10, .50, .90, .95, .975, .99)

	# Reduce table_rho to a 1D vector by interpolating on the sizes
	interpolated_size <- numeric(columns)
	for (j in 1:columns) { 
		interpolated_size[j] <- approx(sizes, table_rho[,j], n, rule = 2)$y
	}

	# Interpolate the p-value from the 1D vector of rho statistics
	p_value <- approx(interpolated_size, quantiles, z_rho, rule = 2)$y

	# Determine whether we reject or fail to reject based on p_value and alpha
	reject <- if (alpha == 0.10) p_value < alpha else p_value <= alpha

	# Set the P-value text to inform the user of the limited significance thresholds
	p_text <- if (p_value == 0.01) {
		"*at most* 0.01"
	} else {
		round(p_value, 3)
	}

	# Return the results as a list
	list(
		data = data,
		alpha = alpha,
		null_hypothesis = "The time series has a unit root (stochastic trend).",
		alternative_hypothesis = "The time series is trend-stationary.",
		statistic = z_rho,
		p_value = p_value,
		reject = reject
	)

}

