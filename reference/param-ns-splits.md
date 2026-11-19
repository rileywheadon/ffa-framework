# Parameter 'ns_splits'

Parameter 'ns_splits'

## Arguments

- ns_splits:

  An integer vector of years used to split the data into homogeneous
  subperiods. For S-FFA, set to `NULL` (default). For NS-FFA, specify an
  *integer* vector of years with physical justification for change
  points, or `NULL` if no such years exist. In R, integers have the
  suffix `L`, so `1950L` is a valid input to `ns_splits`, but `1950` is
  not (since it may be interpreted as a floating point number).
