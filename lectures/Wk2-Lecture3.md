---
title: "Week 2, Lecture 3 - Fitting & Regression Redux, Regularization"
author: Aaron Meyer
---

# Outline

- Administrative Issues
- Fitting Regularization
	- Lasso
	- Ridge regression
	- Elastic net
- Some Examples

**Based on slides from Rob Tibshirani.**

# The Bias-Variance Tradeoff

## The Bias-Variance Tradeoff

# Estimating β

- As usual, we assume the model: $$y=f(\mathbf{z})+\epsilon, \epsilon\sim \mathcal{N}(0,\sigma^2)$$
- In regression analysis, our major goal is to come up with some good regression function $$\hat{f}(\mathbf{z}) = \mathbf{z}^\intercal \hat{\beta}$$
- So far, we’ve been dealing with $\hat{\beta}^{ls}$, or the least squares solution:
	- $\hat{\beta}^{ls}$ has well known properties (e.g., Gauss-Markov, ML)
- But can we do better?

# Choosing a good regression function

- Suppose we have an estimator $$\hat{f}(\mathbf{z}) = \mathbf{z}^\intercal \hat{\beta}$$
- To see if this is a good candidate, we can ask ourselves two questions:
	1. Is $\hat{\beta}$ close to the true $\beta$?
	2. Will $\hat{f}(\mathbf{z})$ fit future observations well?
- These might have very different outcomes!!

# Is $\hat{\boldsymbol\beta}$ close to the true β?

- To answer this question, we might consider the **mean squared error** of our estimate $\hat{\boldsymbol\beta}$:
	- i.e., consider squared distance of $\hat{\boldsymbol\beta}$ to the true $\boldsymbol\beta$: $$MSE(\hat{\boldsymbol\beta}) = \mathop{\mathbb{E}}\left[\norm{\hat{\boldsymbol\beta} - \boldsymbol\beta}^2\right] = \mathop{\mathbb{E}}[(\hat{\boldsymbol\beta} - \boldsymbol\beta)^\intercal (\hat{\boldsymbol\beta} - \boldsymbol\beta)]$$
- **Example:** In least squares (LS), we know that: $$\mathop{\mathbb{E}}[(\hat{\boldsymbol\beta}^{ls} - \boldsymbol\beta)^\intercal (\hat{\boldsymbol\beta}^{ls} - \boldsymbol\beta)] = \sigma^2 \mathrm{tr}[(\mathbf{Z}^T \mathbf{Z})^{-1}]$$

# Will $\hat{f}(z)$ fit future observations well?

- Just because $\hat{f}(z)$ fits our data well, this doesn't mean that it will be a good fit to new data
- In fact, suppose that we take new measurements $y_i'$ at the same $\mathbf{z}_i$’s: $$(\mathbf{z}_1,\mathbf{y}_1'),(\mathbf{z}_2,\mathbf{y}_2'),...,(\mathbf{z}_n,\mathbf{y}_n')$$
- So if $\hat{f}(\cdot)$ is a good model, then $\hat{f}(\mathbf{z}_i)$ should also be close to the new target $y_i'$
- This is the notion of **prediction error** (PE)

\note{Have students draw lines for smoking vs. heart attack risk over data. Make two datasets to explain variance.}

# Prediction error and the bias-variance tradeoff

- So good estimators should, on average have, small prediction errors
- Let’s consider the PE at a particular target point $\mathbf{z}_0$:
	- $PE(\mathbf{z}_0) = \sigma_{\epsilon}^2 + Bias^2(\hat{f}(\mathbf{z}_0)) + Var(\hat{f}(\mathbf{z}_0))$
	- Not going to derive, but comes directly from previous definitions
- Such a decomposition is known as the **bias-variance tradeoff**
	- As model becomes more complex (more terms included), local structure/curvature is picked up
	- But coefficient estimates suffer from high variance as more terms are included in the model
- So introducing a little bias in our estimate for **β** might lead to a large decrease in variance, and hence a substantial decrease in PE

# Depicting the bias-variance tradeoff

![A graph depicting the bias-variance tradeoff.](./lectures/figs/lec3/9.pdf)

# Ridge Regression

## Ridge Regression

# Ridge regression as regularization

- If the $\beta_j$'s are unconstrained...
	- They can explode
	- And hence are susceptible to very high variance
- To control variance, we might **regularize** the coefficients
	- i.e., Might control how large the coefficients grow
- Might impose the ridge constraint (both equivalent):
	- minimize $\sum_{i=1}^n (y_i - \boldsymbol\beta^\intercal \mathbf{z}_i)^2\: \mathrm{s.t.} \sum_{j=1}^p \beta_j^2 \leq t$
	- minimize $(y - \mathbf{Z}\boldsymbol\beta)^\intercal (y - \mathbf{Z}\boldsymbol\beta)\: \mathrm{s.t.} \sum_{j=1}^p \beta_j^2 \leq t$
- By convention (very important!):
	- **Z** is assumed to be standardized (mean 0, unit variance)
	- **y** is assumed to be centered

# Ridge regression: $l_2$-penalty

- Can write the ridge constraint as the following **penalized** residual sum of squares (PRSS):

![ ](./lectures/figs/lec3/12.pdf)

- Its solution may have smaller average PE than $\hat{\boldsymbol\beta}^{ls}$
- $PRSS(\boldsymbol\beta)_{l_2}$ is convex, and hence has a unique solution
- Taking derivatives, we obtain: $$\frac{\delta PRSS(\beta)_{l_2}}{\delta \beta} = -2\mathbf{Z}^T (y-\mathbf{Z}\beta)+2\lambda\beta$$

# The ridge solutions

- The solution to $PRSS(\hat{\beta})_{l2}$ is now seen to be: $$\hat{\beta}_\lambda^{ridge} = (\mathbf{Z}^\intercal \mathbf{Z} + \lambda \mathbf{I}_p)^{-1} \mathbf{Z}^\intercal \mathbf{y}$$
	- Remember that **Z** is standardized
	- **y** is centered
- Solution is indexed by the tuning parameter λ (more on this later)
- Inclusion of λ makes problem non-singular even if $\mathbf{Z}^\intercal \mathbf{Z}$ is not invertible
	- This was the original motivation for ridge regression (Hoerl and Kennard, 1970)

# Tuning parameter λ

- Notice that the solution is indexed by the parameter λ
	- So for each λ, we have a solution
	- Hence, the λ’s trace out a path of solutions (see next page)
- λ is the shrinkage parameter
	- λ controls the size of the coefficients
	- λ controls amount of **regularization**
	- As λ decreases, we obtain the least squares solutions
	- As λ increases, we have $\hat{\beta}_{\lambda=0}^{ridge} = 0$ (intercept-only model)

# Ridge coefficient paths

- The λ’s trace out a set of ridge solutions, as illustrated below

![Ridge coefficient path for the diabetes data set found in the `lars` library in R.](./lectures/figs/lec3/15.pdf)

# Choosing λ

- Need disciplined way of selecting λ
- That is, we need to "tune" the value of λ
- In their original paper, Hoerl and Kennard introduced **ridge traces**:
	- Plot the components of $\hat{\beta}_\lambda^{ridge}$ against λ
	- Choose λ for which the coefficients are not rapidly changing and have "sensible" signs
	- No objective basis; heavily criticized by many
- Standard practice now is to use cross-validation (next lecture!)

# A few notes on ridge regression

- The regularization decreases the degrees of freedom of the model
	- So you still cannot fit a model with more degrees of freedom than points
- This can be shown by examination of the smoother matrix
	- We won't do this—it's a complicated argument

# How do we choose λ?

- We need a disciplined way of choosing λ
- Obviously want to choose λ that minimizes the mean squared error
- Issue is part of the bigger problem of **model selection**

# K-Fold Cross-Validation

- A common method to determine $\lambda$ is K-fold cross-validation.
- **We will discuss this next lecture.**

# Plot of CV errors and standard error bands

![Cross validation errors from a ridge regression example on spam data.](./lectures/figs/lec3/34.pdf)

# The LASSO

**The LASSO**

# The LASSO: $l_1$ penalty

- Tibshirani (*J of the Royal Stat Soc* 1996) introduced the **LASSO**: *least absolute shrinkage and selection operator*
- LASSO coefficients are the solutions to the $l_1$ optimization problem: $$\mathrm{minimize}\: (\mathbf{y}-\mathbf{Z}\boldsymbol\beta)^T (\mathbf{y}-\mathbf{Z}\boldsymbol\beta)\: \mathrm{s.t.} \sum_{j=1}^p \norm{\beta_j} \leq t$$
- This is equivalent to loss function: $$PRSS(\boldsymbol\beta)_{l_1} = \sum_{i=1}^n (y_i - \mathbf{z}_i^T \boldsymbol\beta)^2 + \lambda \sum_{j=1}^p \norm{\beta_j}$$ $$\quad = (\mathbf{y}-\mathbf{Z}\boldsymbol\beta)^T (\mathbf{y}-\mathbf{Z}\boldsymbol\beta) + \lambda\norm{\boldsymbol\beta}_1$$

# λ (or t) as a tuning parameter

- Again, we have a tuning parameter λ that controls the amount of regularization
- One-to-one correspondence with the threshhold t:
	- recall the constraint: $$\sum_{j=1}^p = \norm{\beta_j} \leq t$$
	- Hence, have a "path" of solutions indexed by $t$
	- If $t_0 = \sum_{j=1}^p \norm{\hat{\beta}_j^{ls}}$ (equivalently, λ = 0), we obtain no shrinkage (and hence obtain the LS solutions as our solution)
	- Often, the path of solutions is indexed by a fraction of shrinkage factor of $t_0$

# Sparsity and exact zeros

- Often, we believe that many of the $\beta_j$’s should be 0
- Hence, we seek a set of **sparse solutions**
- Large enough $\lambda$ (or small enough t) will set some coefficients exactly equal to 0!
	- So LASSO will perform model selection for us!

# Computing the LASSO solution

- Unlike ridge regression, $\hat{\beta}^{lasso}_{\lambda}$ has no closed form $\lambda$
- Original implementation involves quadratic programming techniques from convex optimization
- But Efron _et al_, _Ann Statist_, 2004 proposed LARS (least angle regression), which computes the LASSO path efficiently
	- Interesting modification called is called forward stagewise
	- In many cases it is the same as the LASSO solution
	- Forward stagewise is easy to implement: <https://www-stat.stanford.edu/~hastie/TALKS/nips2005.pdf>

# Forward stagewise algorithm

- As usual, assume **Z** is standardized and **y** is centered
- Choose a small $\epsilon$. The forward-stagewise algorithm then proceeds as follows:
	1. Start with initial residual $\mathbf{r}=\mathbf{y}$, and $\beta_1=\beta_2=\ldots=\beta_p=0$
	2. Find the predictor $\mathbf{Z}_j (j=1,\ldots,p)$ most correlated with **r**
	3. Update $\beta_j=\beta_j+\delta_j$, where $\delta_j = \epsilon\cdot \mathrm{sign} \langle\mathbf{r},\mathbf{Z}_j\rangle = \epsilon\cdot \mathrm{sign}(\mathbf{Z}^T_j \mathbf{r})$
	4. Set $\mathbf{r}=\mathbf{r} - \delta_j \mathbf{Z}_j$
	5. Repeat from step 2 many times

# The LASSO, LARS, and Forward Stagewise paths

![Comparison of the LASSO, LARS, and Forward Stagewise coefficient paths for the diabetes data set.](./lectures/figs/lec3/45.pdf)

# Comparing LS, Ridge, and the LASSO

- Even though $\mathbf{Z}^{T}\mathbf{Z}$ may not be of full rank, both ridge regression and the LASSO admit solutions
- We have a problem when $p \gg n$ (more predictor variables than observations)
	- But both ridge regression and the LASSO have solutions
	- Regularization tends to reduce prediction error

<!-- 48 -->

# More comments on variable selection

- Now suppose $p \gg n$
- Of course, we would like a parsimonious model (Occam’s Razor)
- Ridge regression produces coefficient values for each of the p-variables
- But because of its $l_1$ penalty, the LASSO will set many of the variables exactly equal to 0!
	- That is, the LASSO produces **sparse solutions**
- So LASSO takes care of model selection for us
	- And we can even see when variables jump into the model by looking at the LASSO path

# Variants

- Zou and Hastie (2005) propose the **elastic net**, which is a convex combination of ridge and the LASSO
	- Paper asserts that the elastic net can improve error over LASSO
	- Still produces sparse solutions

<!-- 50 -->

# High-dimensional data and underdetermined systems

- In many modern data analysis problems, we have $p \gg n$
	- These comprise “high-dimensional” problems
- When fitting the model $y = \mathbf{z}^\intercal \beta$, we can have many solutions
	- i.e., our system is *underdetermined*
- Reasonable to suppose that most of the coefficients are exactly equal to 0

<!-- 51 -->

# But do these methods pick the right/true variables?

- Suppose that only $S$ elements of $\beta$ are non-zero
- Now suppose we had an "Oracle" that told us which components of the $\beta = (\beta_1,\beta_2,\ldots,\beta_p)$ are truly non-zero
- Let $\beta^{*}$ be the least squares estimate of this "ideal" estimator:
	- So $\beta^{*}$ is 0 in every component that $\beta$ is 0
	- The non-zero elements of $\beta^{*}$ are computed by regressing $\mathbf{y}$ on only the $S$ important covariates
- It turns out we get *really* close to this cheating solution without cheating!
	- Candes & Tao. _Ann Statist_. 2007.

# Example - Predicting Drug Response

![ ](./lectures/figs/lec3/ccle-title.pdf)

# Example - Predicting Drug Response

![ ](./lectures/figs/lec3/ccle-fig2.pdf)

# Example - Predicting Drug Response

![ ](./lectures/figs/lec3/ccle-fig3.pdf)

# Example - Predicting Drug Response

![ ](./lectures/figs/lec3/ccle-fig4.pdf)

# Implementation

- The notebook can be found on the course website.

# Further Reading

- [Computer Age Statistical Inference, Chapter 16](https://web.stanford.edu/~hastie/CASI_files/PDF/casi.pdf)
- sklearn: [Generalized Linear Models](https://scikit-learn.org/stable/modules/linear_model.html)
- Candès E. and Tao T. [The Dantzig selector: statistical estimation when p is much larger than n](https://www.acm.caltech.edu/~emmanuel/papers/DantzigSelector.pdf).
