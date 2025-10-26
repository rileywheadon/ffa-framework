test_that("data-local.R and data-geomet.R work properly and produce same results", {

	# Local Data
	csv_df <- data_local("CAN-07BE001.csv")
    expect_true("year" %in% names(csv_df))
    expect_true("max" %in% names(csv_df))
	expect_equal(ncol(csv_df), 2)
	expect_equal(nrow(csv_df), 102)

	# GeoMet Data
	geomet_df <- data_geomet("07BE001")
	geomet_df <- subset(geomet_df, year <= 2025)
    expect_true("year" %in% names(geomet_df))
    expect_true("max" %in% names(geomet_df))
	expect_equal(ncol(geomet_df), 2)

	# Comparision Test (only check common years)
	years <- intersect(csv_df$year, geomet_df$year)
	csv_df <- subset(csv_df, year %in% years)
	geomet_df <- subset(geomet_df, year %in% years)
	expect_equal(csv_df$max, geomet_df$max)

})

test_that("data-local.R and data-geomet.R throws errors given invalid arguments", {

	# Invalid CSV file name
	expect_error(data_local("invalid"), "File 'invalid' does not exist")

	# Invalid station ID
	expect_error(data_geomet("invalid"), "No data exists for station with ID 'invalid'")

})
