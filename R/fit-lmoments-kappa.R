#' L-Moments Parameter Estimation for the Kappa Distribution
#'
#' This function estimates the parameters of the four-parameter Kappa distribution 
#' using the method of L-moments. Since no closed-form solution for the parameters 
#' in terms of the L-moments is known, the parameters are estimated numerically 
#' using Newton-Raphson iteration.
#'
#' @inheritParams param-data
#'
#' @details 
#' First, the sample L-moments of the data are computed using [utils_sample_lmoments()].
#' Then, the [stats::optim()] function is used to determine the parameters 
#' by minimizing the euclidian distance between the sample and theoretical L-moment
#' ratios. The implementation of this routine is based on the deprecated 'homtest'
#' package, formerly available at \url{https://CRAN.R-project.org/package=homtest}.
#'
#' @return A list containing the results of parameter estimation:
#' - `data`: The `data` argument.
#' - `distribution`: `"KAP"`.
#' - `method`: `"L-moments"`.
#' - `params`: numeric vector of 4 parameters in the order location, scale, shape (2).
#'
#' @seealso [utils_sample_lmoments()], [fit_lmoments()]
#'
#' @examples
#' data <- rnorm(n = 100, mean = 100, sd = 10)
#' fit_lmoments_kappa(data)
#'
#' @references
#' Hosking, J.R.M. & Wallis, J.R., 1997. Regional frequency analysis: an approach based 
#' on L-Moments. Cambridge University Press, New York, USA.
#'
#' @export
fit_lmoments_kappa <- function(data) {

	data <- validate_numeric("data", data, bounds = c(0, Inf))

	# Get the sample L-moments
	moments <- utils_sample_lmoments(data)
	l1 <- moments[1]
	l2 <- moments[2]
	t3 <- moments[3]
	t4 <- moments[4]

    result <- optim(c(1, 1), sumquad_tau3tau4, t3.t4 = c(t3, t4))

    if (result$value != -1) {
        k <- result$par[1]
        h <- result$par[2]
        params <- mu_sigma(l1, l2, k, h)
        mu <- params$mu
        sigma <- params$sigma
    }

	list(
		data = data,
		distribution = "KAP", 
		method = "L-moments",
		params = c(mu, sigma, k, h)
	)

}

#' Compute L-moment Distance for Kappa Distribution
#'
#' @keywords internal
sumquad_tau3tau4 = function (k.h, t3.t4) {

	k <- k.h[1]
	h <- k.h[2]
	t3 <- t3.t4[1]
	t4 <- t3.t4[2]

	if (((k < -1) && (h >= 0)) || ((h < 0) && ((k <= -1) || (k >= -1/h)))) {
		stop("Invalid parameters")
	}

	g <- c(0,0,0,0)

	# GUM Case
	if (k == 0 && h == 0) {
		tau3 <- log(9 / 8) / log(2)	
		tau4 <- (16 * log(2) - 10 * log(3)) / log(2)
	} 

	# GEV Case
	else if (h == 0) {
		tau3 <- 2*(1 - 3^(-k))/(1 - 2^(-k)) - 3
		tau4 <- (5*(1 - 4^(-k)) - 10*(1 - 3^(-k)) + 6*(1 - 2^(-k)))/(1 - 2^(-k))
	}

	# General Kappa Distribution
	else {
		for (r in 1:4) {
			if (h > 0) {
				g[r] <- (r*gamma(1+k)*gamma(r/h)) / (h^(1+k) *gamma(1+k+r/h))
			}
			else {
				g[r] <- (r*gamma(1+k)*gamma(-k-r/h)) / ((-h)^(1+k) *gamma(1-r/h))
			}
		}

		tau3 <- (-g[1] + 3*g[2] -2*g[3])/(g[1]-g[2])
		tau4 <- -(-g[1] + 6*g[2] -10*g[3] + 5*g[4])/(g[1]-g[2])
	}

	(t3-tau3)^2 + (t4-tau4)^2

}

#' Compute Location and Scale of Kappa Distribution
#'
#' @keywords internal
mu_sigma = function (l1, l2, k, h) {

	if (((k < -1) && (h >= 0)) || ((h < 0) && ((k <= -1) || (k >= -1/h)))) {
		stop("Invalid parameters")
	}

	g <- c(0,0)

	# GUM Case
	if (k == 0 && h == 0) {
		sigma <- l2 / log(2)
		mu <- l1 + digamma(1) * sigma
	}

	# GEV Case
	else if (h == 0) {
		sigma <- (l2 * k) / ((1 - 2^(-k)) * gamma(1 + k))
		mu <- l1 - sigma * (1 - gamma(1 + k)) / k
	}

	# General Kappa Distribution
	else {
		for (r in 1:2) {
			if (h > 0) {
				g[r] <- (r*gamma(1+k)*gamma(r/h)) / (h^(1+k) *gamma(1+k+r/h))
			}
			else {
				g[r] <- (r*gamma(1+k)*gamma(-k-r/h)) / ((-h)^(1+k) *gamma(1-r/h))
			}
		}

		sigma <- (l2 * k) / (g[1] - g[2])
		mu <- l1 - sigma*(1 - g[1]) / k

	}

	list(mu = mu, sigma = sigma)

}
