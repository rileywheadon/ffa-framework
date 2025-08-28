# ffaframework 0.1.1

- Add support for report generation using serialized plots.

## Bug Fixes

- Fix error on CRAN by using `generate_report = FALSE` during testing of `framework_*` functions.
- `plot_*_estimates` now displays confidence intervals generated using custom return periods.
- `framework_full` now works properly when a custom `report_path` is provided.

# ffaframework 0.1.0

- Run EDA, FFA, or both using the `framework_*` high-level wrapper functions.
- Use the `eda_*` functions to explore annual maximum series data for evidence of nonstationarity and inform approach selection (S-FFA or NS-FFA). This includes detecting statistically significant change points and temporal trends (in both the mean and variability).
- Use the `select_*` functions to choose a suitable probability distribution using the L-moments.
- Use the `fit_*` functions to estimate parameters for a given distribution and modelling approach.
- Use the `uncertainty_*` functions to quantify uncertainty by computing confidence intervals.
- Use the `model_assessment` function to evaluate model performance using a variety of metrics.

Additional utility functions for visualization and computation are also available:

- `data_*` functions load, transform, and decompose annual maximum series data.
- `plot_*` functions produce diagnostic and summary plots.
- `utils_*` functions implement distribution-specific computations.
