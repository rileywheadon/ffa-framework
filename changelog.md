## Improvements

- Specify configuration details in a single `config.yml` file.
- Use `knitr` and `rmarkdown` to generate an EDA report with a combination of text and images.
- Only show potential change points that are statistically significant in the Mann-Whitney-Pettitt and Mann-Kendall-Sneyers tests.

## Bugs

- Fix bug where Pettitt Test used number of data points *before* removing NaN values, resulting in artificially high p-values.

