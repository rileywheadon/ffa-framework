# Create separate environments for auxillary tests
mk <- new.env()
spearman <- new.env()

# Load auxillary tests
source("stats/mk/mk-test.R", local = mk)
source("stats/spearman/spearman-test.R", local = spearman)


# Block-Bootstrap Mann-Kendall test for identifying non-autocorrelated trends
test <- function(df, alpha) {

	# Assign a variable to the AMS series and number of data points for convenience
	ams <- df$max
	n <- length(ams)

	# These variables should come from other statistical tests
	least_lag <- spearman$test(df, alpha)$least_lag
	s_statistic  <- mk$test(df, alpha)$s

	# Create blocks
	block_size <- least_lag + 1
	n_blocks <- ceiling(n / block_size)
	blocks <- split(ams[1:(n_blocks * block_size)], rep(1:n_blocks, each = block_size))

	# Loop through the bootstrap
	reps <- 10000
	s_bootstrap <- numeric(reps)
	for (sample in 1:reps) {

		# Sample blocks for this iteration
		sampled_blocks <- sample(blocks, n_blocks, replace = FALSE)
		resampled_series <- unlist(sampled_blocks, use.names = FALSE)
		ams_resampled <- resampled_series[!is.na(resampled_series)]

		# Compute the Mann-Kendall statistic for this iteration
		s <- 0
		for (i in 1:(n-1)) {
			for (j in (i+1):n) {
				s = s + sign(ams_resampled[j] - ams_resampled[i])
			}
		}

		s_bootstrap[sample] = s
	}

	# Compute the p-value empirically using the bootstrap distribution
	p_value <- ifelse(
		s_statistic < 0, 
		2 * mean(s_statistic >= s_bootstrap),
		2 * mean(s_statistic <= s_bootstrap)
	)

	# Compute the CI bounds
	bounds <- quantile(s_bootstrap, c(0.025, 0.975))

	# Return the results as a list
	mget(c("s_bootstrap", "s_statistic", "p_value", "bounds"))

}

