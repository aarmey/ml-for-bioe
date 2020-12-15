---
title: Final Project Guidelines
layout: page
---

## Choosing A Topic

In this project, you have two options for the general route you can take:

1. As a first option, you may select a bioengineering paper that implements a computational analysis we have learned about from the literature. You will reimplement this analysis with thorough testing and documentation. In your final report, you should include a discussion about any elements that presented a challenge during your reimplementation, or discrepancies you found. Lastly, you should identify a creative extension of the analysis and implement it.
2. Alternatively, you may identify a set of data and corresponding analysis that has not yet been performed. This can be more exploratory in nature. You will implement this analysis with testing and documentation. In your final report, you should discuss whether/how the type of data influenced the analysis that was possible, the findings and limitations of your analysis, and what might be ways to validate your findings.

Some repositories with potential datasets are listed [below](#final-project-source-ideas). Here are also a few project ideas from the literature:

- Reimplement analysis in [Sanford et al](https://elifesciences.org/articles/59388), or explore using PCA with (favoring multiplicative effects) or without (favoring additive effects) log-transformed data.
- Build a model predicting latent or active Tb infection from antibody measurements in [Lu et al](https://dx.doi.org/10.1016%2Fj.cell.2016.08.072).
- Explore the measurements in [Boudreau et al](https://www.jci.org/articles/view/129520) by PCA.
- Build a model that predicts antibody effectiveness against Ebola from measurements in [Saphire et al](https://www.nature.com/articles/s41590-018-0233-9).
- Build and interpret a model predicting vaccine effectiveness from [Chung et al](https://stm.sciencemag.org/content/6/228/228ra38.full).

There are no restrictions on the programming language or packages you use. While this is expected to be an individual project by default, we will consider up to four person teams so long as this is reflected by the scope of the project. If in a team, your proposal, final project, and final presentation should cover how the project was divided.

## Proposal

The proposal should be less than two pages and describe the following items:

- Why the topic you chose is interesting
- Demonstrate that your project fits the criteria above
- What overall approach do you plan to take for the project and why
- Demonstrate that your project can be finished within a month
- Estimate the difficulty of your project

**We are available to discuss your ideas whenever you are ready, and you should discuss your idea with us prior to submitting your proposal.** By the time you submit your proposal you should ensure that you have access to the requisite data. We are happy to help you with this.

## Final Report

Your final report should be less than 1500 words and describe the following items:

- Introduction/Motivation: Why the topic you choose is interesting, and whether similar work has been done by others (novelty will not affect your grade, but it is always good to know if other people are doing the same thing)
- Problem definition: How to formulate your topic/question into a data analytics problem, and how does it relate to a broader challenge engineering a biological system
- Methods
    - Description of the algorithm you employed or designed
    - The software package you chose or your own implementation of the algorithm
    - How to use the software package or your own code
    - (Optional) Charting and/or visualization that help make decisions in your analysis
- Results
    - Quantitative evaluation of your method
    - Charting and/or visualization of your results
    - How your proposed approach has solved your question

Accompanying your final report should be a git repository of your analysis.

## Final Presentation

Each presentation will have 8 minutes:
- 6 minutes for a presentation
- 2 minutes for questions, discussion, and transition to the next presenter

Each team should prepare no more than 7 slides, including the title slide, and cover the sections listed in the final report.

## Grading

Your project will be evaluated 

- Proposal (15%)
- Final Report (40%)
- Final Presentation (15%)
- Code and Implementation (30%)

## Final Project Source Ideas

- Many interesting datasets are listed in the [UC Irvine Machine Learning Repository](http://archive.ics.uci.edu/ml/).
- Machine learning competitions, such as the [DREAM Challenges](http://dreamchallenges.org), [Kaggle](https://www.kaggle.com), and [DrivenData](https://www.drivendata.org), may have relevant challenges and pre-assembled datasets.
