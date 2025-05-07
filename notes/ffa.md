# Flood Frequency Analysis

## Plan

Porting scripts to R:

- Write statistical tests from scratch.
- Use `ggplot2` as a plotting framework.
- Write unit tests to compare results with MATLAB.

Then, once I have a good framework in R, improve MATLAB code.

Finally, build a GUI application, a web app, and port to CRAN.

Alternatively, work on adding more features/tests to the framework.

## Philosophy

- Write code that *mirrors the mathematics*.
- Focus on building a framework for practical use, without academic jargon.
- Ensure that the user has all information possible before taking the next step.
- Prevent coupling whenever possible by writing standalone R scripts.

## Design

Each of the statistical tests conducted during EDA are independent R scripts:

- Command line arguments: 
    - path to a data file
    - directory for outputting an image (optional)
    - path to a configuration file (optional)
    - list of years at which to split the data (optional, only for some tests)
- Returns a text stream with test statistic, p-value, and conclusion.
- Saves figure to directory (or does nothing if directory isn't specified).

Report generation scripts simply call the statistical test scripts. 

## Todo

- [ ] Convert `change_points.R` to a standalone script (don't use `source`)
- [ ] Add decision point selection in `main.R`
- [ ] Implement MK test as standalone script
- [ ] Implement Spearman test as standalone script
- [ ] Implement BB-MK test as standalone script
- [ ] Implement PP test as standalone script
- [ ] Implement KPSS test as standalone script
- [ ] Implement White test as standalone script
- [ ] Implement MW-MK test as standalone script
- [ ] Implement Sen's trend estimator as standalone script

## Notes

- stationary-ffa.md
- ffa-uncertainty.md
- non-stationary-ffa.md
- regula-falsi.md

