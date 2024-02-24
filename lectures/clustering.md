---
title: Clustering
author: Aaron Meyer
---

# Outline

- Administrative Issues
- Clustering
	- K-Means
	- Agglomerative
- Clustering examples
- Implementation

**Slides adapted from David Sontag.**

# Clustering

- Unsupervised learning
- Requires data, but no labels
- Detect patterns e.g. in
	- Gene expression between patient samples
	- Images
	- Really any sets of measurements across samples
- Useful when don’t know what you’re looking for
- But: **can be gibberish**

# Clustering

- Basic idea: group together similar instances
- Example: 2D point patterns

![ ](./lectures/figs/lec13/clust1.png)

\note{Go over what is the data input and output (discrete).}

# Clustering

- Basic idea: group together similar instances
- Example: 2D point patterns

![ ](./lectures/figs/lec13/clust2.png)

# Clustering

- Basic idea: group together similar instances
- Example: 2D point patterns

![ ](./lectures/figs/lec13/clust3.png)

# What could "similar" mean?

- One option: Euclidean distance

$$ \textrm{dist}(\mathbf{x}, \mathbf{y}) = \norm{\mathbf{x} - \mathbf{y}} $$

- Clustering results are **completely** dependent on the measure of similarity (or distance) between "points" to be clustered

# What properties should a distance measure have?

- Symmetric
	- $D(A, B) = D(B, A)$
	- Otherwise we can say A looks like B but not vice-versa
- Positivity and self-similarity
	- $D(A,B) > 0$, and $D(A,B)=0$ iff $A=B$
	- Otherwise there will be objects that we can't tell apart
- Triangle inequality
	- $D(A, B) + D(B, C) \geq D(A,C)$
	- Otherwise one can say "A is like B, B is like C, but A is not like C at all"

# Clustering algorithms

::: columns

:::: column
- Partition algorithms (flat)
	- K-means
	- Gaussian mixtures

- Heirarchical algorithms
	- Bottom up - agglomerative
	- Top down - divisive
::::

:::: column
![ ](./lectures/figs/lec13/simpsons.png)
::::

:::

# K-means

::: columns

:::: column
- An iterative partitioning clustering algorithm
	- Initialize: Pick K random points as cluster centers
	- Alternate:
		1. Assign data points to closest cluster center
		2. Change the cluster center to the average of its assigned points
	– Stop when no points’ assignments change
::::

![ ](./lectures/figs/lec13/kmeans1.png){ width=40% }

:::

# K-means

::: columns

:::: column
- An iterative partitioning clustering algorithm
	- Initialize: Pick K random points as cluster centers
	- Alternate:
		1. Assign data points to closest cluster center
		2. Change the cluster center to the average of its assigned points
	– Stop when no points’ assignments change
::::

![ ](./lectures/figs/lec13/kmeans2.png){ width=40% }

:::

# K-means clustering: Example

- Pick K random points as cluster centers (means)
	- Shown here for K=2

![ ](./lectures/figs/lec13/k1.png){ width=50% }

# K-means clustering: Example

## Iterative Step 1

Assign data points to closest cluster center

![ ](./lectures/figs/lec13/k2.png){ width=50% }

\note{Critical step is right here. How do we pick what is close? Which is closer?}

# K-means clustering: Example

## Iterative Step 2

Change the cluster center to the average of the assigned points

![ ](./lectures/figs/lec13/k3.png){ width=50% }

\note[item]{Can be slow for very large numbers of data points.
\item Can use stochastic sampling in some cases.
}

# K-means clustering: Example

Repeat until convergence

![ ](./lectures/figs/lec13/k4.png){ width=50% }

# K-means clustering: Example

![ ](./lectures/figs/lec13/k5.png){ width=50% }

# K-means clustering: Example

![ ](./lectures/figs/lec13/k6.png){ width=50% }


# Another Example

![Step 1](./lectures/figs/lec13/slides2-1.pdf)

# Another Example

![Step 2](./lectures/figs/lec13/slides2-2.pdf)

# Another Example

![Step 3](./lectures/figs/lec13/slides2-3.pdf)

# Another Example

![Step 4](./lectures/figs/lec13/slides2-4.pdf)

# Another Example

![Step 5](./lectures/figs/lec13/slides2-5.pdf)

# Another Example

![Step 6](./lectures/figs/lec13/slides2-6.pdf)

# Another Example

![Step 7](./lectures/figs/lec13/slides2-7.pdf)

# Properties of K-means algorithm

- Guaranteed to converge in a finite number of iterations
- Running time per iteration:
	1. Assign data points to closest cluster center:
		- **O(KN) time**
	2. Change the cluster center to the average of its assigned points:
		- **O(N) time**

# K-Means Convergence

**Objective:** $\min_{\mu}\min_{C}\sum_{i=1}^k \sum_{x\in C_i} \norm{x - \mu_i}^2$

1. Fix $\mu$, optimize $C$: $$\min_C \sum_{i=1}^k \sum_{x\in C_i} \norm{x - \mu_i}^2 = \min_C \sum_{i}^n \norm{x_i - \mu_{x_i}}^2$$
2. Fix $C$, optimize $\mu$: $$\min_{\mu}\sum_{i=1}^k \sum_{x\in C_i} \norm{x - \mu_i}^2$$
	- Take partial derivative of $\mu_i$ and set to zero, we have $$\mu_i = \frac{1}{\norm{C_i}} \sum_{x \in C_i} x$$

Kmeans takes an alternating optimization approach. Each step is guaranteed to decrease the objective—thus guaranteed to converge.

# Initialization

::: columns

:::: column
K-means algorithm is a heuristic:

- Requires initial means
- It does matter what you pick!
- What can go wrong?
- **Various schemes for preventing this kind of thing:** variance-based split / merge, initialization heuristics
::::

![ ](./lectures/figs/lec13/init.png){ width=40% }

:::

# K-Means Getting Stuck

Local optima dependent on how the problem was specified:

![ ](./lectures/figs/lec13/localopt.png)

# K-means not able to properly cluster

![ ](./lectures/figs/lec13/circle.png)

\note[item]{Go over number of clusters.
\item Show example data.
\item What would within-cluster distance look like in the ideal case?
}

# Changing the features (distance function) can help

![ ](./lectures/figs/lec13/circletrans.png)

\note[item]{This is the kernel method.
\item Will use again with SVMs!
}

# Agglomerative Clustering

::: columns

:::: {.column width=60%}
- Agglomerative clustering:
	- First merge very similar instances
	- Incrementally build larger clusters out of smaller clusters
- Algorithm:
	- Maintain a set of clusters
	- Initially, each instance in its own cluster
	- Repeat:
		- Pick the two closest clusters
		- Merge them into a new cluster
		- Stop when there’s only one cluster left
- Produces not one clustering, but a family of clusterings represented by a dendrogram
::::

:::: {.column width=40%}
![ ](./lectures/figs/lec13/agg1.png){ width=100% }
::::

:::

# Agglomerative Clustering

How should we define “closest” for clusters with multiple elements?

![ ](./lectures/figs/lec13/agg2.png){ width=50% }

# Agglomerative Clustering

- How should we define “closest” for clusters with multiple elements?
- Many options:
	- Closest pair (single-link clustering)
	- Farthest pair (complete-link clustering)
	- Average of all pairs
- Different choices create different clustering behaviors

![ ](./lectures/figs/lec13/agg3.png){ width=40% }

# Agglomerative Clustering

- How should we define “closest” for clusters with multiple elements?
- Many options:
	- Closest pair (left)
	- Farthest pair (right)
	- Average of all pairs
- Different choices create different clustering behaviors

![ ](./lectures/figs/lec13/agglo.png){ width=90% }

# Clustering Behavior

![Mouse tumor data from Hastie et al.](./lectures/figs/lec13/clustbeh.png)

# Agglomerative Clustering Questions

- Will agglomerative clustering converge?
	- To a global optimum?
- Will it always find the true patterns in the data?
- Do people ever use it?
- How many clusters to pick?

# Reconsidering “hard assignments”?

- Clusters may overlap
- Some clusters may be “wider” than others
- Distances can be deceiving!

![ ](./lectures/figs/lec13/olap.pdf){ height=60% }

# Applications

- Clustering patients into groups based on molecular or eitiological measurements
- Cells into groups based on molecular measurements
- Neuronal signals 

# Clustering Patients

![ ](./lectures/figs/lec13/BCclustersTitle.pdf)

# Clustering Patients

![ ](./lectures/figs/lec13/BCclusters.pdf)

\note[item]{We use clusters because they (hopefully) translate to meaningful differences.
\item What if you cluster based on different measurements?
}

# Clustering molecular signals

![ ](./lectures/figs/lec13/kristenTitle.pdf)

# Clustering molecular signals

![ ](./lectures/figs/lec13/KristenMethods.pdf)

# Clustering molecular signals

![ ](./lectures/figs/lec13/KristenClustClust.pdf)

# Clustering molecular signals

![ ](./lectures/figs/lec13/kristen-clusters.pdf)

# Review

![ ](./lectures/figs/lec13/review-title.pdf)

# Review

![ ](./lectures/figs/lec13/review-fig1.pdf)

# Review

![ ](./lectures/figs/lec13/review-fig2.pdf)

# Review

![ ](./lectures/figs/lec13/review-fig3.pdf)

# Review

![ ](./lectures/figs/lec13/review-fig4.pdf)

# Review

![ ](./lectures/figs/lec13/review-fig5.pdf)

# Review

![ ](./lectures/figs/lec13/review-fig6.pdf)

# Implementation

## K-means

`sklearn.cluster.KMeans`

- `n_clusters`: Number of clusters to form
- `init`: Initialization method
- `n_init`: Number of initializations
- `max_iter`: Maximum steps algorithm can take

## Agglomerative

`sklearn.cluster.AgglomerativeClustering`

# Implementation - K-means

```python
import numpy as np
from matplotlib.pyplot import figure
from mpl_toolkits.mplot3d import Axes3D

from sklearn.cluster import KMeans
from sklearn import datasets

iris = datasets.load_iris()
X, y = iris.data, iris.target

est = KMeans(n_clusters=3)

ax = Axes3D(figure(), rect=[0, 0, .95, 1], elev=48, azim=134)
est.fit(X)
labels = est.labels_

ax.scatter(X[:, 3], X[:, 0], X[:, 2],
           c=labels.astype(np.float), edgecolor='k')

# ...
```

# Implementation - K-means

![ ](./lectures/figs/lec13/iris1.png){ width=70% }

# Implementation - K-means

![ ](./lectures/figs/lec13/iris2.png){ width=70% }

# Further Reading

- [sklearn: Clustering](https://scikit-learn.org/stable/modules/clustering.html)
- [Avoiding common pitfalls when clustering biological data](https://stke.sciencemag.org/content/9/432/re6)