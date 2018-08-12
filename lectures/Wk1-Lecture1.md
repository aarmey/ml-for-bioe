---
title: Week 1, Lecture 1 - Introduction, statistics review
author: Aaron Meyer
---

# BIOENGR 188: Machine learning & data-driven modeling in bioengineering

## Lecture:

- Tuesdays/Thursdays 2:00–3:50pm
- Public Affairs 1256

## Lab

- Fridays, 10:00 - 11:50am
- 3760 Boelter Hall

<https://bioe-ml-w18.github.io/bioe-ml-winter2018/>

# Lecture Slides

- Lecture slides will be posted on the course website.
- I'll try to finalize them by the night before, so you can print them out if you want.
- The slides posted the night before will *not* be everything, but will include space to fill out missing elements during class.

# Textbook / Other Course Materials

- There is no textbook for this course.
- I will post related readings prior to each lecture.
- These will either broaden the scope of material covered in class, or provide critical background.
- I'll make it clear which is the case.

# Support / Office Hours

## Prof. Meyer

- Friday 2:00-3:00 pm or by appointment (ameyer@ucla.edu)
- I will usually also stick around after class and am happy to answer questions.

## TAs

- TBD or by appointment

# Learning Goals:

By the end of the course you will have an increased understanding of:

1. Critical Thinking and Analysis: Understand the process of identifying critical problems, analyzing current solutions, and determining alternative successful solutions.
2. Engineering Design: Apply mathematical and scientific knowledge to identify, formulate, and solve problems in the chosen design area.
3. Computational Modeling: Apply computational tools to solve and optimize engineering problems.
4. Communicate Effectively: Learn how to give an effective presentation. Understand how to communicate progress orally and in written reports.
5. Manage and Work in Teams: Learn to work and communicate effectively with peers to attain a common goal.

# Practical Learning Objectives

By the end of the course you will learn how to:

1. Identify a question that can or cannot be solved by a modeling approach.
2. Determine the prerequisites to applying a modeling method.
3. Implement a number of different modeling methods to answer specific questions.
4. Critically assess modeling results.

# Grade Breakdown

40%
~ Final Project

30%
~ Homework Assignments

10%
~ Implementation Files

10%
~ Midterm

10%
~ Class Participation

# Labs

## Where

- Fridays, 10:00 - 11:50am
- 3760 Boelter Hall

## What

- These are mandatory sessions.
- You will have an opportunity to get started on each week's implementation and/or work on your project.

# Homework

- These will be a combination of a computational implementation and other problems.
- Each will help reinforce the material and provide hands-on experience by implementing what we learn in class.
- These are meant to challenge you to become comfortable applying the material.
	- Document your effort
	- Get started early
	- Seek answers to your questions in office hours and lab

# Project

- You will take data from a scientific paper, and implement a machine learning method using best practices.
- A list of papers with is provided on the website as suggestions.
- You may also search out options that would be of interest to you.
- More details to come.
- First deadline will be to pick a project topic.

# Exams

- We will have a midterm exam on week 5.
- You will have a final project in lieu of a final exam.

# Keys to Success

- Participate in an engaged manner with all in-class and take-home activities.
- Turn in assignments on time.
- Work through activities, reading, and problems to ensure your understanding of the material.

If you do these three things, you will do well.

\note[item]{\item First time with class, so interested in calibration
\item If you aren't famiilar with a term, guaranteed we should review}

# Introduction

## How do we need to learn about the world?

- What is a measurement?
- What is a model?

# Three things we need to learn about the world

- Measurements (data)
- Models (inference)
- Algorithms

\note{Distinguish each of these.}

# Area of Focus

What we will cover spans a range of fields:

- Engineering (the data)
- Computational techniques (the algorithms)
- Statistics (the model)

\note[item]{\item Makes this material challenging.
\item Also rewarding, frontier of methods.}

# Why do we need these things to learn about the world?

FILL IN

\note[item]{\item It may not be feasible for humans to learn on the scale / in the time alloted.
\item Model construction serves as goal posts. I.e. a well-specified target we can compare, share, etc.
\item For many tasks, machine learning can perform better than a human would.
}

# Why we need models - Can a biologist fix a radio?

![Lazebnik et al, Cancer Cell, 2002](./lectures/figs/lec1/laz1.jpg)

# Why we need models - Can a biologist fix a radio?

![Lazebnik et al, Cancer Cell, 2002](./lectures/figs/lec1/laz2.jpg)

# Why we need models - Can a biologist fix a radio?

![Lazebnik et al, Cancer Cell, 2002](./lectures/figs/lec1/laz3.png)

# Comparisons

- Multiscale nature
	- Biology operates on many scales
	- Same is true for electronics
	- BUT electronics employ compartmentalization/abstraction to make understandable
- Component-wise understanding
	- Only provides basic characterization
	- Leads to "context-dependent" function

# For many tasks, machine learning can perform better than a human would

![Thompson et al. Proc. 1st Int. Conf. on Evolvable Systems, 1996](./lectures/figs/lec1/fig1.png){height=100%}

# For many tasks, machine learning can perform better than a human would

![Thompson et al. Proc. 1st Int. Conf. on Evolvable Systems, 1996](./lectures/figs/lec1/fig2.png){height=60%}

# For many tasks, machine learning can perform better than a human would

![Thompson et al. Proc. 1st Int. Conf. on Evolvable Systems, 1996](./lectures/figs/lec1/fig3.pdf)

# For many tasks, machine learning can perform better than a human would

![Thompson et al. Proc. 1st Int. Conf. on Evolvable Systems, 1996](./lectures/figs/lec1/fig4.png){height=60%}

# Data

- What is a variable?
- What is an observation?
- What is N?

# Types of variables

- Categorical
- Numerical/continuous
- Ordinal

# Probability

\note[item]{\item Probability indicates the chance of an event given a set of constraints.
\item Also talk about if something is conditionally dependent/independent
\item What is integral?
\item What is limit as dx goes to 0?
}

# Coin toss example

A set of trials: HTHHHTTHHTT

Two possibilities:

- Fair coin
- Biased (Heads 60%, Tails 40%)

\note[item]{\item Run through example.
\item What is the data here?
\item What is the model?
\item What is the algorithm?
\item Walk through each form of probability.
}
<!-- From here on using Kristen's Chapter Two -->

# Distributions

We've already been talking about these! Distributions describe the range of probabilities that exist for all possible outcomes.

\note[item]{\item Can a distribution be categorical? Ordinal? Numerical?
}

# Other Probabilities

Conditional probability
~ The measure of an event given that another event has occured.

Marginal distribution
~ The probability distribution regardless of other observations/factors.

Joint probability
~ In a multivariate probability space, the distribution for more than one variable.

Complementary event
~ The probability of an event not occuring.

\note[item]{\item Plot out a joint probability
\item Also talk about if something is conditionally dependent/independent
}

# Normal Distributions

- $\mu$: center of the distribution
- $\sigma$: standard deviation
- $\sigma^2$: variance

$$f(x)=\frac{1}{\sqrt{2\pi}}\; e^{-\frac{x^2}{2}}$$

![ ](./lectures/figs/lec1/normal_pdf.png){width=60%}

# Normal Distributions

For a *standard* normal distribution ($\mu = 0$, $\sigma = 1$):

$$f(x)=\frac{1}{\sqrt{2\pi}}\; e^{-\frac{x^2}{2}}$$

Area between:

- One standard deviation: 68%
- Two stdev: 95%
- Three stdev: 99.7%

You can normalize any normal distribution to the standard normal.

\note[item]{\item Walk through the equations for normal distribution.
\item Walk through process of Z-scoring.
}

# Other Distributions

Normal Distribution
~ Describes many naturally observed variables and has statistics mean and standard deviation

Exponential Distribution
~ Describes the time between events in Poisson Processes

Poisson
~ Stochastic process that counts # of events in some deltaT time frame

Rayleigh
~ Measure of vector magnitude within orthogonal direction is independent

Gamma
~ Used in Bayesian statistics, often for modeling waiting times

Beta
~ Random variables limited to intervals of finite length (e.g. Allele frequency in population genetics)

Bernoulli
~ From binary Bernoulli trial, like a coin flip, describes the probability of observing a single event on next flip

Binomial
~ Extension of the bernoulli trial, describes the # of successes in a sequence of n-independent binary trials

Multinomial
~ Extension of binomial when variable can take on more than two states.

# Distribution moments

The moments of a distribution describe its shape: $$\mu_{n}=\int_{-\infty}^{\infty}(x-c)^{n}\,f(x)\,\mathrm{d} x$$

First
~ Mean

Second
~ Variance

Third
~ Skewness

Fourth
~ Kurtosis

- Essential properties to determining how a set of data will behave during analysis
	- How might your measurements need to change with changes in variance?
	- What are these values for a normal distribution?

<https://www.che.utah.edu/~tony/course/material/Statistics/12_descriptive.php>

# Sample statistics

If we sampled a number of times ($n=3$, say) many times, we could build a **sampling** distribution of the statistics (e.g. one for the **sample** mean and one for the **sample** standard deviation).

General properties of sampling distributions:

1. The sampling distribution of a statistic often tends to be centered at the value of the population parameter estimated by the statistics
2. The spread of the sampling distributions of many statistics *tends* to grow smaller as sample size $n$ increases
3. As $n$ increases, sampling distributions tends towards normality. If a process has mean $\mu$ and standard deviation $\sigma$, them the sample mean = $\mu$ and the sample standard deviation = $\sigma / \sqrt{n}$

# Sample statistics

- This means that as $n$ increases, the better estimate $\mu_x$ is of $\mu$.
	- Sample standard deviation is the standard deviation of the mean.
- When a population distribution is normal, the sampling distribution of the sample statistic is also normal, regardless of $n$.
- And the central limit theorem states that the sampling distribution can be approximated by a normal distribution when the sample size, $n$, is sufficiently large.
- Rule of thumb is that $n=30$ is sufficiently large, but there are times when smaller $n$ will suffice. More $n$ is required with the higher the skew.

# Hypothesis Testing

In hypothesis testing we state a null hypothesis that we will test and if it’s likelihood is less than some value, then we reject it.

For example:

- Ho: A particular point comes from a normal distribution with mean mu and sigma.
- Ho: Two sets of observations were sampled from distributions with different means.

Relative likelihood of the null hypothesis is the *p-value*.

\note[item]{\item Go over this, drawing out distributions.
\item Go over one sided, two sided tests.
}

# T-distribution

When $n$ is small use the t-distribution with $n-1$ degrees of freedom.

- Ho: Assume $\mu=\mu_0$ then calculate t. $$t = \frac{\overline{x} - \mu_0}{s/\sqrt{n}}$$
	- Can think of t designed to be $z/s$, where it’s sensitive to the magnitude of the difference to the alternate hypothesis and scaled to control for the spread.
- When comparing the differences between two means: (null hypothesis the means are the same, variances/sizes assumed equal). $$t=\frac{{\bar{X}}_1-{\bar{X}}_2}{\sqrt{\frac{s_{X_1}^2+s_{X_2}^2}{n}}}$$

# Effect size

- The scalar factor scales the t-value
	- If using a direct guassian, the estimation of the mean scales with $1 / \sqrt{n}$
	- Then p-values become significant even though the differences in means is small
- Exercise caution and report the effect size
	- For example a 1% difference or a 50% difference in the means

# Kolmogorov-Smirnov Test

- Comparison of an empirical distribution function with the distribution function of the hypothesized distribution.
- Does not depend on the grouping of data.
- Relatively insensitive to outlier points (i.e. distribution tails).

# Kolmogorov-Smirnov Test

- K-S test is most useful when the sample size is small
- Geometric meaning of the test statistic:

![ ](./lectures/figs/lec1/ks.pdf)

# Kolmogorov-Smirnov Test

#### Test statistic:

$$D_n^{+} = \max_{1\leq i\leq n} \left(\frac{i}{n} - \hat{F}(X_{(i)})\right)$$
$$D_n^{-} = \max_{1\leq i\leq n} \left(\hat{F}(X_{(i)} - \frac{i - 1}{n})\right)$$
$$D_n = \max \left( D_n^{+}, D_n^{-} \right)$$

Not expressed in one equation with absolute value because distance is assessed from opposite ends for each.

How is this then converted to a p-value?

# Graphical Analysis

- Plotting a distribution is often more informative than a goodness-of-fit test.
- Not only assesses deviation, but can explain where it occurs.
- Many variants:
	- Q-Q plot
	- P-P plot
	- Histogram with fitted distribution

# Testing errors

- Type I error: error of rejecting Ho when it is true (false positive)
- Type II error: not rejecting Ho when it is false (false negative)
- Alpha: significance level in the long run $H_0$ would be rejected this amount of the time falsely. (i.e. We are willing to accept $x$ in 100 false positives.)

Beware of goodness-of-fit tests because they are unlikely to reject *any* distribution with little data, and are very sensitive to the smallest systematic error with lots of data.

# Multiple hypotheses

We want to test whether the gene expression between two cells differs greater than chance alone. We test the two samples with a p-value cutoff of 0.05:

- How many false positives would we expect after testing 20 genes?
- How about 1000 genes?

What about false negatives?

What does this mean when it comes to hypothesis testing?


# Further Reading

- [Computer Age Statistical Inference, Chapters 1 and 2](https://web.stanford.edu/~hastie/CASI_files/PDF/casi.pdf)
- [`scipy.stats`](https://docs.scipy.org/doc/scipy/reference/stats.html)

\note{Neagle, Chapter 2}