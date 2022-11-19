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
- **Example:** In least squares (LS), we now that: $$\mathop{\mathbb{E}}[(\hat{\boldsymbol\beta}^{ls} - \boldsymbol\beta)^\intercal (\hat{\boldsymbol\beta}^{ls} - \boldsymbol\beta)] = \sigma^2 \mathrm{tr}[(\mathbf{Z}^T \mathbf{Z})^{-1}]$$

# Will $\hat{f}(z)$ fit future observations well?

- Just because $\hat{f}(z)$ fits our data well, this doesn't mean that it will be a good fit to new data
- In fact, suppose that we take new measurements $y_i'$ at the same $\mathbf{z}_i$’s: $$(\mathbf{z}_1,\mathbf{y}_1'),(\mathbf{z}_2,\mathbf{y}_2'),...,(\mathbf{z}_n,\mathbf{y}_n')$$
- So if $\hat{f}(\cdot)$ is a good model, then $\hat{f}(\mathbf{z}_i)$ should also be close to the new target $y_i'$
- This is the notion of **prediction error** (PE)

# Prediction error and the bias-variance tradeoff

- So good estimators should, on average have, small prediction errors
- Let’s consider the PE at a particular target point $\mathbf{z}_0$:
	- $PE(\mathbf{z}_0) = \sigma_{\epsilon}^2 + Bias^2(\hat{f}(\mathbf{z}_0)) + Var(\hat{f}(\mathbf{z}_0))$
	- Not going to derive, but comes directly from previous definitions
- Such a decomposition is known as the **bias-variance tradeoff**
	- As model becomes more complex (more terms included), local structure/curvature can be picked up
	- But coefficient estimates suffer from high variance as more terms are included in the model
- So introducing a little bias in our estimate for **β** might lead to a substantial decrease in variance, and hence to a substantial decrease in PE

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

<!--# Bayesian framework

- Suppose we imposed a multivariate Gaussian prior for β: $$\boldsymbol\beta \sim N \left( \mathbf{0}, \frac{1}{2p} \mathbf{I}_p \right)$$
- Then the posterior mean (and also posterior mode) of β is: $$\boldsymbol\beta_\lambda^{ridge} = (\mathbf{Z}^T \mathbf{Z} + \lambda \mathbf{I}_p)^{-1} \mathbf{Z}^T \mathbf{y}$$

# Computing the ridge solutions via the SVD

- Recall $\hat{\boldsymbol\beta}_\lambda^{ridge} = (\mathbf{Z}^T \mathbf{Z} + \lambda \mathbf{I}_p)^{-1} \mathbf{Z}^T \mathbf{y}$
- When computing $\hat{\boldsymbol\beta}_\lambda^{ridge}$ numerically, matrix inversion is avoided:
	- Inverting $\mathbf{Z}^T \mathbf{Z}$ can be computationally expensive: $O(p^3)$
- Rather, the *singular value decomposition* is utilized; that is, $$\mathbf{Z} = \mathbf{UDV}^T,$$ where:
	- $\mathbf{U} = (\mathbf{u}_1,\mathbf{u}_2,\ldots,\mathbf{u}_p)$ is an $n\times p$ orthogonal matrix
	- $\mathbf{D} = \mathrm{diag}(d_1,d_2,\ldots, \geq d_p)$ is a $p\times p$ diagonal matrix consisting of the singular values $d_1 \geq d_2 \geq \ldots d_p \geq 0$
	- $\mathbf{V}^T =(\mathbf{v}_1^T,\mathbf{v}_2^T,\ldots,\mathbf{v}_p^T)$ is a $p\times p$ matrix orthogonal matrix-->

# Orthonormal **Z** in ridge regression

- If **Z** is orthonormal, then $\mathbf{Z}^T \mathbf{Z}=\mathbf{I}_p$, then a couple of closed form properties exist
- Let $\hat{\boldsymbol\beta}^{ls}$ denote the LS solution for our orthonormal **Z**; then $$\hat{\boldsymbol\beta}_\lambda^{ridge} = \frac{1}{1 + \lambda} \hat{\boldsymbol\beta}^{ls}$$
- The optimal choice of λ minimizing the expected prediction error is: $$\lambda^{*} = \frac{p\sigma^2}{\sum_{j=1}{p} \beta_j^2},$$ where $\boldsymbol\beta = (\beta_1,\beta_2,\ldots,\beta_p)$ is the true coefficient vector

# Smoother matrices and effective degrees of freedom

- A **smoother matrix S** is a linear operator satisfying: $$\mathbf{\hat{y}} = \mathbf{Sy}$$
	- Smoothers put the "hats" on **y**
	- So the fits are a linear combination of the $y_i$'s, $i = 1, \ldots, n$
- **Example:** In ordinary least squares, recall the hat matrix $$\mathbf{H} = \mathbf{Z}(\mathbf{Z}^T \mathbf{Z})^{-1}\mathbf{Z}^T$$
	- For rank(**Z**) = p, we know that tr(**Z**) = p, which is how many degrees of freedom are used in the model
- By analogy, define the **effective degrees of freedom** (or effective number of parameters) for a smoother to be: $$df(\mathbf{S}) = tr(\mathbf{S})$$

# Degrees of freedom for ridge regression

- In ridge regression, the fits are given by: $$\hat{\mathbf{y}} = \mathbf{Z}(\mathbf{Z}^\intercal \mathbf{Z}+\lambda \mathbf{I}_p)^{-1} \mathbf{Z}^T\mathbf{y}$$
- So the smoother or "hat" matrix in ridge takes the form: $$\mathbf{S}_\lambda = \mathbf{Z} (\mathbf{Z}^\intercal \mathbf{Z} + \lambda \mathbf{I}_p)^{-1} \mathbf{Z}^T$$
- So the effective degrees of freedom in ridge regression are given by: $$df(\lambda) =tr(S_\lambda) = tr[\mathbf{Z}(\mathbf{Z}^\intercal \mathbf{Z}+\lambda \mathbf{I}_p)^{-1}\mathbf{Z}^T] = \sum_{j=1}^p \frac{d_j^2}{d_j^2 + \lambda}$$
	- Note that $df(\lambda)$ is monotone decreasing in $\lambda$
	- Question: What happens when $\lambda = 0$?

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
	- So the LASSO will perform model selection for us!

# Computing the LASSO solution

- Unlike ridge regression, $\hat{\beta}^{lasso}_{\lambda}$ has no closed form $\lambda$
- Original implementation involves quadratic programming techniques from convex optimization
- But Efron et al. (Annals of Statistics 2004) proposed LARS (least angle regression), which computes the LASSO path efficiently
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

<!--# Variable selection

- The ridge and LASSO solutions are indexed by the continuous parameter λ:
- Variable selection in least squares is “discrete”:
	- Perhaps consider “best” subsets, which is of order O(2p) (combinatorial explosion – compare to ridge and LASSO)
	- Stepwise selection
		- In stepwise procedures, a new variable may be added into the model even with a miniscule improvement in R2
		- When applying stepwise to a perturbation of the data, probably have different set of variables enter into the model at each stage
- Many model selection techniques based on Mallow’s Cp, AIC, and BIC-->

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

# S-sparsity and Oracles

- Suppose that only $S$ elements of $\beta$ are non-zero
	- Candès and Tao call this $S$-sparsity
- Now suppose we had an "Oracle" that told us which components of the $\beta = (\beta_1,\beta_2,\ldots,\beta_p)$ are truly non-zero
- Let $\beta^{*}$ be the least squares estimate of this "ideal" estimator:
	- So $\beta^{*}$ is 0 in every component that $\beta$ is 0
	- The non-zero elements of $\beta^{*}$ are computed by regressing $\mathbf{y}$ on only the $S$ important covariates

# The Danzig Selector

- Candès and Tao developed the Dantzig selector $\hat{\beta}^{Dantzig}$: $$\min \norm{\beta}_{l_1} \mathrm{s.t.} \norm{\mathbf{Z}_j^\intercal \mathbf{r}}_{l_{\infty}} \leq (1 + t^{-1})\sqrt{2 \log p} \cdot \sigma$$
	- Here, $\mathbf{r}$ is the residual vector and $t>0$ is a scalar
- They showed that with high probability, $$\norm{\hat{\beta}^{Dantzig} - \beta}^2 = O(\log p) \mathop{\mathbb{E}}(\norm{\beta^{*} - \beta}^2)$$
- So the Dantzig selector does comparably well as someone who was told which $S$ variables to regress on

# Example - Predicting Drug Response

![ ](./lectures/figs/lec3/ccle-title.pdf)

# Example - Predicting Drug Response

![ ](./lectures/figs/lec3/ccle-fig2.pdf)

# Example - Predicting Drug Response

![ ](./lectures/figs/lec3/ccle-fig3.pdf)

# Example - Predicting Drug Response

![ ](./lectures/figs/lec3/ccle-fig4.pdf)

# Implementation

```python
import numpy as np, matplotlib.pyplot as plt
from sklearn.metrics import r2_score
from sklearn.linear_model import Lasso, ElasticNet

# Generate some sparse data to play with
n_samples, n_features = 50, 200
X = np.random.randn(n_samples, n_features)
coef = 3 * np.random.randn(n_features)
inds = np.arange(n_features)
np.random.shuffle(inds)
coef[inds[10:]] = 0  # sparsify coef
y = np.dot(X, coef)

# add noise
y += 0.01 * np.random.normal(size=n_samples)

# Split data in train set and test set
n_samples = X.shape[0]
X_train, y_train = X[:n_samples // 2], y[:n_samples // 2]
X_test, y_test = X[n_samples // 2:], y[n_samples // 2:]
#...
```

# Implementation

```python
#...
# Split data in train set and test set
n_samples = X.shape[0]
X_train, y_train = X[:n_samples // 2], y[:n_samples // 2]
X_test, y_test = X[n_samples // 2:], y[n_samples // 2:]

# Lasso
alpha = 0.1
lasso = Lasso(alpha=alpha)

y_pred_lasso = lasso.fit(X_train, y_train).predict(X_test)
r2_score_lasso = r2_score(y_test, y_pred_lasso)

# ElasticNet
enet = ElasticNet(alpha=alpha, l1_ratio=0.7)

y_pred_enet = enet.fit(X_train, y_train).predict(X_test)
r2_score_enet = r2_score(y_test, y_pred_enet)
#...
```

# Implementation

```python
#...
# ElasticNet
enet = ElasticNet(alpha=alpha, l1_ratio=0.7)

y_pred_enet = enet.fit(X_train, y_train).predict(X_test)
r2_score_enet = r2_score(y_test, y_pred_enet)

plt.plot(enet.coef_, color='lightgreen', linewidth=2,
         label='Elastic net coefficients')
plt.plot(lasso.coef_, color='gold', linewidth=2,
         label='Lasso coefficients')
plt.plot(coef, '--', color='navy', label='original coefficients')
plt.legend(loc='best')
plt.title("Lasso R^2: %f, Elastic Net R^2: %f"
          % (r2_score_lasso, r2_score_enet))
plt.show()
```

# Implementation

![ ](./lectures/figs/lec3/sklearn.png){width=70%}

# Further Reading

- [Computer Age Statistical Inference, Chapter 16](https://web.stanford.edu/~hastie/CASI_files/PDF/casi.pdf)
- sklearn: [Generalized Linear Models](https://scikit-learn.org/stable/modules/linear_model.html)
- Candès E. and Tao T. [The Dantzig selector: statistical estimation when p is much larger than n](https://www.acm.caltech.edu/~emmanuel/papers/DantzigSelector.pdf).
