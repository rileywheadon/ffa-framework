test_that("framework-eda.R works on KOOTENAI RIVER (08NH021) with no splits", {

	df <- data_local("CAN-08NH021.csv")

	results <- framework_eda(
		df$max,
		df$year,
		generate_report = FALSE
	)

	expect_true(is.list(results))
	expect_equal(length(results$submodule_results), 2)

	recommendations <- results$eda_recommendations
	expect_equal(recommendations$approach, "Piecewise NS-FFA")
	expect_equal(recommendations$ns_splits, 1972)
	expect_equal(recommendations$ns_structures, list(S01))

})

test_that("framework-eda.R works on KOOTENAI RIVER (08NH021) with splits", {

	df <- data_local("CAN-08NH021.csv")

	results <- framework_eda(
		df$max,
		df$year,
		ns_splits = 1972,
		generate_report = FALSE
	)

	expect_true(is.list(results))
	expect_equal(length(results$submodule_results), 3)

	recommendations <- results$eda_recommendations
	expect_equal(recommendations$approach, "Piecewise NS-FFA")
	expect_equal(recommendations$ns_splits, 1972)
	expect_equal(recommendations$ns_structures, list(S10, S10))

})
