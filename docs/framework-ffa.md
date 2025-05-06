# FFA Framework

Using framework-eda.md we identify one of four possible trend cases:

- No trend (i.e. no non-stationarity)
- Trend in AMS variability
- Trend in AMS mean
- Trend in both AMS variability and AMS mean

Then, use the case to choose whether to use S-FFA or NS-FFA. Next, we need to choose a metric which is used select the distribution. The metrics are:

- L-distance: Euclidian distance of (L-skewness, L-kurtosis) from the candidate.
- L-kurtosis: Distance of L-kurtosis from the candidate.
- Z-statistic: Resampled version of the L-kurtosis with a fixed random seed.

## Parameter Estimation

- For S-FFA, we use L-moments (see stationary-ffa.md).
- For NS-FFA, we use MLE (see non-stationary-ffa.md).
- With prior information, we use generalized MLE.

## Uncertainty Quantification

- For S-FFA, we use the parametric bootstrap (see stationary-ffa.md)
- For NS-FFA, we use *regula-falsi* profile likelihood.
- With prior information, we use *regula-falsi* generalized profile likelihood.
