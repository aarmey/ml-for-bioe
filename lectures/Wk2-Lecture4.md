---
title: Week 2, Lecture 4 - Does my model work? Crossvalidation, bootstrap, and friends.
author: Aaron Meyer
---

# Outline

- Administrative Issues
- Model Evaluation
	- Crossvalidation
	- Bootstrap
- Example: Cancer survival gene signatures

# Cross-validation and the bootstrap

- In the section we discuss two *resampling* methods: cross-validation and the bootstrap.
- These methods refit a model with samples from the training set to obtain additional information about the fitted model.
- For example, they provide estimates of test-set prediction error, or the standard deviation and bias of our parameter estimates.

# Training error vs. test error

- Recall the distinction between the *test error* and the *training error*:
	- The *test error* is the average error that results from using a statistical learning method to predict the response on a new observation, one that was not used in training the method.
	- In contrast, the *training error* can be easily calculated by applying the statistical learning method to the observations used in its training.
- The training error rate often is quite different from the test error rate.
- The former can *dramatically underestimate* the latter.

# Training- vs. test-set performance

![ ](./lectures/figs/lec4/sfd-5.pdf)

\note{Walk through this in detail.}

# More on prediction-error estimates

- Best solution: An infinitely large designated test set. Not feasible.
- Some methods make a *mathematical adjustment* to the training error rate to estimate the test error rate. These include the *Cp statistic*, *AIC* and *BIC*.
- Here we instead consider a class of methods that estimate the test error by *holding out* a subset of the training observations from the fitting process, and then applying the statistical learning method to those held out observations

\note[item]{What happens when the first bullet is true?
\item PE = FE
\item $PE = \sigma^2 + Bias^2 + Var$}

# Validation-set approach

- Here we randomly divide the available set of samples into two parts: a *training set* and a *validation* or *hold-out set*.
- The model is fit on the training set, and the fitted model is used to predict the responses for the observations in the validation set.
- The resulting validation-set error provides an **estimate** of the test error. This is typically assessed using MSE in the case of a quantitative response and misclassification rate in the case of a qualitative (discrete) response.

\note{Move to board. Setup example with students up front. Predict height from arm length?}

# The validation process

![ ](./lectures/figs/lec4/sfd-8.pdf)

A random splitting into two halves: left part is training set, right part is validation set

\note{First just leaving one set out.}

# Example: automobile data

- Want to compare linear vs higher-order polynomial terms in a linear regression
- We randomly split the 392 observations into two sets, a training set containing 196 of the data points, and a validation set containing the remaining 196 observations.

![ ](./lectures/figs/lec4/sfd-9.pdf)

*Left panel shows single split; right panel shows multiple splits*

# Drawbacks of validation set approach

- The validation estimate of the test error can be highly variable, depending on precisely which observations are included in each set.
- In the validation approach, only a subset of the observations — those that are included in the training set rather than in the validation set — are used to fit the model.
- This suggests that the validation set error may tend to *overestimate* the test error for the model fit on the entire data set.
	- *Why?*

# K-fold cross-validation

- *Widely* used approach for estimating test error.
- Estimates can be used to select best model, and to give an
idea of the test error of the final chosen model.
- Idea is to randomly divide the data into $K$ equal-sized parts. We leave out part $k$, fit the model to the other $K-1$ parts (combined), and then obtain predictions for the left-out $k$th part.
- This is done in turn for each part $k = 1,2,\ldots K$, and then the results are combined.

# K-fold cross-validation in detail

   **1**            2       3       4       5
---------------- ------- ------- ------- -------
 **Validation**   Train   Train   Train   Train

Table: Divide data into $K$ roughly equal-sized parts ($K = 5$ here)

# The details

- Let the $K$ parts be $C_1,C_2,\ldots C_K$, where $C_k$ denotes the indices of the observations in part $k$. There are $n_k$ observations in part $k$: if $N$ is a multiple of $K$, then $n_k = n/K$.
- Compute:
	- $$CV_{(K)} =  \sum^{K}_{k=1} \frac{n_k}{n} MSE_k$$
	- Where $MSE_k = \sum_{i\in C_k} (y_i - \hat{y}_i)^2/n_k$
	- $\hat{y}_i$ is the prediction for observation $i$ when it was in the removed fold.
- Setting $K = n$ yields *leave-one out cross-validation* (LOOCV).

# Auto data revisited

![ ](./lectures/figs/lec4/sfd-18.pdf)

# True and estimated test MSE for the simulated data

![ ](./lectures/figs/lec4/sfd-19.pdf)

# Other issues with cross-validation

- Since each training set is only $(K - 1)/K$ as big as the original training set, the estimates of prediction error will typically be biased upward. ***Why?***
- This bias is minimized when $K = n_{(LOOCV)}$, but this estimate has high variance, as noted earlier.
- $K = 5--10$ provides a good compromise.

# Cross-validation: right and wrong

- Consider a simple classifier applied to some two-class data:
	1. Starting with 5000 predictors and 50 samples, find the 100 predictors having the largest correlation with the class labels.
	2. We then apply a classifier such as logistic regression, using only these 100 predictors.
- How do we estimate the test set performance of this classifier?
- Can we apply CV in Step 2, forgetting about Step 1?

# NO!

- This would ignore the fact that in Step 1, the procedure *has already seen the labels of the training data*, and made use of them. This is a form of training and must be included in the validation process.
- It is easy to simulate realistic data that is completely randomized, so that it is not possible to make any prediction, but the CV error estimate that ignores Step 1 is zero!
- This error is made in *many* biomedical studies.

# The wrong and right way

- **Wrong:** Apply cross-validation in step 2.
- **Right:** Apply cross-validation to steps 1 and 2.

# The wrong way

![ ](./lectures/figs/lec4/sfd-31.pdf)

# The right way

![ ](./lectures/figs/lec4/sfd-32.pdf)

\note[item]{Go through the hospital example.
\item Cross-validation within/between.}

# The bootstrap

- The *bootstrap* is a flexible and powerful statistical tool that can be used to quantify the uncertainty associated with a given estimator or statistical learning method.
- For example, it can provide an estimate of the standard error of a coefficient, or a confidence interval for that coefficient.

\note{Talk about imagining pulling data out from the data universe.}

# Where does the name come from?

- The use of the term bootstrap derives from the phrase *to pull oneself up by one’s bootstraps*, widely thought to be based on one of the eighteenth century “The Surprising Adventures of Baron Munchausen” by Rudolph Erich Raspe:

The Baron had fallen to the bottom of a deep lake. Just when it looked like all was lost, he thought to pick himself up by his own bootstraps.

- It is not the same as the term “bootstrap” used in computer science meaning to “boot” a computer from a set of core instructions, though the derivation is similar.

# Now back to the real world

- The procedure outlined above cannot be applied, because for real data we cannot generate new samples from the original population.
- However, the bootstrap approach allows us to use a computer to mimic the process of obtaining new data sets.
- Rather than repeatedly obtaining independent data sets from the population, we instead obtain distinct data sets by repeatedly sampling observations from the original data set *with replacement*.
- Each of these “bootstrap data sets” is created by sampling *with replacement*, and is the *same size* as our original dataset. As a result some observations may appear more than once in a given bootstrap data set and some not at all.

# Example with just 3 observations

![ ](./lectures/figs/lec4/sfd-43.pdf)

A graphical illustration of the bootstrap approach on a small sample containing $n = 3$ observations. Each bootstrap data set contains $n$ observations, sampled with replacement from the original data set. Each bootstrap data set is used to obtain an estimate of $\alpha$.

# Example with just 3 observations

- Denoting the first bootstrap data set by $Z^{*1}$, we use $Z^{*1}$ to produce a new bootstrap estimate for $\alpha$, which we call $\hat{\alpha}^{*1}$
- This procedure is repeated $B$ times for some large value of $B$ (say 100 or 1000), in order to produce $B$ different bootstrap data sets, $Z^{*1},Z^{*2},\ldots ,Z^{*B}$, and $B$ corresponding $\alpha$ estimates, $\alpha^{*1},\alpha^{*2},\ldots,\alpha^{*B}$.
- We estimate the standard error of these bootstrap estimates using the formula $$\mathrm{SE}_B (\hat{\alpha}) = \sqrt{\frac{1}{B-1}\sum^{B}_{r=1}\left(\hat{\alpha}^{*r}-\bar{\hat{\alpha}}^{*r}\right)}.$$
- This serves as an estimate of the standard error of $\hat{\alpha}$ estimated from the original data set.

# A general picture for the bootstrap

![ ](./lectures/figs/lec4/sfd-45.pdf)

# The bootstrap in general

- In more complex data situations, figuring out the appropriate way to generate bootstrap samples can require some thought.
- For example, if the data is a time series, we can’t simply sample the observations with replacement (*why not?*).
- We can instead create blocks of consecutive observations, and sample those with replacements. Then we paste together sampled blocks to obtain a bootstrap dataset.

\note{Go over example of color blindness with replacement by gender.}

# Other uses of the bootstrap

- Primarily used to obtain standard errors of an estimate.
- Also provides approximate confidence intervals for a population parameter.
- The above interval is called a *Bootstrap Percentile* confidence interval. It is the simplest method (among many approaches) for obtaining a confidence interval from the bootstrap.

# Can the bootstrap estimate prediction error?

- In cross-validation, each of the $K$ validation folds is distinct from the other $K-1$ folds used for training: *there is no overlap.* This is crucial for its success. *Why?*
- To estimate prediction error using the bootstrap, we could think about using each bootstrap dataset as our training sample, and the original sample as our validation sample.
- But each bootstrap sample has significant overlap with the original data. About two-thirds of the original data points appear in each bootstrap sample. *Can you prove this?*
- This will cause the bootstrap to seriously underestimate the true prediction error. *Why?*
- The other way around—with original sample = training sample, bootstrap dataset = validation sample—is worse!

\note{For example, we can just find exactly matching data points.}

# Removing the overlap

- Can partly fix this problem by only using predictions for those observations that did not (by chance) occur in the current bootstrap sample.
- But the method gets complicated, and in the end, cross-validation provides a simpler, more attractive approach for estimating prediction error.

# The bootstrap vs. permutation tests

- The bootstrap samples from the estimated population, and uses the results to estimate standard errors and confidence intervals.
- Permutation methods sample from an estimated *null* distribution for the data, and use this to estimate p-values and False Discovery Rates for hypothesis tests.
- The bootstrap can be used to test a null hypothesis in simple situations. For example, if $\theta = 0$ is the null hypothesis, we check whether the confidence interval for $\theta$ contains zero.

\note{Go through dataset randomization.}

# Example - gene expression signatures

![ ](./lectures/figs/lec4/example-1.pdf)

# Example - gene expression signatures

![ ](./lectures/figs/lec4/example-2.pdf)

# Example - gene expression signatures

![ ](./lectures/figs/lec4/example-3.pdf)

# Example - gene expression signatures

![**Meta-PCNA adjustment decreases the prognostic abilities of published signatures.** Hazard ratios for overall survival association of 48 signatures in the original dataset (blue) and the meta-analysis (red).](./lectures/figs/lec4/example-4.pdf)

# Example - gene expression signatures

![ ](./lectures/figs/lec4/example-4b.pdf)

# Example - gene expression signatures

![ ](./lectures/figs/lec4/example-5.pdf)

# Implementation - Easiest

## `sklearn.model_selection.cross_val_score`

- `estimator`: estimator object implementing ‘fit’
- `X`: array-like
- `y`: array-like, optional, default: None
- `groups`: array-like, with shape (n_samples,), optional
- `scoring`: string, callable or None, optional, default: None
- `cv`: int, cross-validation generator or an iterable, optional
- `n_jobs`: integer, optional

\note{Go through a notebook here.}

# Implementation - Iterators

- `sklearn.model_selection.KFold(n_splits=3, shuffle=False, random_state=None)`
- `sklearn.model_selection.LeaveOneOut()`

Both use loop `for train_index, test_index in kf.split(X):`.

`get_n_splits` provides number of iterations that will occur.

# Implementation - Bootstrap

```python
for bootstrapi in range(num_bootstraps):
	X_index = range(X.shape[0])
	resamp = resample(X_index, random_state=9889)

	ycurr = y[resamp]
	Xcurr = X[resamp]
	# ...
```

# Summary

- Randomization and hiding things are the key to success!
	- Crossvalidation hides parts of the data at each step, to see how the model can predict it.
	- Bootstrap generates "new" data by resampling, to get a distribution of models.
- With all model evaluation, think about what your model should be "learning", and mess with that.
- Models that always work, or work unexpectedly well, should be suspicious.
