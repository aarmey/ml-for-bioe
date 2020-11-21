---
title: Review questions
layout: page
---

### Lecture 1

1. What are 4 reasons to build a model?
2. $p(x) = a/x$ for $1 < x < 10$ describes a distribution pdf. What is a? What is the average of this distribution?
3. What are the three kinds of variables? Give an example of each.
4. You are interested in the sample distribution of the mean for an exponential distribution (N=8). What can you say about it relative to the original one?
5. What can you say about the sample distribution for the N=1 case?
6. Studying an anti-tumor compound, you create 2 tumors in either flank (i.e. 1 mouse gets 2 tumors) of 5 mice, then treat the animals with compound measuring tumor growth. What is N? Justify your answer.
7. You want to model a process where each successive outcome is 1/3 as likely (i.e. getting 3 is 1/3 as likely as getting 2). What is the expression for this distribution?

### Lecture 2

1. Are ordinary least squares or non-linear least squares guaranteed to find the solution?
2. How are new points predicted to be distributed in ordinary least squares?
3. How are new points predicted to be distributed in non-linear least squares?
4. How might you determine whether the assumptions you made when running OLS are valid? (Hint: think about the tests from lec 1)
5. What is a situation in which the assumptions of OLS can be valid but calculating a solution fails?
6. You're not sure a function you wrote to calculate the OLS estimator is working correctly. What could you check to ensure you have the right answer? (Hint: Lecture 2, slide 17)
7. You've made a monitor that you know provides a voltage proportional to blood glucose. Design a scheme for a model to convert from voltage to blood glucose, using some set of calibration points. What is the absolute minimum number of calibration points you'd need? How would you expect new calibration points to be distributed?

### Lecture 3

What is the bias-variance tradeoff? Why might we want to introduce bias into a model?
What is regularization? What are some reasons to use it?
What is the difference between ridge regression and LASSO? How should you choose between them?
Are you guaranteed to find the global optimal answer for ridge regression? What about LASSO?
What is variable selection? Which method(s) perform it? What can you say about the answers?
What does it mean when one says ridge regression and LASSO give a family of answers?
What can we say about the relationship between fitting error and prediction error?
What does regularization do to the degrees of freedom (p) of a model? How about the number of measurements (n)?
A colleague tells you about a new form of regularization they've come up with (e.g. maximize the weighting for the variables most correlated with the output). How would this influence the variance of the model? Might this improve the prediction error?

Review questions from lecture 5

Why does cross-validation need to be performed across multiple folds?
How will the process of cross-validation influence the model fit error we observe? How does it affect the model prediction error?
We want to demonstrate that we can predict the time until failure for an artificial heart from a set of clinical measurements. We plan to utilize LASSO regression to develop this prediction model, and are interested in the variables selected by LASSO. Walk through the steps to implement cross-validation here. How can you ensure you select only one set of variables?
List [two] ways in which cross-validation and bootstrap are similar.
List [two] ways in which cross-validation and bootstrap are different.
Why is performing variable selection outside of your cross-validation loop bad, but it’s OK to decide what you are going to measure in the first place?
You want to determine whether the first parameter in your ordinary least squares model, beta_1, is significantly non-zero. How can you apply bootstrap to accomplish this?

Review questions lecture 6

What is a prior? How does one go about making one?
Can a prior be based on data? If so, how is this data related to the experiment being modeled (the observed)?
What are three differences between a Bayesian and maximum likelihood (frequentist) approach?
When will a Bayesian and maximum likelihood approach agree?
You are asked to provide up-to-date estimates of the 6 month failure rate for a stent going to market. A previous device had 3 devices out of 100 fail within 6 months, and you strongly suspect this device is similar. Provide the Bayesian estimate of the failure rate (i.e. `P(FR | N,m))` given N devices have made it to 6 months, and m have failed. (Hint: Devices EITHER pass or fail here. This follows a Binomial distribution.)
What would be a reasonable estimate if you had no previous device's data?
What do you expect to happen to a posterior distribution as you add more and more data?

Review questions lecture 7

Who/what sort of people need to test their code?
What is the difference between unit tests and integration tests?
What does testing guarantee?
What is the difference between testing and fuzzing?
What is linting?
You and a colleague are putting together a model. What are some factors that could influence the results besides the code that you write?

Review questions lecture 8

What do dimensionality reduction methods reduce? What is the tradeoff?
What are three benefits of dimensionality reduction?
Does matrix factorization have one answer? If not, what are two choices you could make?
What does principal components analysis aim to preserve?
What are the minimum and maximum number of principal components one can have for a dataset of 300 observations and 10 variables?
How can you determine the "right" number of PCs to use?
What is a loading matrix? What would be the dimensions of this matrix for the dataset in Q5 when using three PCs?
What is a scores matrix? What would be the dimensions of this matrix for the dataset in Q5 when using three PCs?
By definition, what is the direction of PC1?
See board. How does movement of the indicated point represent changes in the original data?

Review questions lecture 9

What are three differences between PCA and PLSR in implementation and application?
What is the difference between PCR and PLSR? When does this different matter more/less?
How might you need to prepare your data before using PLSR?
How can you determine the right number of components for a model?
What feature of biological data make PLSR/PCR superior to direct regularization approaches (LASSO/ridge)?
What benefit does a two component model have over those with 3+ components?
Can you apply K-fold cross-validation to a PLSR model? If so, when do you scale your data?
Can you apply bootstrapping to a PLSR model? Describe what this would look like.
You use the same X data but want to predict a different Y variable. Do your X loadings change in your new model?
