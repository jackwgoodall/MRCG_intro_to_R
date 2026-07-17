# MRCG Intro to R for Statistics

## Who is this for?

This is an introductory course on how to use the [R programming language](https://www.r-project.org/). 

It is aimed at anyone who has either never used R before or considers themselves a beginner. As the course goes on the topics get more complicated and specialised. Those who consider themselves already proficient may wish to join for some of these later sessions.

Although there will be some refreshers on basic statistical concepts, this course is about R, *not* statistics. 

## Why use R?

R is an incredibly powerful data analysis tool.  Almost any analysis you can dream up can be performed using R. It will do everything from identifying missing data to performing advance machine learning. You can easily create tables and publication ready figures, with far more flexibility and customisation than you could with more standard tools.

R is open source and widely used. The scripts you create to perform your analyses document clearly the steps and decisions you have made. This makes it easy to collaborate on analyses, trace back where any mistakes may have occurred, and ultimately to publish the fruits of your labour. Many journals now insist on you sharing you analysis code; this is good both for transparency and for the advancement of science. 

## The structure

This will be a 10 week course starting with the basics and working up to regression models and advanced figure creation.

We will meet once a week for 60-90 minutes where we will work through some interactive teaching together. Each week there will be some exercises to complete after the session to consolidate you learning. These should take you no more than 1 hour to work through (and often will be much quicker).  I will send round the my answers to these each week and we will use the first ten minutes of each session to cover any issues that came up.

The course will be dynamically structured around the needs and proficiency of those who attend, however a rough outline is provided below.

The confirmed plan for the next two weeks will be show on my GitHub page, along with the answers to the previous homework exercises: [here](https://github.com/jackwgoodall/MRCG_intro_to_R).

### Week 1: Introduction

-   A guided tour of R studio and how to customise it

-   Object types and why you would use them

    -   Vectors

    -   Matrices

    -   Dataframes

    -   Lists
- Selecting, changing items in base R

-   Introduction to markdown (we will use this throughout for the homework)

### Week 2: How to get data into R

- Accessing data 

    -   Importing for excel/csv

    -   Creating 'synthetic data' (and why you might want to do this...)

-   Basic tools for data cleaning

    -   Data summarise

    -   Basic visualisations for outliers

    -   Correcting errors safely

### Week 3: R packages and the tidyverse

-   Installing and version controlling packages (introduction to CRAN and `pacman::p_load()`)
-   Introduction to the tidyverse
  -   The power of the pipe `(|> / %>%)` and why it helps makes code readable
  -   The core dplyr verbs: `filter`, `select`, `mutate`, `arrange`, `summarise`, `group_by`
  -   The concept of tidy data (one variable per column, one observation per row)
  -   Reshaping with `pivot_longer` / `pivot_wider`
  -   Joining tables with `left_join` (research data almost always spans multiple files)
  -   Handling categorical variables with factors (forcats)

### Week 4: Visualisation with ggplot2

-   The grammar of graphics: data → aesthetics → geoms
-   Common "geoms" (point, line, histogram, boxplot) and mapping colour/fill/group
-   Faceting for subgroups Scales, labels, and themes to get to publication-ready
-   `ggsave()` with sensible dimensions/DPI for journal submission

### Week 5: Basic statistical analysis

-   Using tables, summaries and visualisation to check we are doing the right analysis
-   T-test
-   Chi-squared test
-   Alternatives

### Week 6: Consolidation and a gentle introduction to functions 

- Recap and catch-up on weeks 1–5  
- Control the flow: if/else Iteration: for loops, then `across()` / `purrr::map()` as the tidy alternative 
- Writing your own functions (the DRY principle: don't repeat yourself) 
- A short combined practical: import → clean → plot, end-to-end

### Week 7: Linear regression

- `lm()` and formula syntax (y \~ x1 + x2) 
  - Interpreting coefficients, confidence intervals, and p-values 
- Categorical predictors and a first look at interactions 
- Assumptions and diagnostics via residual plots 
- Tidy output with broom (`tidy`, `glance`, `augment`) and `gtsummary::tbl_regression()` for a clean results table

### Week 8: Logistic regression & GLMs

- Binary outcomes with `glm(..., family = binomial)` 
- Odds ratios and how to interpret them (exponentiating coefficients)
- A second GLM — Poisson for counts/rates, with offsets

### Week 9: Extending the model (we'll take a vote closer to the time)

**Option A:** Survival analysis (`survival`, `survminer`): Kaplan–Meier curves, the log-rank test, and an intro to Cox proportional hazards.

**Option B:** Multilevel / mixed models (`lme4`): a gentle intro to clustered or repeated data (random intercepts).

### Week 10: Reproducible reporting & mini-project

- Quarto (a markdown engine) in more depth: parameters, cross-references, figures and tables in one document 
- RStudio Projects and `here()` for portable file paths; sensible folder structure 
- Reproducibility: `sessionInfo()`, and a first look at git/GitHub for version control 
- A small end-to-end capstone (import → clean → visualise → model → render a report)


# Weekly Timetable 

| Session | Date | Materials | Homework | Answers | 
| ------- | ---- | ---- | ---- | ---- | 
| Introduction | TBC | - | - | - | 
| How to get data into R | TBC | - | - | - | 
