---
title: "Week 4, Lecture 7 - Dimensionality Reduction: PCA and NMF"
author: Aaron Meyer
---

# Outline

- Administrative Issues
- Decomposition methods
	- Factor analysis
	- Principal components analysis
	- Non-negative matrix factorization

# Dealing with many variables

- So far we've largely concentrated on cases in which we have relatively large numbers of measurements for a few variables
	- This is frequently refered to as $n > p$
- Two other extremes are imporant
	- Many observations and many variables
	- Many variables but few observations ($p > n$)

# Dealing with many variables

## Usually when we're dealing with many variables, we don't have a great understanding of how they relate to each other

- E.g. if gene X is high, we can't be sure that will mean gene Y will be too
- If we had these relationships, we could reduce the data
	- E.g. if we had variables to tell us it's 3 pm in Los Angeles, we don't need one to say it's daytime

# Dimensionality Reduction

## Generate a low-dimensional encoding of a high-dimensional space

Purposes:

- Data compression / visualization
- Robustness to noise and uncertainty
- Potentially easier to interpret

Bonus: Many of the other methods from the class can be applied after dimensionality reduction with little or no adjustment!

# Matrix Factorization

Many (most?) dimensionality reduction methods involve matrix factorization

Basic Idea: Find two (or more) matrices whose product best approximate the original matrix

Low rank approximation to original $N\times M$ matrix:

$$ \mathbf{X} \approx \mathbf{W} \mathbf{H}^{T} $$

where $\mathbf{W}$ is $N\times R$, $\mathbf{H}^{T}$ is $M\times R$, and $R \ll N$.

\note{What is the implicit assumption here?}

# Matrix Factorization

![ ](./lectures/figs/lec7/mflayout.png)

Generalization of many methods (e.g., SVD, QR, CUR, Truncated SVD, etc.)

# Aside - What should R be?

$$ \mathbf{X} \approx \mathbf{W} \mathbf{H}^{T} $$

where $\mathbf{W}$ is $M\times R$, $\mathbf{H}^{T}$ is $M\times R$, and $R \ll N$.

\note[item]{Reduced R simplifies the model substantially
\item Also decreases fidelity of reconstruction
\item Trade-off always
}

# Matrix Factorization

#### Matrix factorization is also compression

![https://www.aaronschlegel.com/image-compression-principal-component-analysis/](./lectures/figs/lec7/cat.jpg){width=80%}

# Factor Analysis

#### Matrix factorization is also compression

![https://www.aaronschlegel.com/image-compression-principal-component-analysis/](./lectures/figs/lec7/cat-3comp.jpg){width=80%}

# Factor Analysis

#### Matrix factorization is also compression

![https://www.aaronschlegel.com/image-compression-principal-component-analysis/](./lectures/figs/lec7/cat-46comp.jpg){width=80%}

\note[item]{There is always information lost
\item We just hope for it to be information that doesn't matter
}

# Examples from bioengineering

### Process control
- Large bioreactor runs may be recorded in a database, along with a variety of measurements from those runs
- We may be interested in how those different runs varied, and how each factor relates to one another
- Plotting a compressed version of that data can indicate when an anomolous change is present


# Examples from bioengineering

### Mutational processes
- Anytime multiple contributory factors give rise to a phenomena, matrix factorization can separate them out
- Will talk about this in greater detail

### Cell heterogeneity
- Enormous interest in understanding how cells are similar or different
- Answer to this can be in millions of different ways
- But cells often follow *programs*

# Principal Components Analysis

## Application of matrix factorization

- Each principal component (PC) is linear combination of **uncorrelated** attributes / features'
- Ordered in terms of variance
- $k$th PC is orthogonal to all previous PCs
- Reduce dimensionality while maintaining maximal variance

![ ](./lectures/figs/lec7/pca.png){width=40%}

# Principal Components Analysis

BOARD

\note[item]{Go through example
\item Mention normalization
\item Construct scores and loadings plot
\item Walk through interpretation of plots
\item Go through selection of component numbers
\item Talk about plotting higher components
\item Talk about relationship going back to data from PCA
}

# Methods to calculate PCA

- Iterative computation
	- More robust with high numbers of variables
	- Slower to calculate
- NIPALS (Non-linear iterative partial least squares)
	- Able to efficiently calculate a few PCs at once
	- Breaks down for high numbers of variables (large p)

# Practical Notes

## PCA

- Implemented within `sklearn.decomposition.PCA`
	- `PCA.fit_transform(X)` fits the model to `X`, then provides the data in principal component space
	- `PCA.components_` provides the "loadings matrix", or directions of maximum variance
	- `PCA.explained_variance_` provides the amount of variance explained by each component

\note{Go over explained variance.}

# PCA

~~~python
import matplotlib.pyplot as plt
from sklearn import datasets
from sklearn.decomposition import PCA

iris = datasets.load_iris()

X = iris.data
y = iris.target
target_names = iris.target_names

pca = PCA(n_components=2)
X_r = pca.fit(X).transform(X)

# Print PC1 loadings
print(pca.components_[:, 0])
# ...
~~~

# PCA

~~~python
# ...
pca = PCA(n_components=2)
X_r = pca.fit(X).transform(X)

# Print PC1 loadings
print(pca.components_[:, 0])

# Print PC1 scores
print(X_r[:, 0])

# Percentage of variance explained for each component
print(pca.explained_variance_ratio_)
# [ 0.92461621  0.05301557]
~~~

# PCA

![ ](./lectures/figs/lec7/iris_pca.png){width=90%}

# Non-negative matrix factorization

## Like PCA, except the coefficients in the linear combination must be non-negative

- Forcing positive coefficients implies an additive combination of basis parts to reconstruct whole
- Generally leads to zeros for factors that don't contribute

# Non-negative matrix factorization

## The answer you get will always depend on the error metric, starting point, and search method

BOARD

# What is significant about this?

- The update rule is multiplicative instead of additive
- In the initial values for W and H are non-negative, then W and H can never become negative
- This guarantees a non-negative factorization
- Will converge to a local maxima
	- Therefore starting point matters

# Non-negative matrix factorization

## The answer you get will always depend on the error metric, starting point, and search method

- Another approach is to find the gradient across all the variables in the matrix
- Called coordinate descent, and is usually faster
- Not going to go through implementation
- Will also converge to a local maxima

# NMF application: Netflix

Suppose Alice rates Inception 4 stars. **What led to this rating?**

\note[item]{We can think of this rating as composed of several parts:
\item A baseline rating (e.g., maybe the mean over all user-movie ratings is 3.1 stars).
\item An Alice-specific effect (e.g., maybe Alice tends to rate movies lower than the average user, so her ratings are -0.5 stars lower than we normally expect).
\item An Inception-specific effect (e.g., Inception is a pretty awesome movie, so its ratings are 0.7 stars higher than we normally expect).
\item A less predictable effect based on the specific interaction between Alice and Inception that accounts for the remainder of the stars (e.g., Alice really liked Inception because of its particular combination of Leonardo DiCaprio and neuroscience, so this rating gets an additional 0.7 stars).
\item In other words, we’ve decomposed the 4-star rating into: 4 = [3.1 (the baseline rating) - 0.5 (the Alice effect) + 0.7 (the Inception effect)] + 0.7 (the specific interaction)
\item So instead of having our models predict the 4-star rating itself, we could first try to remove the effect of the baseline predictors (the first three components) and have them predict the specific 0.7 stars. (I guess you can also think of this as a simple kind of boosting.)}

# NMF application: Netflix

480,000 users x 17,700 movies Test data: most recent ratings

![ ](./lectures/figs/lec7/netflix-td.png){width=80%}

## What do you think is done with missing values?


# NMF application: Netflix

- More generally, additional baseline predictors include:
	- A factor that allows Alice’s rating to (linearly) depend on the (square root of the) number of days since her first rating. (For example, have you ever noticed that you become a harsher critic over time?)
	- A factor that allows Alice’s rating to depend on the number of days since the movie’s first rating by anyone. (If you’re one of the first people to watch it, maybe it’s because you’re a huge fan and really excited to see it on DVD, so you’ll tend to rate it higher.)
	- A factor that allows Alice’s rating to depend on the number of people who have rated Inception. (Maybe Alice is a hipster who hates being part of the crowd.)
	- A factor that allows Alice’s rating to depend on the movie’s overall rating.
	- (Plus a bunch of others.)


# NMF application: Netflix

And, in fact, modeling these biases turned out to be fairly important: in their paper describing their final solution to the Netflix Prize, Bell and Koren write that:

*Of the numerous new algorithmic contributions, I would like to highlight one – those humble baseline predictors (or biases), which capture main effects in the data. While the literature mostly concentrates on the more sophisticated algorithmic aspects, we have learned that an accurate treatment of main effects is probably at least as signficant as coming up with modeling breakthroughs.*

\note{(For a perhaps more concrete example of why removing these biases is useful, suppose you know that Bob likes the same kinds of movies that Alice does. To predict Bob’s rating of Inception, instead of simply predicting the same 4 stars that Alice rated, if we know that Bob tends to rate movies 0.3 stars higher than average, then we could first remove Alice’s bias and then add in Bob’s: 4 + 0.5 + 0.3 = 4.8.)}


# NMF application: Netflix

![ ](./lectures/figs/lec7/netflix-lf.png)


# NMF application: Mutational Processes in Cancer

![Helleday et al, Nat Rev Gen, 2014](./lectures/figs/lec7/mutgen.jpg)

# NMF application: Mutational Processes in Cancer

![Helleday et al, Nat Rev Gen, 2014](./lectures/figs/lec7/mutproc.jpg)

# NMF application: Mutational Processes in Cancer

![Alexandrov et al, Cell Rep, 2013](./lectures/figs/lec7/sigA.jpg)

# NMF application: Mutational Processes in Cancer

![Alexandrov et al, Cell Rep, 2013](./lectures/figs/lec7/sigB.jpg)

\note[item]{Also used in interpreting medical health records}

# Practical Notes - NMF

- Implemented within `sklearn.decomposition.NMF`.
	- `n_components`: number of components
	- `init`: how to initialize the search
	- `solver`: 'cd' for coordinate descent, or 'mu' for multiplicative update
	- `l1_ratio`: Can regularize fit
- Provides:
	- `NMF.components_`: components x features matrix
	- Returns transformed data through `NMF.fit_transform()`

# Summary

## PCA

- Preserves the covariation within a dataset
- Therefore mostly preserves axes of maximal variation
- Number of components can vary—in practice more than 2 or 3 rarely helpful

## NMF

- Explains the dataset through factoring into two **non-negative** matrices
- Much more stable and well-specified reconstruction when assumptions are appropriate
- Excellent for separating out additive factors

# Closing

**As always, selection of the appropriate method depends upon the question being asked.**
