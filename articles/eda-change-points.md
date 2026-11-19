# Change Point Detection

The EDA module of the FFA Framework includes two statistical tests for
detecting change points in annual maximum series data: the
**Mann-Kendall-Sneyers (MKS) test** and the **Pettitt test**.

------------------------------------------------------------------------

## Mann-Kendall-Sneyers Test

The **Mann-Kendall-Sneyers (MKS) test** detects a *trend change* in a
time series:

- Null hypothesis: There are no change points.
- Alternative hypothesis: There are *one or more* change points.

Define \\\mathbb{I}(y\_{i} \> y\_{j})\\ to be \\1\\ if \\y\_{i} \>
y\_{j}\\ and \\0\\ otherwise.

Given a time series \\y\_{1}, \dots, y\_{n}\\, we compute the
*progressive series* \\S^{F}\_{t}\\:

\\ S^{F}\_{t} = \sum\_{i=i}^{t} \sum\_{j=1}^{i-1} \mathbb{I}(y\_{i} \>
y\_{j}) \\

Next, we reverse the time series \\y\\. This gives us a new time series
\\y'\\ such that \\y\_{i}' = y\_{n+1-i}\\. Then we compute the
*regressive series* \\S^{B}\_{t}\\, where \\\text{rev}()\\ indicates
that the vector is reversed:

\\ S^{B}\_{t} = \text{rev}\left( \sum\_{i=i}^{t} \sum\_{j=1}^{i-1}
\mathbb{I}(y'\_{i} \> y'\_{j})\right) \\

Then, we compute the *normalized progressive series* \\UF\_{t}\\ and
*normalized regressive series* \\UB\_{t}\\:

\\ UF\_{t} = \frac{S^{F}\_{t} -
\mathbb{E}\[S^{F}\_{t}\]}{\sqrt{\text{Var}\\(S^{F}\_{t})}}, \quad
UB\_{t} = \frac{S^{B}\_{t} -
\mathbb{E}\[S^{B}\_{t}\]}{\sqrt{\text{Var}\\(S^{B}\_{t})}} \\

For both the progressive and regressive series, the expectation and
variance are as follows:

\\ \mathbb{E}\[S^{F}\_{t}\] = \mathbb{E}\[S^{B}\_{t}\] =
\frac{t(t-1)}{4}, \quad \text{Var}(S^{F}\_{t}) = \text{Var}(S^{B}\_{t})
= \frac{t(t-1)(2t+5)}{72} \\

Finally, we plot \\UF\_{t}\\ and \\UB\_{t}\\ with confidence bounds at
the \\\alpha/2\\ and \\1 - (\alpha /2)\\ quantiles of the standard
normal distribution, where \\\alpha\\ is the chosen significance level.
A crossing point between \\UF\_{t}\\ and \\UB\_{t}\\ that lies outside
the confidence bounds is a potential change point.

### Example Plot

![](../reference/figures/plot-mks.svg)

------------------------------------------------------------------------

## Pettitt Test

The **Pettitt test** detects abrupt changes in the mean of a time
series.

- Null hypothesis: There are no abrupt changes.
- Alternative hypothesis: There is *one* abrupt change.

Define \\\text{sign}(x)\\ to be \\1\\ if \\x \> 0\\, \\0\\ if \\x = 0\\,
and \\-1\\ otherwise.

Given a time series \\y\_{1}, \dots, y\_{n}\\, compute the following
test statistic:

\\ U\_{t} = \sum\_{i=1}^{t} \sum\_{j=t+1}^{n} \text{sign} (y\_{j} -
y\_{i}), \quad K = \max\_{t}\|U\_{t}\| \\

The value of \\t\\ such that \\U\_{t} = K\\ is a *potential change
point*. The p-value of the potential change point can be approximated
using the following formula for a one-sided test:

\\ p \approx \exp \left(-\frac{6K^2}{n^3 + n^2}\right) \\

If the p-value is less than the significance level \\\alpha\\, we reject
the null hypothesis and conclude that there is evidence for an abrupt
change in the mean at the potential change point.

### Example Plot

![](../reference/figures/plot-pettitt.svg)
