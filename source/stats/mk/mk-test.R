# Mann-Kendall test for trends
test <- function(df, alpha) {

	# Assign a variable to the AMS series and number of data points for convenience
	ams <- df$max
	n <- length(ams)

	# Compute the test statistic S by iterating through all pairs of values in ams
	s <- 0
	for (i in 1:(n-1)) {
		for (j in (i+1):n) {
			s = s + sign(ams[j] - ams[i])
		}
	}

	# Identify tied groups and find the number of elements in each group
	freqs <- table(ams)         # Frequency of each data point
	ties <- freqs[freqs > 1]    # Get data points with frequency > 1 (i.e. ties)
	g <- length(ties)           # Get the total number of groups
	tp <- as.vector(ties)       # Get a vector of group sizes

	# Compute the normalized test statistic Z
	s_variance <- (1/18) * ((n * (n-1) * (2*n + 5)) + sum(tp * (tp-1) * (2*tp + 5)))

	z <- if (s > 0) { 
		(s - 1) / sqrt(s_variance) 
	} else if (s == 0) { 
		0 
	} else { 
		(s + 1) / sqrt(s_variance) 
	}

	# Compute the p-value for a two-sided test
	p_value <- 2 * pnorm(abs(z), lower.tail=FALSE)

	# Return the results of the test as a list
	mget(c("s", "p_value"))

}

