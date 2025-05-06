# Count the number of elements ams[j] where j < i such that ams[i] > ams[j]
s_statistics <- function(idx, ams) {
	n_i <- sapply(idx, function(i) sum(ams[i] > ams[1:i-1]))
	cumsum(n_i)
}

# Conduct the Mann-Kendall-Sneyers test on a given dataframe
mks_test <- function(data, alpha) {

	# Get the annual max streaflow column without NaN values
	filtered_data <- data[!is.na(data$max), ]
	ams <- filtered_data$max
	n <- length(ams)

	# Get the variance and expectation of the U-statistics
	idx = 2:n
	U_variance = (idx * (idx - 1) * ((2 * idx) + 5)) / 72
	U_expectation = idx * (idx - 1) / 4

	# Compute the progressive/regressive normalized U-statistis
	Uf <- (s_statistics(idx, ams) - U_expectation) / sqrt(U_variance)
	Ub <- rev((s_statistics(idx, rev(ams)) - U_expectation) / sqrt(U_variance))

	# Determine the number of crossings
	crossings <- which((Uf[-length(Uf)] > Ub[-length(Ub)]) & (Uf[-1] < Ub[-1]) |
					   (Uf[-length(Uf)] < Ub[-length(Ub)]) & (Uf[-1] > Ub[-1]))

	# Return the number of crossings
	length(crossings)

}

