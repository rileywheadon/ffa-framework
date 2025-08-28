test_that("framework-ffa works on KOOTENAI RIVER (08NH021) with no splits/structures", {

	df <- data_local("CAN-08NH021.csv")

	results <- framework_ffa(
		df$max,
		df$year,
		generate_report = FALSE
	)

	expect_true(is.list(results))
	expect_equal(length(results$submodule_results), 4)

	assumptions <- results$modelling_assumptions
	expect_equal(assumptions$approach, "S-FFA")
	expect_equal(assumptions$ns_splits, integer(0))
	expect_equal(assumptions$ns_structures, list(S00))

})

test_that("framework-ffa works on KOOTENAI RIVER (08NH021) with splits/structures", {

	df <- data_local("CAN-08NH021.csv")

	results <- framework_ffa(
		df$max,
		df$year,
		1972, 
		list(S10, S10), 
		generate_report = FALSE
	)

	expect_true(is.list(results))
	expect_equal(length(results$submodule_results), 8)

	assumptions <- results$modelling_assumptions
	expect_equal(assumptions$approach, "Piecewise NS-FFA")
	expect_equal(assumptions$ns_splits, 1972)
	expect_equal(assumptions$ns_structures, list(S10, S10))

})
