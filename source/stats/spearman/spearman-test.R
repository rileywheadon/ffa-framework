# Spearman test for serial correlation
test <- function(df, alpha) {

	# Assign a variable to the AMS series and number of data points for convenience
	ams <- df$max
	n <- length(ams)

	# Compute the spearman rho-autocorrelation for a given lag
	rho_autocorrelation <- function(lag, ams) {
		ams_lagged <- ams[(lag + 1):length(ams)]
		ams_original <- ams[1:(length(ams) - lag)]
		cor.test(ams_original, ams_lagged, method="spearman", exact=FALSE)
	}

	# Find the lowest non-significant serial correlation lag
	rho <- numeric(n - 3)
	ps <- numeric(n - 3)

	for (i in 1:(n - 3)) {
		result <- rho_autocorrelation(i, ams)
		rho[i] = result$estimate
		ps[i] = result$p.value
	}

	least_lag <- which(ps > alpha)[1] - 1

	# Get a series of booleans for whether the serial correlation is significant
	sig <- (ps < alpha)
	
	# Return the results as a list
	mget(c("rho", "sig", "least_lag"))

}
