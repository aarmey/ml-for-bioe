---
title: Week 5, Lecture 10 - Hidden Markov Models
author: Aaron Meyer
---

# Outline

- Administrative Issues
- Review
- Hidden Markov Models
- Applications

**Based on slides from Aarti Singh.**

# Sequential Data

- So far we've largely assumed that we have independent data
- But what if we have sequences?
	- E.g. audio, a string of text, time-series data
	- Then our measurements are co-dependent
	- Assumption of independence often gives nonsensical results


# Markov Models

- Joint Distribution
	- $p(\mathbf{X}) = p(X_1, X_2, \ldots , X_n)$
	- $p(\mathbf{X}) = p(X_1) p(X_2 \mid X_1) p(X_3 \mid X_2, X_1) \ldots p(X_n \mid X_{n-1}, \ldots , X_1)$
	- $\prod_{i=1}^{n} p(X_n \mid X_{n-1}, \ldots , X_1)$
		- Chain rule
- Markov Assumption
	- $\prod_{i=1}^{n} p(X_n \mid X_{n-1}, \ldots , X_{n-m})$
		- Current observation only depends on past m observations

\note{Joint distribution makes no assumptions. "Memory" will often be just m = 1.}

# Markov Models

#### Markov Assumption

![ ](./lectures/figs/lec10/2.pdf){width=80%}

# Markov Models

#### Markov Assumption

The number of parameters in a stationary model with K-ary variables

- $1$st Order
	- $p(\mathbf{X}) = \prod_{i=1}^n p(X_n \mid X_{n-1})$
	- $O(K^2)$
- $m$th Order
	- $p(\mathbf{X}) = \prod_{i=1}^n p(X_n \mid X_{n-1}, \ldots, X_{n-m})$
	- $O(K^{m+1})$
- $n-1$th Order
	- $p(\mathbf{X}) = \prod_{i=1}^n p(X_n \mid X_{n-1}, \ldots, X_1)$
	- $O(K^n)$
	- No assumptions: Complete (but directed) graph

*Homogeneous/stationary Markov model (probabilities don’t depend on n)*

# Hidden Markov Models

Distributions that characterize sequential data with few parameters but are not limited by strong Markov assumptions.

![ ](./lectures/figs/lec10/4.pdf){width=60%}

Observation space: $O_t \in \{y_1, \ldots, y_k \}$

Hidden states: $S_t \in \{1, \ldots, I\}$

\note{Emmissions are *on top of* the markov chain. If we could directly see the state of the chain, we wouldn't need a model in the first place!}


# Hidden Markov Models

![ ](./lectures/figs/lec10/4.pdf){width=60%}

$$p(S_1,\ldots,S_T,O_1,\ldots,O_T) = \prod_{t=1}^T p(O_t\mid S_t)\prod_{t=1}^T p(S_t\mid S_{t-1})$$

1st order Markov assumption on hidden states $\{S_t\}$ $t=1,\ldots,T$ (can be extended to higher order).

Note: $O_t$ depends on all previous observations $\{O_{t-1},\ldots O_1\}$

# Hidden Markov Models

Parameters for stationary/homogeneous Markov model

- Independent of $T$
- Initial probabilities: $p(S_1 = i) = \pi_i$
- Transition probabilities: $p(S_t = j \mid S_{t-1} = i) = p_{ij}$
- Emission probabilities: $p(O_t = y \mid S_t = i) = q_i^y$

![ ](./lectures/figs/lec10/6.pdf){width=40%}

# HMM Example

#### The Dishonest Casino

A casino has two die:

- Fair dice
- Loaded dice: $P(6) = 1/2, P(1) = P(2) = P(3) = P(4) = P(5) = 1/10$

Casino player switches back & forth between fair and loaded die once every 20 turns.

# HMM Problems

**Given:** A sequence of rolls by the casino player:

4352**6**1**6**25434**6**1**6**52**6**53421**6**515243**6**1**6**15243241322515432**6**

Questions:

- How likely is this sequence, given our model of how the casino works?
	- This is the **evaluation** problem in HMMs
- What portion of the sequence was generated with the fair die, and what portion with the loaded die?
	- This is the **decoding** question in HMMs
- How biased is the loaded die? How fair is the fair die? How often does the casino player change from fair to loaded and back?
	- This is the **learning** question in HMMs

\note{Outcome of evaluation is a likelihood. Of decoding, hidden states. Of learning, parameters.}

# HMM Example

![ ](./lectures/figs/lec10/9.pdf)

# State Space Representation

Switch between **F** and **L** once every 20 turns (1/20 = 0.05)

![ ](./lectures/figs/lec10/10.pdf)

# Three main problems in HMMs

- **Evaluation**: Given HMM parameters & observation seqn $\{O_t\}_{t=1}^T$
	- find the probability of observed sequence
- **Decoding**: Given HMM parameters & observation seqn $\{O_t\}_{t=1}^T$
	- find most probable sequence of hidden states
- **Learning**: Given HMM with unknown parameters and $\{O_t\}_{t=1}^T$ observation sequence
	- find parameters that maximize likelihood of observed data

# HMM Algorithms

- Evaluation
	- What is the probability of the observed sequence? **Forward Algorithm**
- Decoding
	- What is the probability that the third roll was loaded given the observed sequence? **Forward-Backward Algorithm**
	- What is the most likely die sequence given the observed sequence? **Viterbi Algorithm**
- Learning
	- Under what parameterization is the observed sequence most probable? **Baum-Welch Algorithm (EM)**

# Evaluation Problem

Given HMM parameters $p(S_1), p(S_t\mid S_{t-1}), p(O_t\mid S_t)$ & observation sequence $\{O_t\}_{t=1}^T$

![ ](./lectures/figs/lec10/13.pdf)

# Forward Probability

![ ](./lectures/figs/lec10/14.pdf)

# Forward Algorithm

Can compute $\alpha_t^k$ for all $k$, $t$ using dynamic programming:

- Initialize: $\alpha_1^k = p(O_1 \mid S_1 = k) p(S_1 = k)\;\; \forall k$
- Iterate: for $t = 2, \ldots, T$ $$\alpha_t^k = p(O_t \mid S_t = k) \sum_i \alpha_{t-1}^i p(S_t = k \mid S_{t-1} = i)\;\; \forall k$$
- Termination: $$p\left( \{O_t\}_{t=1}^T \right) = \sum_k \alpha_T^k$$

# Decoding Problem 1

![ ](./lectures/figs/lec10/16.pdf)

# Backward Probability

![ ](./lectures/figs/lec10/17.pdf)

# Backward Algorithm

Can compute $\beta_t^k\;\;\forall k,t$ using dynamic programming:

- Initialize: $\beta_T^k = 1\;\; \forall k$
- Iterate: for t = T-1, ..., 1 $$\beta_t^k = \sum_i p(S_{t+1} = i \mid S_t = k)p(O_{t+1}\mid S_{t+1} = i)\beta_{t+1}^i \;\; \forall k$$
- Termination: $p(S_t = k, \{O_t\}_{t=1}^T) = \alpha_t^k \beta_t^k$

$$p(S_t = k \mid \{ O_t \}_{t=1}^T) = \frac{p(S_t = k, \{O_t\}_{t=1}^T)}{p(\{O_t\}_{t=1}^T)} = \frac{\alpha_t^k \beta_t^k}{\sum_i \alpha_t^i \beta_t^i}$$

#  Most likely state vs. Most likely sequence

- Most likely state assignment at time t $$\arg\max_k p(S_t =k\mid\{O_t\}_{t=1}^T) = \arg\max_k \alpha_t^k \beta_t^k$$
	- E.g. Which die was most likely used by the casino in the third roll given the
observed sequence?
- Most likely assignment of state sequence $$\arg\max_{\{S_t\}_{t=1}^T} p(\{S_t\}_{t=1}^T \mid \{O_t\}_{t=1}^T)$$
	- E.g. What was the most likely sequence of die rolls used by the casino given the observed sequence?

**Not the same!**

# Decoding Problem 2

![ ](./lectures/figs/lec10/20.pdf)

# Viterbi Decoding

![ ](./lectures/figs/lec10/21.pdf)

# Viterbi Algorithm

Can compute $V_t^k\;\;\forall k, t$ using dynamic programming:

![ ](./lectures/figs/lec10/22.pdf)

# Computational complexity

What is the running time for Forward, Forward-Backward, Viterbi?

$$\alpha_t^k = q_k^{O_t} \sum_i \alpha_{t-1}^i p_{i,k}$$

$$\beta_t^k = \sum_i p_{k,i} q_i^{O_{t+1}} \beta_{t+1}^i$$

$$V_t^k = q_k^{O_t} \max_i p_{i,k} V_{t-1}^i$$

$O(K^2T)$ linear in T instead of $O(K^T)$ exponential in T!

# Learning Problem

- Given HMM with:
	- unknown parameters $\theta=\{\{\pi_i\}, \{p_{ij}\}, \{q_i^k\}\}$
	- observation sequence $O=\{O_t\}_{t=1}^T$
- Find parameters that maximize likelihood of observed data
	- $\arg\max_\theta p\left(\{O_t\}_{t=1}^T\mid\theta\right)$
	- But likelihood doesn’t factorize since observations not i.i.d.
	- hidden variables: state sequence
- EM (Baum-Welch) Algorithm:
	- E-step: Fix parameters, find expected state assignments
	- M-step: Fix expected state assignments, update parameters

# Baum-Welch (EM) Algorithm

![ ](./lectures/figs/lec10/25.pdf)

# Baum-Welch (EM) Algorithm

- Start with random initialization of parameters

![ ](./lectures/figs/lec10/26.pdf)

# Some connections

- HMM & Dynamic Mixture Models
	- $p(O_t) = \sum_{S_t} p(O_t \mid S_t) p(S_t)$
- Choice of mixture component depends on choice of components for previous observations

![ ](./lectures/figs/lec10/27.pdf)

# Connections to Other Models

## ODEs

- If we average over many individuals following a Markov process, we get a system of ODEs
- Multiple Markov models can give rise to the same ODEs due to transition probabilities

## Latent variable models

- Many techniques we've talked about separate the data from the process generating it

# HMMs: What You Should Know

- Useful for modeling sequential data with few parameters using discrete hidden states that satisfy Markov assumption
- Representation
	- Initial probability
	- Transition probabilities
	- Emission probabilities
- Algorithms for inference and learning in HMMs
	- Computing marginal likelihood of the observed sequence: *forward algorithm*
	- Predicting a single hidden state: forward-backward
	- Predicting an entire sequence of hidden states: Viterbi
	- Learning HMM parameters: an EM algorithm known as Baum-Welch

# Example: Cancer Stem Cells

![ ](./lectures/figs/lec10/gupta1.pdf)

# Example: Cancer Stem Cells

![ ](./lectures/figs/lec10/gupta3.pdf)

# Example: Cancer Stem Cells

![ ](./lectures/figs/lec10/gupta4.pdf)

# Example: Cancer Stem Cells

![ ](./lectures/figs/lec10/gupta5.pdf)

# Example: Cancer Stem Cells

![ ](./lectures/figs/lec10/gupta6.pdf)

# Example 2: Sequence Prediction

![AXL prediction](./lectures/figs/lec10/AXL-THMM.pdf){width=90%}

# Implementation

```python
from hmmlearn.hmm import GaussianHMM

# Make an HMM instance and execute fit
model = GaussianHMM(n_components=4,
					covariance_type="diag",
					n_iter=1000).fit(X)

# Predict the optimal sequence of internal hidden state
hidden_states = model.predict(X)

print("Transition matrix")
print(model.transmat_)

print("Means and vars of each hidden state")
for i in range(model.n_components):
    print("{0}th hidden state".format(i))
    print("mean = ", model.means_[i])
    print("var = ", np.diag(model.covars_[i]))
```

# Implementation

Find most likely state sequence corresponding to `X`.

```python
model.decode(X, algorithm=None)
```

algorithm: Decoder algorithm. Must be one of “viterbi” or “map”. “viterbi” default.

Provides `logprob` and `state_sequence`.

# Further Reading

- [`hmmlearn`](http://hmmlearn.readthedocs.io/en/latest/index.html)
- [What is a hidden Markov model?](https://www.nature.com/articles/nbt1004-1315)
- [Linear Digressions - Hidden Markov Models](https://lineardigressions.com/episodes/2016/2/23/introducing-hidden-markov-models-hmm-part-1) ([part 2](https://lineardigressions.com/episodes/2016/2/23/genetics-and-um-detection-hmms-part-2))
