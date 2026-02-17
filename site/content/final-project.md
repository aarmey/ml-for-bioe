---
title: 'Final Project Guidelines'
---

## Choosing A Topic

In this project, you have two options for the general route you can take:

1. As a first option, you may select a bioengineering paper that implements a computational analysis we have learned about from the literature. You will reimplement this analysis with testing and documentation. In your final report, you should include a discussion about any elements that presented a challenge during your reimplementation, or discrepancies you found. Lastly, you should identify a creative extension of the analysis and implement it.
2. Alternatively, you may identify a dataset and corresponding analysis that has not yet been performed. This can be more exploratory in nature. You will implement this analysis with testing and documentation. In your final report, you should discuss whether/how the type of data influenced the analysis that was possible, the findings and limitations of your analysis, and what might be ways to validate your findings. Some repositories with potential datasets are listed [below](#final-project-source-ideas).

There are no restrictions on the programming language or packages you use. Projects should consist of teams of four or five students. Your proposal, final project, and final presentation will be jointly submitted and should cover how the project was divided.

## Proposal

The proposal should be one page in length and explain the following:

- Why the topic you chose is interesting and solves a bioengineering-related challenge
- How your project fits one of the two topic criteria listed above
- What overall approach do you plan to take for the project and why
- How your project can be finished within a month
- The difficulty of your project
- The expected outcomes of your analysis
- How the project will be split up among your team members

**We are available to discuss your ideas whenever you are ready, and you should discuss your idea with us prior to submitting your proposal.** By the time you submit your proposal you should ensure that you have access to the requisite data. We are happy to help you with this.

## Grade Breakdown

- Proposal (15%)
- Final Report (40%)
- Final Presentation (25%)
- Code and Implementation (20%)

## Final Report

Your final report should be less than 1500 words and describe the following items:

- Introduction/Motivation:
    - Why the topic you choose is interesting
    - Whether similar work has been done by others (novelty will not affect your grade, but it is always good to know if other people are doing the same thing)
- Problem definition
    - How to formulate your topic/question into a data analytics problem
    - How does it relate to a broader biomedical challenge
- Methods
    - Description of the algorithm you employed or designed
    - The software package you chose or your own implementation of the algorithm
    - How to use the software package or your own code
    - (Optional) Charting and/or visualization that help make decisions in your analysis
- Results
    - Quantitative evaluation of your method
    - Charting and/or visualization of your results
    - How your proposed approach has solved your question

## Final Presentation

Each presentation will have 10 minutes:
- 8 minutes for a presentation
- 2 minutes for questions, discussion, and transition to the next presenter

Each team should prepare no more than 8 slides, excluding the title slide, and cover the sections listed in the final report. Your final presentation does not need to include a final version of your results. You should focus on the motivation, problem definition, and methods. You can include preliminary results if you have them, but this is not required. The presentation should be designed to be accessible to a general audience of bioengineers, so avoid technical jargon and focus on the big picture.

You will be evaluated based on the following criteria:
- Clarity of the motivation and problem definition
- Clarity of the methods and how they relate to the problem definition
- How effectively the presentation follows good presentation practices (e.g. clear slides, engaging delivery, etc.)
- Ability to answer questions and engage in discussion

## Code and Implementation

To ensure your project is professional, reproducible, and easy to navigate, start by establishing a clear development workflow. Use notebooks for your initial exploration and prototyping, but transition your final, polished logic into structured Python scripts or packages. While not strictly required, using version control like GitHub is highly recommended to track changes, facilitate team collaboration, and document your development journey over time.

A logical directory structure is essential for keeping your project organized. By separating your concerns, you make it much easier for others (and your future self) to understand the project's flow. Your project should follow a structure similar to this:

* **Code/**: Final scripts and packages.
* **Data/**: Raw and processed datasets.
* **Results/**: Output files, figures, and analysis reports.
* **Tests/**: Unit and integration tests.
* **Notebooks/**: Exploratory work and prototyping.

### Documentation and Quality

Your code must be transparent and well-documented. Each function should include a docstring that clearly defines its purpose, inputs, and outputs. Beyond function-level documentation, use inline comments to explain the "why" behind complex logic blocks, ensuring the code is readable. The centerpiece of your documentation will be the README file. This document should provide a high-level overview of the project, explain the organizational structure, and offer explicit instructions on how to install dependencies and run the code.

### Validation and Collaboration

No project is complete without verification. You are required to include testing—whether via unit tests for individual functions or integration tests for the entire workflow—to prove your code performs as expected. Finally, remember that this is a collective effort. Your submission must include a description of how the programming work was distributed among team members, ensuring everyone played a distinct role in the analysis. When you are ready, package everything into a single zip archive for submission via Bruin Learn.

## Final Project Source Ideas

- Many interesting datasets are listed in the [UC Irvine Machine Learning Repository](https://archive.ics.uci.edu).
- Machine learning competitions, such as the [DREAM Challenges](https://dreamchallenges.org), [Kaggle](https://www.kaggle.com), and [DrivenData](https://www.drivendata.org), may have relevant challenges and pre-assembled datasets.
- You are welcome to use a dataset from your own research. There is no problem keeping the data confidential, and this does not create any issues related to authorship. If you chose to do so, you should chose a new analysis approach that has not yet been performed.
