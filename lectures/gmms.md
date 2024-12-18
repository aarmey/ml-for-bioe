---
title: Gaussian Mixture Models
author: Aaron Meyer
---

# Outline

- Administrative Issues
- Gaussian mixtures
- Implementation

**Based on slides from David Sontag.**

# The Evils of “Hard Assignments”?

- Clusters may overlap
- Some clusters may be “wider” than others
- Distances can be deceiving!

![ ](./lectures/figs/gmms/gm2.webp)

\note{If we know which points are in each cluster, the answer is easy! (mu, sigma)}

# Probabilistic Clustering

::: columns

:::: column
- Try a probabilistic model!
	- Allows overlaps, clusters of different size, etc.
- Can tell a *generative story* for data
	- $P(X\mid Y) P(Y)$
- Challenge: we need to estimate model parameters without labeled Ys
::::

:::: column
![ ](./lectures/figs/gmms/gm3.webp)
::::

:::

# The General GMM assumption

- $P(Y)$: There are k components
- $P(X\mid Y)$: Each component generates data from a *multivariate Gaussian* with mean $\mu_i$ and covariance matrix $\Sigma_i$

Each data point is sampled from a **generative process**:

1. Choose component i with probability $P(y=i)$
2. Generate datapoint $N(m_i, \Sigma_i)$

![ ](./lectures/figs/gmms/gm4.webp)

# What Model Should We Use?

- Depends on X.
- If we know which points are in a cluster, then we can define the best distribution for it.
	- Multinomial over clusters Y
	- (Independent) Gaussian for each $X_i$ given Y

$$p(Y_i = y_k) = \theta_k$$

$$P(X_i = x \mid Y = y_k) = N(x \mid \mu_{ik}, \sigma_{ik})$$

# Could we make fewer assumptions?

::: columns

:::: {.column width=50%}
- What if the $X_i$ co-vary?
- What if there are multiple peaks?
- **Gaussian Mixture Models!**
	- $P(Y)$ still multinormal
	- $P(\mathbf{X}\mid Y)$ is a *multivariate* Gaussian distribution:

$$P(X = x_j \mid Y = i) = N(x_j, \mu_i, \Sigma_i)$$
::::

:::: {.column width=50%}
![ ](./lectures/figs/gmms/gm6.webp)
::::

:::

# Multivariate Gaussians

![ ](./lectures/figs/gmms/gm7.webp)

# Multivariate Gaussians

![ ](./lectures/figs/gmms/gm8.webp)

# Multivariate Gaussians

![ ](./lectures/figs/gmms/gm9.webp)

# Multivariate Gaussians

![ ](./lectures/figs/gmms/gm10.webp)

# Mixtures of Gaussians (1)

Old Faithful Data Set

![ ](./lectures/figs/gmms/gm11.webp)

# Mixtures of Gaussians (1)

Old Faithful Data Set

![ ](./lectures/figs/gmms/gm12.webp)

# Mixtures of Gaussians (2)

Combine simple models into a complex model:

![ ](./lectures/figs/gmms/gm13.webp)

\note{$p(x\; is\; k) = \frac{\pi_k N(x|\mu_k, \Sigma_k)}{\sum_{k=1}^{N}}$}

# Mixtures of Gaussians (3)

![ ](./lectures/figs/gmms/gm14.webp)

# Eliminating Hard Assignments to Clusters

Model data as mixture of multivariate Gaussians

![ ](./lectures/figs/gmms/gm15.webp)

# Eliminating Hard Assignments to Clusters

Model data as mixture of multivariate Gaussians

![ ](./lectures/figs/gmms/gm16.webp)

# Eliminating Hard Assignments to Clusters

Model data as mixture of multivariate Gaussians

![ ](./lectures/figs/gmms/gm17.webp)

Shown is the posterior probability that a point was generated from $i$th Gaussian: $Pr(Y = i \mid x)$

# ML estimation in **supervised** setting

- Univariate Gaussian

$$\mu_{MLE} = \frac{1}{N}\sum_{i=1}^N x_i \quad\quad \sigma_{MLE}^2 = \frac{1}{N}\sum_{i=1}^N (x_i -\hat{\mu})^2$$

- **Mixture** of **Multi**variate Gaussians
	- ML estimate for each of the Multivariate Gaussians is given by:

$$\mu_{ML}^k = \frac{1}{n} \sum_{j=1}^n x_n \quad\quad \Sigma_{ML}^k = \frac{1}{n}\sum_{j=1}^n \left(\mathbf{x}_j - \mu_{ML}^k\right)  \left(\mathbf{x}_j - \mu_{ML}^k\right)^T$$

Just sums over $x$ generated from the $k$'th Gaussian

# But what if unobserved data?

- MLE:
	- $\arg\max_\theta \prod_j P(y_i, x_j)$
	- $\theta$: all model parameters
		- eg, class probs, means, and variances
- But we don't know $y_j$'s!
- Maximize **marginal likelihood**:
	- $\arg\max_\theta \prod_j P(x_j) = \arg\max_\theta \prod_j \sum_{k=1}^K P(Y_j=k, x_j)$

![ ](./lectures/figs/gmms/gm19.webp)

# How do we optimize? Closed Form?

- Maximize **marginal likelihood**: $$\arg\max_{\theta} \prod_j P(x_j) = \arg\max \prod_j \sum_{k=1}^K P(Y_j=k, x_j)$$
- Almost always a hard problem!
	- Usually no closed form solution
	- Even when lgP(X,Y) is convex, lgP(X) generally isn’t...
	- For all but the simplest P(X), we will have to do gradient ascent, in a big messy space with lots of local optima...

# Learning general mixtures of Gaussians

![ ](./lectures/figs/gmms/gm21.webp)

- Need to differentiate and solve for $\mu_k$, $\sum_k$, and P(Y=k) for k=1..K
- There will be no closed form solution, gradient is complex, lots of local optimum
- **Wouldn’t it be nice if there was a better way!?!**

# EM

## Expectation Maximization

# The EM Algorithm

- A clever method for maximizing marginal likelihood:
	- $\arg\max_{\theta} \prod_j P(x_j) = \arg\max_{\theta} \prod_j \sum_{k=1}^K P(Y_j=k, x_j)$
	- A type of gradient ascent that can be easy to implement
		- e.g. no line search, learning rates, etc.
- Alternate between two steps:
	- Compute an expectation
	- Compute a maximization
- Not magic: **still optimizing a non-convex function with lots of local optima**
	- The computations are just easier (often, significantly so!)

# EM: Two Easy Steps

![ ](./lectures/figs/gmms/gm24.webp)

Especially useful when the E and M steps have closed form solutions!!!

# EM algorithm: Pictorial View

![ ](./lectures/figs/gmms/gm25.webp)

# Simple example: learn means only!

![ ](./lectures/figs/gmms/gm26.webp)

# EM for GMMs: only learning means

![ ](./lectures/figs/gmms/gm27.webp)

# 

![ ](./lectures/figs/gmms/gm28.webp)

# Gaussian Mixture Example: Start

![ ](./lectures/figs/gmms/gm29.webp)

# After First Iteration

![ ](./lectures/figs/gmms/gm30.webp)

# After 2nd Iteration

![ ](./lectures/figs/gmms/gm31.webp)

# After 3rd iteration

![ ](./lectures/figs/gmms/gm32.webp)

# After 4th iteration

![ ](./lectures/figs/gmms/gm33.webp)

# After 5th iteration

![ ](./lectures/figs/gmms/gm34.webp)

# After 6th iteration

![ ](./lectures/figs/gmms/gm35.webp)

# After 20th iteration

![ ](./lectures/figs/gmms/gm36.webp)

# What if we do hard assignments?

**Iterate:** On the t'th iteration let our estimates be $$\lambda_t = [\mu_{1}^{(t)}, \mu_{2}^{(t)}, \ldots \mu_{3}^{(t)}]$$

![ ](./lectures/figs/gmms/gm37.webp)

Equivalent to k-means clustering algorithm!!!

\note{Can you make a mixture model of Gamma distributions? Poisson?}

# Implementation

`sklearn.mixture.GaussianMixture` implements GMMs within `sklearn`.

- `GaussianMixture` creates the class
	- `n_components` indicates the number of Gaussians to use.
	- `covariance_type` is type of covariance
		- `full`
		- `spherical`
		- `diag`
		- `tied` means all components share the same covariance matrix
	- `max_iter` is EM iterations to use

- Functions
	- `M.fit(X)` fits using the EM algorithm
	- `M.predict_proba(X)` is the posterior probability of each component given the data
	- `M.predict(X)` predict the class labels of each data point

# Further Reading

- [`sklearn.mixture.GaussianMixture`](https://scikit-learn.org/stable/modules/generated/sklearn.mixture.GaussianMixture.html#sklearn.mixture.GaussianMixture)
- [Python Data Science Handbook: GMMs](https://jakevdp.github.io/PythonDataScienceHandbook/05.12-gaussian-mixtures.html)
