# FFA Uncertainty Quantification

Uncertainty for FFA estimates is typically expressed using a **Confidence Interval**.  Common methods for estimating uncertainty include hte **Bootstrap**, **Profile Likelihood**, and **Delta**.

## Parametric Bootstrap

1. Obtain a parametric estimate $\hat{F}$ of the population CDF $F$ using a sample size $n$.
2. Draw $N$ synthetic samples of size $n$ from $\hat{F}$.
3. Estimate parameters $\hat{\theta}_{j}$ for each synthetic sample ($j \in  \{1, \dots , N\}$).
4. Estimate quantiles $\hat{y}_{j} = F^{-1}(T;\hat{\theta}_{j})$ for each sample.
5. Derive the $(1 - \rho)$ confidence interval using the $\rho/2$ and $1-(\rho /2)$ quantiles.
