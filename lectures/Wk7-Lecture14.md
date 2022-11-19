---
title: Week 7, Lecture 14 - Gaussian Mixture Models
author: Aaron Meyer
---

# Outline

- Administrative Issues
- Gaussian mixtures
- Implementation

**Based on slides from David Sontag.**

# Gaussian mixtures


# The Evils of “Hard Assignments”?

- Clusters may overlap
- Some clusters may be “wider” than others
- Distances can be deceiving!

![ ](./lectures/figs/lec14/gm2.pdf){height=60%}

# Probabilistic Clustering

[columns]

[column=0.5]

- Try a probabilistic model!
	- Allows overlaps, clusters of different size, etc.
- Can tell a *generative story* for data
	- $P(X\mid Y) P(Y)$
- Challenge: we need to estimate model parameters without labeled Ys

[column=0.5]

![ ](./lectures/figs/lec14/gm3.pdf)

[/columns]

# The General GMM assumption

- $P(Y)$: There are k components
- $P(X\mid Y)$: Each component generates data from a *multivariate Gaussian* with mean $\mu_i$ and covariance matrix $\Sigma_i$

Each data point is sampled from a **generative process**:

1. Choose component i with probability $P(y=i)$
2. Generate datapoint $N(m_i, \Sigma_i)$

![ ](./lectures/figs/lec14/gm4.pdf){width=50%}

# What Model Should We Use?

- Depends on X.
- If we know which points are in a cluster, then we can define the best distribution for it.
	- Multinomial over clusters Y
	- (Independent) Gaussian for each $X_i$ given Y

$$p(Y_i = y_k) = \theta_k$$

$$P(X_i = x \mid Y = y_k) = N(x \mid \mu_{ik}, \sigma_{ik})$$

# Could we make fewer assumptions?

[columns]

[column=0.5]

- What if the $X_i$ co-vary?
- What if there are multiple peaks?
- **Gaussian Mixture Models!**
	- $P(Y)$ still multinormal
	- $P(\mathbf{X}\mid Y)$ is a *multivariate* Gaussian distribution:

$$P(X = x_j \mid Y = i) = N(x_j, \mu_i, \Sigma_i)$$

[column=0.5]

![ ](./lectures/figs/lec14/gm6.pdf)

[/columns]

# Multivariate Gaussians

![ ](./lectures/figs/lec14/gm7.pdf)

# Multivariate Gaussians

![ ](./lectures/figs/lec14/gm8.pdf)

# Multivariate Gaussians

![ ](./lectures/figs/lec14/gm9.pdf)

# Multivariate Gaussians

![ ](./lectures/figs/lec14/gm10.pdf)

# Mixtures of Gaussians (1)

Old Faithful Data Set

![ ](./lectures/figs/lec14/gm11.pdf)

# Mixtures of Gaussians (1)

Old Faithful Data Set

![ ](./lectures/figs/lec14/gm12.pdf)

# Mixtures of Gaussians (2)

Combine simple models into a complex model:

![ ](./lectures/figs/lec14/gm13.pdf)

# Mixtures of Gaussians (3)

![ ](./lectures/figs/lec14/gm14.pdf)

# Eliminating Hard Assignments to Clusters

Model data as mixture of multivariate Gaussians

![ ](./lectures/figs/lec14/gm15.pdf)

# Eliminating Hard Assignments to Clusters

Model data as mixture of multivariate Gaussians

![ ](./lectures/figs/lec14/gm16.pdf)

# Eliminating Hard Assignments to Clusters

Model data as mixture of multivariate Gaussians

![ ](./lectures/figs/lec14/gm17.pdf)

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

![ ](./lectures/figs/lec14/gm19.pdf){width=35%}

# How do we optimize? Closed Form?

- Maximize **marginal likelihood**: $$\arg\max_{\theta} \prod_j P(x_j) = \arg\max \prod_j \sum_{k=1}^K P(Y_j=k, x_j)$$
- Almost always a hard problem!
	- Usually no closed form solution
	- Even when lgP(X,Y) is convex, lgP(X) generally isn’t...
	- For all but the simplest P(X), we will have to do gradient ascent, in a big messy space with lots of local optima...

# Learning general mixtures of Gaussians

![ ](./lectures/figs/lec14/gm21.pdf)

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

![ ](./lectures/figs/lec14/gm24.pdf)

Especially useful when the E and M steps have closed form solutions!!!

# EM algorithm: Pictorial View

![ ](./lectures/figs/lec14/gm25.pdf)

# Simple example: learn means only!

![ ](./lectures/figs/lec14/gm26.pdf)

# EM for GMMs: only learning means

![ ](./lectures/figs/lec14/gm27.pdf)

# 

![ ](./lectures/figs/lec14/gm28.pdf)

# Gaussian Mixture Example: Start

![ ](./lectures/figs/lec14/gm29.pdf)

# After First Iteration

![ ](./lectures/figs/lec14/gm30.pdf)

# After 2nd Iteration

![ ](./lectures/figs/lec14/gm31.pdf)

# After 3rd iteration

![ ](./lectures/figs/lec14/gm32.pdf)

# After 4th iteration

![ ](./lectures/figs/lec14/gm33.pdf)

# After 5th iteration

![ ](./lectures/figs/lec14/gm34.pdf)

# After 6th iteration

![ ](./lectures/figs/lec14/gm35.pdf)

# After 20th iteration

![ ](./lectures/figs/lec14/gm36.pdf)

# What if we do hard assignments?

**Iterate:** On the t'th iteration let our estimates be $$\lambda_t = [\mu_{1}^{(t)}, \mu_{2}^{(t)}, \ldots \mu_{3}^{(t)}]$$

![ ](./lectures/figs/lec14/gm37.pdf)

Equivalent to k-means clustering algorithm!!!

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
