# Perform Data Screening

Checks for missing entries and generates a list of summary statistics
about a dataset.

## Usage

``` r
data_screening(data, years)
```

## Arguments

- data:

  Numeric vector of observed annual maximum series values. Must be
  strictly positive, finite, and not missing.

- years:

  Numeric vector of observation years corresponding to `data`. Must be
  the same length as `data` and strictly increasing.

## Value

A list with seven entries:

- `years_min`: The minimum value in the 'years' argument.

- `years_max`: The maximum value in the 'years' argument.

- `data_min`: The minimum value in the 'data' argument.

- `data_med`: The median value in the 'data' argument.

- `data_max`: The maximum value in the 'data' argument.

- `missing_years`: An integer vector of years with no data.

- `missing_count`: The number of missing entries in the dataset.

## Examples

``` r
data <- rnorm(n = 10, mean = 100, sd = 10)
years <- c(1900, 1902, 1903, 1904, 1905, 1907, 1909, 1911, 1912, 1914)
data_screening(data, years)
#> $years_min
#> [1] 1900
#> 
#> $years_max
#> [1] 1914
#> 
#> $data_min
#> [1] 75.5332
#> 
#> $data_med
#> [1] 96.49233
#> 
#> $data_max
#> [1] 126.4893
#> 
#> $missing_years
#> [1] 1901 1906 1908 1910 1913
#> 
#> $missing_count
#> [1] 5
#> 
```
