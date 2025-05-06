# Non-Stationary FFA

**Non-Stationarity** occurs when the underlying stochastic process generating floods changes over time (due to climate change, for example). Some paproaches used to hanle non-stationarity include:

1. Use a more recent subsample to reflect up-to-date conditions in stationary FFA.
2. Add a safety factor to stationary FFA estimates.
3. Conduct nonstationary FFA (NS-FFA) by modelling a time-dependent distribution.

Typically NS-FFA uses a *decomposition-based approach*, which aims to split the probability distribution into stationary and non-stationary components.

## Maximum Likelihood Estimation

MLE finds the parameter values that maximize the probability (likleihood) of observing the data, given an assumed statistical model. Some advantages of MLE include:

1. Efficient if the assumed model is correct.
2. Flexible and applicable to various models.
3. Produces unbiased estimates in large samples.

However, MLE does have some disadvantages:

1. Requires assuming a probability distribution.
2. Requires optimization, which may be sensitive and/or computationally expensive.
3. Estimates may be biased in small samples.

**Procedure**: Given i.i.d. observations $x_{t} = \{x_{1}, \dots , x_{n}\}$, the likelihood $L(\pmb\theta)$ and log-likelihood $\ell(\pmb\theta)$ are:

$$
\begin{aligned}
L(\pmb\theta ; x_{t}) = \prod_{t=1}^{n} f(x_{t}; \pmb\theta ) \\[5pt]
\ell(\pmb\theta ;x_{t}) = \log [L(\pmb\theta ;x_{t})]
\end{aligned}
$$ 

The MLE $\hat{\pmb\theta}$ maximizes $L(\pmb\theta)$ or $\ell(\pmb\theta)$, which requires solving the following optimization problem:

$$
\hat{\pmb\theta} = \max_{\theta \in\Theta} L(\pmb\theta ;x_{t}) = \max_{\theta  \in  \Theta }\ell(\pmb\theta ;x_{t})
$$ 

