# Parameter 'ns_structures'

Parameter 'ns_structures'

## Arguments

- ns_structures:

  For S-FFA, set to `NULL` (default) to use a stationary model for all
  homogeneous subperiods. For NS-FFA, provide a list of
  `length(ns_splits) + 1` sublists specifying the nonstationary model
  structure for each homogeneous subperiod. Each sublist must contain
  logical elements `location` and `scale`, indicating monotonic trends
  in the mean and variability, respectively.
