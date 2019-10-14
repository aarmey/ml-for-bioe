---
title: Final Project Guidelines
layout: page
---

## Choosing A Topic

In this project, you have two options for the general route you can take:

1. As a first option, you may select a bioengineering paper that implements a computational analysis we have learned about from the literature. You will reimplement this analysis with thorough testing and documentation. In your final report, you should include a discussion about any elements that presented a challenge during your reimplementation, or discrepancies you found. Lastly, you should identify a creative extension of the analysis and implement it.
2. Alternatively, you may identify a set of data and corresponding analysis that has not yet been performed. This can be more exploratory in nature. You will implement this analysis with testing and documentation. In your final report, you should discuss whether/how the type of data influenced the analysis that was possible, the findings and limitations of your analysis, and what might be ways to validate your findings.

Some papers with material of potential interest are listed [here](#final-project-source-ideas). For example, a few project ideas:

Exploratory:
- Using the kinetic binding measurements and activities measured in [Jaks et al](http://doi.org/10.1016/j.jmb.2006.11.053), use PCA to describe the differences between interferons, and PLSR to predict how binding relates to activity.
- Using the kinetic binding measurements and activities measured in [Jaks et al](http://doi.org/10.1016/j.jmb.2006.11.053), build an ODE model of receptor-ligand interaction. Based on the conclusions of the authors, predict how cells with different amounts of receptor would respond.

Reimplementation:
- Reimplement the quantitation for mutation rate from the number of stop codons in [Cuevas et al](http://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1002251#pbio.1002251.s011). Using either a Bayesian or frequentest approach, estimate the specificity of each mutation rate estimate.
- Reimplement the ODE model from [Kellogg et al](http://www.sciencedirect.com/science/article/pii/S2211124717303595?via%3Dihub). Propose an approach to fit the model to data, given the high degree of cell-cell variation.

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
- Jensen, K. J., Moyer, C. B., & Janes, K. A. (2016). [Network Architecture Predisposes an Enzyme to Either Pharmacologic or Genetic Targeting](http://doi.org/10.1016/j.cels.2016.01.012). Cell Systems, 2(2), 112–121. 
- Tsherniak et al. (2017). [Defining a Cancer Dependency Map](http://www.sciencedirect.com/science/article/pii/S0092867417306517). Cell, 170(3), 564-576.
- Hill et al. (2017). [Context Specificity in Causal Signaling Networks Revealed by Phosphoprotein Profiling](http://www.sciencedirect.com/science/article/pii/S2405471216304082). Cell Systems, 4(1), 73-83.
- Lun et al. (2019). [Analysis of the Human Kinome and Phosphatome by Mass Cytometry Reveals Overexpression-Induced Effects on Cancer-Related Signaling](https://www.sciencedirect.com/science/article/pii/S1097276519303132). Molecular Cell, 74(5), 1086–1102.
