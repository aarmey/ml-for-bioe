---
title: Review questions
layout: page
---

### Lecture 1

1. What are 4 reasons to build a model?
2. $$p(x) = a/x$$ for $$1 < x < 10$$ describes a distribution pdf. What is a? What is the average of this distribution?
3. What are the three kinds of variables? Give an example of each.
4. You are interested in the sample distribution of the mean for an exponential distribution (N=8). What can you say about it relative to the original one?
5. What can you say about the sample distribution for the N=1 case?
6. Studying an anti-tumor compound, you create 2 tumors in either flank (i.e. 1 mouse gets 2 tumors) of 5 mice, then treat the animals with a compound, measuring tumor growth. What is N? Justify your answer.
7. You want to model a process where each successive outcome is 1/3 as likely (i.e. getting 3 is 1/3 as likely as getting 2). What is the expression for this distribution?

### Lecture 2

1. Are ordinary least squares or non-linear least-squares guaranteed to find the solution?
2. How are new points predicted to be distributed in ordinary least squares?
3. How are new points predicted to be distributed in non-linear least squares?
4. How might you determine whether the assumptions you made when running OLS are valid? (Hint: Think about the tests from lecture 1.)
5. What is a situation in which the statistical assumptions of OLS can be valid but calculating a solution fails?
6. You're not sure a function you wrote to calculate the OLS estimator is working correctly. What could you check to ensure you have the right answer? (Hint: Slide 17)
7. You've made a monitor that you know provides a voltage proportional to blood glucose. Design a scheme for a model to convert from voltage to blood glucose, using some set of calibration points. What is the absolute minimum number of calibration points you'd need? How would you expect new calibration points to be distributed?
8. A team member suggests that the voltage-glucose relationship from (7) is log-linear instead of linear, and so suggests using log(V) with OLS instead. When would this be alright? What is an alternative approach?

### Lecture 3

1. What is the bias-variance tradeoff? Why might we want to introduce bias into a model?
2. What is regularization? What are some reasons to use it?
3. What is the difference between ridge regression and LASSO? How should you choose between them?
4. Are you guaranteed to find the global optimal answer for ridge regression? What about LASSO?
5. What is variable selection? Which method(s) perform it? What can you say about the answers?
6. What does it mean when one says ridge regression and LASSO give a family of answers?
7. What can we say about the relationship between fitting error and prediction error?
8. What does regularization do to the degrees of freedom (p) of a model? How about the number of measurements (n)?
9. A colleague tells you about a new form of regularization they've come up with (e.g. maximize the weighting for the variables most correlated with the output). How would this influence the variance of the model? Might this improve the prediction error?
10. What is a smoother matrix? What would a smoother matrix look like for a model that exactly fits the training points?

### Lecture 4

1. What does cross-validation aim to achieve? What does it pretend to do to achieve this?
2. What does bootstrapping aim to achieve? What does it pretend to do to achieve this?
3. Why does cross-validation need to be performed across multiple folds?
4. How will the process of cross-validation influence the model fit error we observe? How does it affect the model prediction error?
5. We want to demonstrate that we can predict the time until failure for an artificial heart from a set of clinical measurements. We plan to utilize LASSO regression to develop this prediction model and are interested in the variables selected by LASSO. Walk through the steps to implement cross-validation here. How can you ensure you select only one set of variables?
6. List **two** ways in which cross-validation and bootstrap are similar.
7. List **two** ways in which cross-validation and bootstrap are different.
8. Why is performing variable selection outside of your cross-validation loop bad, but it’s OK to decide what you are going to measure in the first place?
9. You want to determine whether the first parameter in your ordinary least squares model, $$\beta_1$$, is significantly non-zero. How can you apply bootstrap to accomplish this?
10. Say you build a model with no unknown parameters and therefore no degrees of freedom. Do you need cross-validation to know the prediction error?
11. Is it alright to adjust your model to improve the cross-validation error? Why/why not? If not, what would you need to do to fix the situation?

### Lecture 5

1. What is a prior? How does one go about making one?
2. Can a prior be based on data? If so, how is this data related to the experiment being modeled (the observed)?
3. What are three differences between a Bayesian and maximum likelihood (frequentist) approach?
4. When will a Bayesian and maximum likelihood approach agree?
5. You are asked to provide up-to-date estimates of the 6-month failure rate for a stent going to market. A previous device had 3 devices out of 100 fails within 6 months, and you strongly suspect this device is similar. Provide the Bayesian estimate of the failure rate (i.e. $$P(FR \vert N,m))$$ given N devices have made it to 6 months, and m have failed. (Hint: Devices **either** pass or fail here. This follows a Binomial distribution.)
6. What would be a reasonable estimate if you had no previous device's data?
7. What do you expect to happen to a posterior distribution as you add more and more data?
8. What does the integral of $$p(a \vert b) p(b \vert c) \delta b$$ give you? Why is this useful?

### Lecture 6

1. Who/what sort of people need to test their code?
2. What is the difference between unit tests and integration tests?
3. What does testing guarantee?
4. What is the difference between testing and fuzzing?
5. What is linting?
6. You and a colleague are putting together a model. What are some factors that could influence the results besides the code that you write?
7. You write a function that takes in a voltage from a device and returns the inferred heart rate of the measured individual. What are three high-quality unit tests you could write to test this?

### Lecture 7

1. What do dimensionality reduction methods reduce? What is the tradeoff?
2. What are three benefits of dimensionality reduction?
3. Does matrix factorization have one answer? If not, what are two choices you could make?
4. What does principal components analysis aim to preserve?
5. What are the minimum and maximum number of principal components one can have for a dataset of 300 observations and 10 variables?
6. How can you determine the "right" number of PCs to use?
7. What is a loading matrix? What would be the dimensions of this matrix for the dataset in Q5 when using three PCs?
8. What is a scores matrix? What would be the dimensions of this matrix for the dataset in Q5 when using three PCs?
9. By definition, what is the direction of PC1?
10. [See question 5 on midterm W20](https://aarmey.github.io/BE275/files/midterm-W20.pdf). How does movement of the siControl EGF point represent changes in the original data?

### Lecture 8

1. What are three differences between PCA and PLSR in implementation and application?
2. What is the difference between PCR and PLSR? When does this difference matter more/less?
3. How might you need to prepare your data before using PLSR?
4. How can you determine the right number of components for a model?
5. What feature of biological data makes PLSR/PCR superior to direct regularization approaches (LASSO/ridge)?
6. What benefit does a two component model have over those with 3+ components?
7. Can you apply K-fold cross-validation to a PLSR model? If so, when do you scale your data?
8. Can you apply bootstrapping to a PLSR model? Describe what this would look like.
9. You use the same X data but want to predict a different Y variable. Do your X loadings change in your new model? What about for PCR?

### Lecture 9

1. What is the steady-state solution to an ODE model? How do you solve for them?
2. What is a phase-space diagram?
3. What property of ODE models ensures that solutions can never cross in phase space?
4. What is a Jacobian matrix? How do you calculate it from an ODE model?
5. What are the eigenvalues and eigenvectors of a matrix?
6. What is the behavior of an ODE system if its eigenvalues are all positive and real? How about negative and real?
7. What is the behavior of an ODE system if all its eigenvalues are imaginary and positive? How about imaginary and negative?
8. What does it mean if the eigenvalues of an ODE system give conflicting answers (e.g. one is real and negative, the other is imaginary)?
9. How can you fit an ODE model to a series of measurements over time?
10. How could you constrain an ODE system so that you only fit parameters that have oscillation?

### HMM review

1. What is a Markov assumption? Why is this assumption useful? What type of processes is it helpful for?
2. What makes a hidden Markov model hidden? The hidden part takes what type of values (e.g., continuous, ordinal)?
3. What are the three types of parameters in a hidden Markov model?
4. What are three different types of questions we can ask of a hidden Markov model?
5. What kind of data can be used with a hidden Markov model? How do we link the model to its observations?
6. What is the forward algorithm? What do we need to have before using it? What does it tell us?
7. What is the forward-backward algorithm? What do we need to have before using it? What does it tell us?
8. What is the Baum-Welch algorithm? What do we need to have before using it? What does it tell us?
9. What is the Viterbi algorithm? What do we need to have before using it? What does it tell us?
10. [TMHMM](https://services.healthtech.dtu.dk/service.php?TMHMM-2.0) is a HMM model that can be used to predict the transmembrane regions of proteins (there’s an example input you can use in the guide). Show us the output. Which algorithm is being used for each part of the output graphic?
11. Markov models can be used to model sentences, as certain words tend to come after one another. Does your (or your group member’s) phone use a MM for predictive text? Justify your answer.

### K-Means clustering

1. What is clustering? What does it seek to accomplish?
2. What is agglomerative clustering? What does the resulting output look like?
3. What is the difference between single-link, complete-link, and average clustering?
4. What are three properties that are required of a distance metric? What kind of things can be compared with a distance metric?
5. What decisions does one have to make before performing k-means clustering?
6. Describe the process of fitting that k-means performs.
7. You and your colleague each run k-means with the same settings, and arrive at different results. How could this happen?
8. What are two cases in which k-means clustering can fail or provide bad results?
9. How do you determine that your clustering is "good"?

### SVM review

1. What is the core observation underlying SVMs?
2. Does the answer for an SVM rely on the exact position of all points? If not, which points most influence the model?
3. Where can you find the support vectors in a dataset?
4. What is a kernel? What are three common kinds?
5. Can you use SVMs for data that can’t be perfectly separated? What do you do if so? What additional tradeoff does this create?
6. What is a hyperparameter? How do you find the value of these?
7. How is Y represented within an SVM model?
8. You use an SVM model with an RBF kernel and a high value for gamma. What does the value of gamma indicate?
9. When the C parameter is set to be infinite, which of the following is true?
10. Your colleague is using an SVM with poly kernel and notices that the fitting error improves with ever higher degree polynomials. What is happening here? What would you suggest they do?
11. Can an SVM model be used with more than two classes? If so, how?
