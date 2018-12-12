---
title: Week 8, Lecture 15 - Decision Trees
author: Aaron Meyer
---

# Outline

- Administrative Issues
- Decision Trees
- Applications
- Implementation

# Classification

- With MLR and PLSR we talked about supervised regression
	- Continuous Y and continuous predictions
- With clustering, we get discrete predictions
	- But no Y output
- In the next two lectures, we're going to talk about methods that give discrete Y predictions
	- Decision trees (today)
	- Support vector machines (next lecture)

# Decision Tree Representation

- Classification of instances by sorting them down the tree from the root to some leaf note
	- **node** ≈ test of some attribute
	- **branch** ≈ one of the possible values for the attribute
- Decision trees represent a **disjunction of conjunctions of constraints on the attribute values of instances**
- Equivalent to a set of if-then-rules
	- each branch represents one if-then-rule
		- **if-part:** conjunctions of attribute tests on the nodes
		- **then-part:** classification of the branch

# Decision Tree Representation

![ ](./lectures/figs/lec15/fig3.pdf)

- This decision tree is equivalent to:
	- if (Outlook = Sunny) ∧ (Humidity = Normal) then Yes;
	- if (Outlook = Overcast) then Yes;
	- if (Outlook = Rain) ∧ (Wind = Weak) then Yes;

# Appropriate Problems

- Instances are represented by attribute-value pairs, e.g. (Temperature, Hot)
- Target function has discrete output values, e.g. *yes* or *no*
- **Disjunctive descriptions** may be required
- Training data may **contain errors**
- Training data may contain **missing attribute values**
	- Last three points make Decision Tree Learning more attractive than CANDIDATE-ELIMINATION

# ID3

- Learns decision trees by constructing them **top-down**
- employs a **greedy search algorithm without backtracking** through the
space of all possible decision trees
	- finds the shortest but not neccessarily the best decision tree
- **key idea:**
	- selection of the next attribute according to a statistical measure
	- all examples are considered at the same time (simultaneous covering)
	- recursive application with reduction of selectable attributes until each training example can be classified unambiguously

# ID3 algorithm

`ID3(Examples, Target_attribute, Attributes)`

### Create a `Root` for the tree

- If all examples are **positive**, Return single-node tree `Root`, with `label = +`
- If all examples are **negative**, Return single-node tree `Root`, with `label = −`
- If `Attributes` is empty, Return single-node tree `Root`, with `label =` most common value of `Target_attribute` in `Examples`

# ID3 algorithm

`ID3(Examples, Target_attribute, Attributes)`

#### **otherwise**, Begin

- A $\leftarrow$ attribute in Attributes that best classifies Examples decision attribute for Root $\leftarrow$ A
- **For each possible value $v_i$ of A**
	- Add new branch below Root with $A = v_i$
	- Let `Examples_vi` be the subset of Examples with $v_i$ for $A$
	- If `Examples` is empty
		- Then add a leaf node with `label =` most common value of `Target_attribute` in `Examples`
		- Else add `ID3(Examples_vi, Target_Attribute, Attributes − {A})`
- Return `Root`

# The best classifier

- **Central choice:** Which attribute classifies the examples best?
- ID3 uses the **information gain**
	- statistical measure that indicates how well a given attribute separates the training examples according to their target classification

![ ](./lectures/figs/lec15/fig7.pdf)

- Interpretation:
	- Denotes the reduction in entropy caused by partitioning $S$ according to $A$
	- Alternative: number of saved yes/no questions (i.e., bits)
	- Attribute with $\max_A Gain(S, A)$ is selected!

# Entropy

- Statistical measure from information theory that **characterizes (im-)purity** of an arbitrary collection of examples *S*
	- Definition: $H(S) \equiv  \sum_{\forall i} −p_i \log_2 p_i$
- Interpretation
	- Specification of the minimum number of bits of information needed to encode the classification of an arbitrary member of *S*
	- Alternative: number of yes/no questions

# Entropy

![ ](./lectures/figs/lec15/fig9.pdf)

- Minimum of H(S)
	- For minimal impurity → point distribution $H(S) = 0$
- Maximum of $H(S)$
	- For maximal impurity → uniform distribution
	- For binary classification: $H(S) = 1$
	- For n-ary classification: $H(S) = \log_2 n$

# Illustrative Example

#### Example days:

![ ](./lectures/figs/lec15/fig10.pdf)

# Illustrative Example

![ ](./lectures/figs/lec15/fig11.pdf)

# Illustrative Example

#### Which attribute is the best classifier?

![ ](./lectures/figs/lec15/fig12.pdf)

# Illustrative Example

- Informations gains for the four attributes:
	- *Gain(S, Outlook) = 0.246*
	- *Gain(S, Humidity) = 0.151*
	- *Gain(S, Wind) = 0.048*
	- *Gain(S, Temperature) = 0.029*
- *Outlook* is selected as best classifier and is therefore root of the tree
- Now branches are created below the root for each possible value
	- Because every example for which *Outlook = Overcast* is positive, this node becomes a leaf node with the classification *Yes*
	- The other descendants are still ambiguous (e.g. $H(S) \neq 0$)
	- Hence, the decision tree has to be further elaborated below these nodes

# Illustrative Example

![ ](./lectures/figs/lec15/fig14.pdf)

# Illustrative Example

#### Resulting decision tree

![ ](./lectures/figs/lec15/fig15.pdf)

# Hypothesis Space Search

![ ](./lectures/figs/lec15/fig16.pdf)

- H ≈ complete space of finite discrete functions, relative to the available attributes (i.e. all possible decision trees)
- **capabilites and limitations:**
	- returns just one single consistent hypothesis
	- performs greedy search
	- susceptible to the usual risks of hill-climbing without backtracking
	- uses all training examples at each step ⇒ simultaneous covering

# Inductive Bias

- As mentioned above, ID3 searches
	- Complete space of possible, but not completely
	- Preference Bias
- Inductive bias: Shorter trees are prefered to longer trees. Trees that place high information gain attributes close to the root are also prefered.
- Why prefer shorter hypotheses?
	- Occam’s Razor: Prefer the simplest hypothesis that fits the data!
	- see Minimum Description Length Principle (Bayesian Learning)
	- e.g., if there are two decision trees, one with 500 nodes and another with 5 nodes, the second one should be prefered
	- better chance to avoid overfitting

# Overfitting

![ ](./lectures/figs/lec15/fig18.pdf)

Given a hypothesis space $H$, a hypothesis $h \in H$ is said to overfit the training data if there exists some alternative hypothesis $h' \in H$, such that $h$ has smaller error than $h'$ over the training, but $h'$ has smaller error than $h$ over the entire distribution of instances.

# Overfitting

- Reasons for overfitting:
	- Noise in the data
	- Number of training examples is to small too produce a representative sample of the target function
- How to avoid overfitting:
	- Stop the tree grow earlier, before it reaches the point where it perfectly classifies the training data
	- Allow overfitting and then **post-prune** the tree (more successful in practice!)
- How to determine the perfect tree size:
	- Separate validation set to evaluate utility of post-pruning
	- Apply statistical test to estimate whether expanding (or pruning) produces an improvement

# Reduced Error Pruning

- Each of the decision nodes is considered to be candidate for pruning

![ ](./lectures/figs/lec15/fig20.pdf){width=50%}

- Pruning a decision node consists of removing the subtree rootet at the node, making it a leaf node and assigning the most common classification of the training examples affiliated with that node
- Nodes are removed only if the resulting tree performs not worse than the original tree over the validation set
- Pruning starts wit the node whose removal most increases accuracy and continues until further pruning is harmful

# Reduced Error Pruning

#### Effect of reduced error pruning:

![ ](./lectures/figs/lec15/fig21.pdf){width=80%}

Any node added to coincidental regularities in the training set is likely to be pruned.

# Rule Post-Pruning

- Rule post-pruning involves the following steps:
	1. Infer the decision tree from the training set (Overfitting allowed!)
	2. Convert the tree into a set of rules
	3. Prune each rule by removing any preconditions that result in improving its estimated accuracy
	4. Sort the pruned rules by their estimated accuracy
- One method to estimate rule accuracy is to use a separate validation set
- Pruning rules is more precise than pruning the tree itself

# Alternative Measures

- Natural bias in information gain favors attributes with many values over those with few values
- e.g. attribute `Date`
	- Very large number of values (e.g. March 21, 2005)
	- Inserted in the above example, it would have the highest information gain, because it perfectly separates the training data
	- But the classification of unseen examples would be impossible
- Alternative measure: `GainRatio`
	- $GainRatio(S, A) = \frac{Gain(S,A)}{SplitInformation(S,A)}$
	- $SplitInformation(S, A) \equiv − \sum_{i=1}^n \frac{S_i}{S} \log_2 \frac{S_i}{S}$
	- `SplitInformation(S,A)` is sensitive to how broadly and uniformly *A* splits *S* (entropy of *S* with respect to the values of *A*)
	- *GainRatio* penalizes attributes such as `Date`

# Summary

- Practical and intuitively understandable method for concept learning
- Able to learn disjunctive, discrete-valued concepts
- Noise in the data is allowed
- ID3 is a simultaneous covering algorithm based on information gain that performs a greedy top-down search through the space of possible decision trees
- Inductive Bias: Short trees are prefered (Occam’s razor)
- Overfitting is an important issue and can be reduced by pruning

# Applications - Medical Diagnosis / Prediction

![ ](./lectures/figs/lec15/app-1.pdf)

# Applications - Medical Diagnosis / Prediction

![ ](./lectures/figs/lec15/app-2.pdf)

# Applications - Medical Diagnosis / Prediction

![ ](./lectures/figs/lec15/app-model.pdf)

# Applications - Medical Diagnosis / Prediction

![ ](./lectures/figs/lec15/app-roc.pdf)

# Applications - Medical Diagnosis / Prediction

![ ](./lectures/figs/lec15/app-vars.pdf)

# Practical Notes

- Building and applying decision trees is extremely fast.
- Results are very interpretable.
- With boosting, DTs often win at prediction with large data and many variables.
	- But this comes at the expense of interpreting the model.
- Bootstrap difficult to apply to DTs, due to structure.

# Implementation







# Further Reading

- [Computer Age Statistical Inference, Chapter 8](https://web.stanford.edu/~hastie/CASI_files/PDF/casi.pdf)
- [sklearn.tree](http://scikit-learn.org/stable/modules/tree.html#tree)
