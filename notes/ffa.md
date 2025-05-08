# Flood Frequency Analysis

## Plan

Porting scripts to R:

- Write statistical tests from scratch.
- Use `ggplot2` as a plotting framework.
- Write unit tests using `testthat`.

Then, once I have a good framework in R, improve MATLAB code.

Finally, build a GUI application, a web app, and port to CRAN.

Alternatively, work on adding more features/tests to the framework.

## Philosophy

- Write code that *mirrors the mathematics*.
- Focus on building a framework for practical use, without academic jargon.
- Ensure that the user will have as much information as they want. 
- Prevent coupling whenever possible by writing standalone R scripts.
- Follow this style guide: http://adv-r.had.co.nz/Style.html

## Design

Each of the statistical tests conducted during EDA can be run independently:

- Run the tests using `Rscript run-stats.R`
- `-n`: name of the statistical test to run (required)
- `-c`: path to configuration file (required)
- `-v`: verbosity level: statistical information, mathematics, code
- `-s`: years on which to split the data (only for some tests)

## Todo

Improvements to `run-stats.R`

- [ ] Save plots created with `run-stats.R` to a subdirectory in the reports folder
- [ ] Add `[name]-report.rmd` files and implement report generation
- [ ] Add verbosity options for report generation (stats, math, code)
- [ ] Add data splitting for the non-change-point tests
- [ ] Write unit tests using `testthat` for all data files and splits

Finishing the EDA scripts

- [ ] Implement PP test scripts
- [ ] Implement KPSS test scripts
- [ ] Implement White test scripts
- [ ] Implement MW-MK test scripts
- [ ] Implement Sen's trend estimator scripts

Implementing the full EDA pipeline

- [ ] Create the EDA pipeline by calling `run-stats.R` repeatedly
- [ ] Implement the decision point for change points in `main.R`
- [ ] Generate a big report by combining the `[name]-report.rmd` files

## Notes

- stationary-ffa.md
- ffa-uncertainty.md
- non-stationary-ffa.md
- regula-falsi.md

