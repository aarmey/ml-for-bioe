---
title: Week 4, Lecture 8 - Partial Least Squares Regression
author: Aaron Meyer
---

# Outline

- Administrative Issues
- Principal Components Regression
- Partial Least Squares Regression
- Some Examples
- Implementation

\note[item]{Explain unsupervised/supervised.
\item Can you bootstrap a PLSR/PCR/PCA model?
}

**Adapted from slides by Pam Kreeger.**

# Common Challenge: Cue/Signal/Response Relationships

![ ](./lectures/figs/lec8/CSR-figure.pdf)

\note[item]{Number of components enough to make PCA/lasso useful
\item But how do we deal with components moving together?
\item And what we care about is some outcome
}

# Many Methods for Relating a Signal to Response

Say we have some measurement from cells and how they respond:

$$ [1, 2, 1.5, 5, 6, 7] \sim [5, 10, 7, 24, 31, 35] $$

From the variation we can see that:

- Low signal is correlated with low response
- High signal is correlated with high response

If we can find a quantitative correlation between the input and output, we can predict new outcomes for measurements we haven't yet seen.

\note{Draw out correlation and then include new point.}

# Challenges with Univariate Relationships

![Janes, et al. Science, 2005](./lectures/figs/lec8/Janes-fig.jpg)

- The relationship between JNK activation and apoptosis appears to be highly context-dependent
	- Univariate relationships are often insufficient
	- Cells respond to an environment with multiple factors present

# Notes about Methods Today

- Both methods are supervised learning methods, however have a number of distinct properties from others we will discuss.
- Learning about PLS is more difficult than it should be, partly because papers describing it span areas of chemistry, economics, medicine and statistics, with little agreement on terminology and notation.
- These methods will show one example of where the model and algorithm are quite distinct—there are multiple algorithms for calculating a PLSR model.

# Multi-Linear Regression (MLR)

In biology we often have multiple signals and multiple responses that were measured:
$$ y_1 =a_1x_1 + b_1x_2 + e_1 $$
$$ y_2 =a_2x_1 + b_2x_2 + e_2 $$

This can be written more concisely in matrix notation as:
$$ Y = XB + E $$

Where Y is a $n \times p$ matrix and X is a $n \times m$ matrix; minimizing E and solving for B:
$$ B = (X^tX)^{-1}X^tY $$

# Underdetermined Systems

If $n$ observations and $m$ variables:

- $m<n$: no exact solution, least-squares solution possible
- $m=n$: one solution
- $m>n$: no unique solution unless we delete independent variables since $X^tX$ cannot be inverted
	- **$m>n$ is often the case in systems biology!**

If a model is underdetermined with multiple solutions, there are two general approches we can take:

- Regularization: We can use other information we know to focus on one answer
- Sampling: We can look at all possible models

# Regularization

Today we will use regularization.

- We will assume the larger variation in the data is more meaningful.
- Therefore, we will assume that smaller changes are less important.
- This is a choice that must be correct for the relevant biological question at hand.

# Principal Components Regression (PCR)

One solution - use the concepts from PCA to reduce dimensionality.

First step: **Simply apply PCA!**

![Geladi *Analytica Chimica Acta* 1986](./lectures/figs/lec8/PCR2.png){width=60%}

Dimensionality goes from $m$ to $N_{comp}$.

\note[item]{What are the bounds on the number of components we can have?
\item What might be a concern as a consequence of this? (How do we determine how many components to keep?)}

# Principal Components Regression (PCR)

1)  Decompose X matrix (scores T, loadings P, residuals E)
$$X = TPt + E$$

2) Regress Y against the scores (Scores describe observations – by using them we link X and Y for each observation)

$$Y = TB + E$$

\note[item]{What is the residual against here?
\item How do we invert the direction of the regression? }

# Challenge

**How might we determine the number of components using our prediction?**

\note[item]{Cross-validation with varying numbers of components
\item Metrics like AIC or BIC}

# Potential Problem

- PCs for the X matrix do not necessarily capture X-variation that is important for Y
	- So later PCs are going to be more important to regression
- Example: the first components capture signaling that is related to another cell fate, while the signals that co-vary for this particular y are buried in later components

**How might we handle this differently?**

# PLSR

![ ](./lectures/figs/lec8/PC-5.pdf)

\note[item]{Go over definition of covariance.
\item cov(X, X) = var(X)
\item var(Y) = cov(X, Y) + variance in Y independent of X
\item A factorization occurs to find max covar with Y
\item Forces direction of components}

# PLSR - NIPALs with Scores Exchanged

![ ](./lectures/figs/lec8/PC-6.pdf)

\note[item]{$B$ is $T (P^T T)^{-1} Q^T
\item $P^T T$ is the approximation of $X$
\item PLSR components are not orthogonal in data space, but are orthogonal in O-PLS.}

# PLSR - NIPALs with Scores Exchanged

![ ](./lectures/figs/lec8/PC-7.pdf)

# Components in PLSR and PCA Differ

![ ](./lectures/figs/lec8/PC-8.pdf)

# Determining the Number of Components

![ ](./lectures/figs/lec8/PC-9.pdf)

\note{Go over each.}

# Determining the Number of Components

![ ](./lectures/figs/lec8/PC-10.pdf)

# Variants of PLSR

#### Discriminant PLSR

#### Tensor PLSR

# Application

![ ](./lectures/figs/lec8/lee-1.pdf)

# Application

![ ](./lectures/figs/lec8/lee-2.pdf)

# Application

![ ](./lectures/figs/lec8/lee-3.pdf)

# Application

![ ](./lectures/figs/lec8/lee-4.pdf)

# Application

![ ](./lectures/figs/lec8/lee-5.pdf)

# Application

![ ](./lectures/figs/lec8/lee-6.pdf)

# Application

![ ](./lectures/figs/lec8/lee-7.pdf)

# Practical Notes

## PCR

- sklearn does not implement PCR directly
- Can be applied by chaining `sklearn.decomposition.PCA` and `sklearn.linear_model.LinearRegression`
- See: <http://scikit-learn.org/stable/auto_examples/plot_digits_pipe.html>

## PLSR

- `sklearn.cross_decomposition.PLSRegression`
	- Uses `M.fit(X, Y)` to train
	- Can use `M.predict(X)` to get new predictions
	- `PLSRegression(n_components=3)` to set number of components on setup
	- Or `M.n_components = 3` after setup

<http://scikit-learn.org/stable/modules/generated/sklearn.cross_decomposition.PLSRegression.html>

# Summary

## PLSR

- Maximizes the covariance
- Takes into account both the dependent (Y) and independent (X) data

## PCR

- Uses PCA as initial decomp. step, then is just normal linear regression
- Maximizes the variance explained of the independent (X) data

# Summary

## Interpreting PLSR

- $R^2X$, $R^2Y$, $Q^2Y$ (maximum value of 1)
- Using Q2Y to determine number of components Scores/loadings
- DModY (lower = better predicton)
- VIP (>1 indicates important)
- **Ultimately, these metrics are seconary to whether a model works upon crossvalidation**

# Summary

- PLSR is amazingly well at prediction
	- This is **incredibly** powerful
- Interpreting **WHY** PLSR predicts something can be very challenging
