## Background

### Profile Likelihood

*Profile Likelihood* is a technique for performing maximum likelihood estimation on non-stationary distributions. First, we reparameterize the distribution so that the parameters $\pmb\theta$ is time dependent. Sometimes, this involves adding extra parameters. Then, use MLE.

### Regula-Falsi

*Regula-Falsi* is a method for finding $x$ such that $f(x) = 0$ between points $x_{a} < x_{b}$. At each iteration,

1. Compute $x_{c} = (x_{b}f(x_{a}) - x_{a}f(x_{b}))/(f(x_{a}) - f(x_{b}))$.
2. If $|f(x_{c})| < \epsilon$, a predefined error tolerance, stop iterating.
3. Otherwise, change the interval to $[x_{a}, x_{c}]$ if $f(x_{a})f(x_{c}) < 0$ and $[x_{c}, x_{b}]$ if $f(x_{b})f(x_{c}) < 0$.

## Regula-Falsi Profile Likelihood

TBD
