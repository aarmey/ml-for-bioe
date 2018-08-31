---
title: Week 7, Lecture 14 - Autodiff and Clustering Redux
author: Aaron Meyer
date: February 22, 2018
---

# Outline

- Administrative Issues
- Autodifferentiation
- Gaussian mixtures
- Implementation

**Based on slides from Håvard Berland and David Sontag.**

# What is automatic differentiation?

Automatic differentiation (AD) is software to transform code for one function into code for the derivative of the function.

![ ](./lectures/figs/lec14/autod3.pdf)

# Why automatic differentiation?

Scientific code often uses both functions *and* their derivatives:

- E.g. example Newtons method for solving (nonlinear) equations
- find $x$ such that $f(x)=0$

The Newton iteration is $$x_{n+1} = x_n − \frac{f(x_n)}{f′(x_n)}$$

But how to compute $f'(x_n)$ when we only know $f(x)$?

- Symbolic differentiation?
- Divided difference?
- Something else? **Yes!**

# Divided differences

![ ](./lectures/figs/lec14/autod5.pdf)

# Accuracy for divided differences on $f(x) = x^3$

![ ](./lectures/figs/lec14/autod6.pdf)

- Automatic differentiation will ensure desired accuracy.

# Dual numbers

![ ](./lectures/figs/lec14/autod7.pdf)

# Polynomials over dual numbers

![ ](./lectures/figs/lec14/autod8.pdf)

# Functions over dual numbers

![ ](./lectures/figs/lec14/autod9.pdf)

# Conclusion from dual numbers

- Derived from dual numbers:
	- A function applied on a dual number will return its derivative in the second/dual component.
- We can extend to functions of many variables by introducing more dual components: $$f(x_1, x_2) = x_1 x_2 + \sin(x_1)$$ extends to:

![ ](./lectures/figs/lec14/autod10.pdf)

where $d_i d_j = 0$.

# Decomposition of functions, the chain rule

![ ](./lectures/figs/lec14/autod11.pdf)

# Realization of automatic differentiation

Our current procedure:

1. Decompose original code into intrinsic functions
2. Differentiate the intrinsic functions, effectively symbolically
3. Multiply together according to the chain rule

How to “automatically” transform “original program” to “dual program”?

Three approaches:

- Source code transformation
- Operator overloading
- Computation graph

# Source code transformation by example

![ ](./lectures/figs/lec14/autod13.pdf)

# Source code transformation by example

![ ](./lectures/figs/lec14/autod14.pdf)

# Operator overloading

![ ](./lectures/figs/lec14/autod15.pdf)

# Source transformation vs. operator overloading

Source code transformation:

- Possible in all computer languages
- Can be applied to your old legacy Fortran/C code. Allows easier compile time optimizations.
- Source code swell
- More difficult to code the AD tool

Operator overloading:

- No changes in your original code
- Flexible when you change your code or tool Easy to code the AD tool
- Only possible in selected languages
- Current compilers lag behind, code runs slower

# Forward mode AD

- We have until now only described forward mode AD.
- Repetition of the procedure using the computational graph:

![ ](./lectures/figs/lec14/autod17.pdf)

# Reverse mode AD

- The chain rule works in both directions.
- The computational graph is now traversed from the top.

![ ](./lectures/figs/lec14/autod18.pdf)

# Jacobian computation

![ ](./lectures/figs/lec14/autod19.pdf){width=70%}

- One sweep of *forward mode* can calculate one column vector of the Jacobian, $J\dot{\mathbf{x}}$, where $\dot{\mathbf{x}}$ is a column vector of seeds.
- One sweep of *reverse mode* can calculate one row vector of the Jacobian, $\bar{\mathbf{y}}J$, where $\bar{\mathbf{y}}$ is a row vector of seeds.
- Computational cost of one sweep forward or reverse is roughly equivalent, but reverse mode requires access to *intermediate* variables, requiring more memory.

# Forward or reverse mode AD?

![ ](./lectures/figs/lec14/autod20.pdf)

# Discussion

- Accuracy is guaranteed and complexity is not worse than that of the original function.
- AD works on iterative solvers, on functions consisting of thousands of lines of code.
- AD is trivially generalized to higher derivatives. Hessians are used in some optimization algorithms. Complexity is quadratic in highest derivative degree.
- The alternative to AD is usually symbolic differentiation, or rather using algorithms not relying on derivatives.
- Divided differences may be just as good as AD in cases where the underlying function is based on discrete or measured quantities, or being the result of stochastic simulations.

# Implementation of AD

Implementation is quite specific to software package.

- [tensorflow](https://www.tensorflow.org) (python, forward/reverse mode, operator overloading)
- [Theano](http://www.deeplearning.net/software/theano/) (python, symbolic transformation, operator overloading)
- [cppad](https://www.coin-or.org/CppAD/) (C++, forward/reverse mode, operator overloading)
- [adapt](http://www.met.reading.ac.uk/clouds/adept/) (C++, forward/reverse mode, operator overloading)

# Applications of AD

- Newton’s method for solving nonlinear equations
- Optimization (utilizing gradients/Hessians)
- Inverse problems/data assimilation
- Neural networks
- Solving stiff ODEs

Recommended literature:

- Andreas Griewank: *Evaluating Derivatives.* SIAM 2000.

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

**Iterate:** On the t’th iteration let our estimates be $$\lambda_t = [\mu_{1}^{(t)}, \mu_{2}^{(t)}, \ldots \mu_{3}^{(t)}]$$

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

- [`sklearn.mixture.GaussianMixture`](http://scikit-learn.org/stable/modules/generated/sklearn.mixture.GaussianMixture.html#sklearn.mixture.GaussianMixture)
- [Python Data Science Handbook: GMMs](https://jakevdp.github.io/PythonDataScienceHandbook/05.12-gaussian-mixtures.html)
