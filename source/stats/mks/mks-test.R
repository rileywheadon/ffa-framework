# Mann-Kendall-Sneyers test for detecting the beginning of a trend 
test <- function(df, alpha) {

	# Compute number of elements such that ams[i] > ams[j] for all j < i < t for all t.
	s_statistic <- function(vt, ams) {

		# Computes the number of elements such that ams[i] > ams[j] for j < i (given i).
		sum_i <- function(i) sum(ams[i] > ams[1:i-1])

		# Applies the sum_i function to a vector values.
		n_i <- sapply(vt, sum_i)

		# Compute cumulative sum of n_i values to get the S-statistic for all t.
		cumsum(n_i)
	}

	# Compute the forward and backwards s-statistics
	idx = 1:length(df$max)
	s_prog_non_normal <- s_statistic(idx, df$max)
	s_regr_non_normal <- s_statistic(idx, rev(df$max))

	# Get the variance and expectation of the S-statistics
	s_expectation = idx * (idx - 1) / 4
	s_variance = (idx * (idx - 1) * ((2 * idx) + 5)) / 72

	# Prevent a division by zero error at idx = 1
	s_variance[s_variance == 0] <- 1

	# Compute the normalized progressive and regressive s-statistics
	s_prog <- (s_prog_non_normal - s_expectation) / sqrt(s_variance)
	s_regr <- rev((s_regr_non_normal - s_expectation) / sqrt(s_variance))

	# Compute confidence bounds for the normalized s-statistics
	bound <- qnorm(1 - (alpha / 2))

	# Find the statistically significant crossings between progressive/regressive series
	s_sign <- sign(s_prog - s_regr)
	cross <- which(s_sign[-1] != s_sign[-length(s_sign)])
	cross <- cross[abs(s_prog[cross]) > bound & abs(s_regr[cross]) > bound]

	# Return a list of values results from the test
	mget(c("s_prog", "s_regr", "bound", "cross"))
	
}


