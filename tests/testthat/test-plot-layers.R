test_that("AMS plots only add enabled line layers", {
	df <- data_local("CAN-08NM050.csv")
	options <- expand.grid(
		plot_mean = c("None", "Constant", "Trend"),
		plot_variability = c("None", "Constant", "Trend"),
		show_line = c(FALSE, TRUE),
		stringsAsFactors = FALSE
	)

	for (i in seq_len(nrow(options))) {
		args <- as.list(options[i, ])
		p <- do.call(plot_ams_data, c(list(data = df$max, years = df$year), args))

		expected_lines <- (
			as.integer(args$show_line) +
			as.integer(args$plot_mean != "None") +
			2L * as.integer(args$plot_variability != "None")
		)
		
		observed_lines <- sum(
			vapply(p$layers, function(layer) inherits(layer$geom, "GeomLine"), logical(1))
		)

		expect_equal(length(p$layers), 1L + expected_lines, info = paste(options[i, ], collapse = ", "))
		expect_s3_class(p$layers[[1]]$geom, "GeomPoint")
		expect_equal(observed_lines, expected_lines)
	}
})

test_that("show_line only controls the data line in multi-panel plots", {
	df <- data_local("CAN-08NM050.csv")
	plots <- list(
		list(
			plot = plot_sffa_fit,
			results = fit_lmoments(df$max, "GEV"),
			geoms = c("GeomPoint")
		),
		list(
			plot = plot_nsffa_fit,
			results = fit_mle(df$max, "GEV", df$year, S11),
			geoms = c("GeomPoint", "GeomVline")
		),
		list(
			plot = plot_pettitt_test,
			results = eda_pettitt_test(df$max, df$year),
			geoms = c("GeomPoint", "GeomSegment", "GeomPoint")
		)
	)

	for (case in plots) {
		without_line <- case$plot(case$results, show_line = FALSE)
		with_line <- case$plot(case$results, show_line = TRUE)

		geom_classes <- function(p) {
			vapply(p$layers, function(layer) class(layer$geom)[1], character(1))
		}

		# The first panel's density/statistic lines must be unaffected.
		expect_identical(geom_classes(without_line[[1]]), geom_classes(with_line[[1]]))
		expect_identical(unname(geom_classes(without_line[[2]])), case$geoms)
		expect_identical(unname(geom_classes(with_line[[2]])), append(case$geoms, "GeomLine", after = 1))
	}
})
