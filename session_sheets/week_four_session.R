# -----------------------------------
# Introduction to R - Week 4 --------
# -----------------------------------

# ----------------------------------------
## Part 1 - basis statistical analysis ---
# ----------------------------------------

# Reminder this is *not a stats course* - there are some useful links in the
# `Resources` page of the website if you need a refresher on these

# We have already looked at plotting and summarising data which is always step one

# The good news: nearly every test in R follows the same shape
#   test_name(what_you_are_testing, data = your_data, ...options...)
# and nearly every one gives you back an object you can pull numbers out of
# So once you can read one, you can read most of them

# We are still using the iris dataset (and we need to correct that name again)
iris <- read_csv("data/iris.csv") 
iris$Species[iris$Species %in% c('Setosi')] <- 'setosa'
iris$Petal.Length[iris$Petal.Length == '69'] <- NA

# --------------------------------------------------
## Before we start - characters vs factors ---------
# --------------------------------------------------

# `read_csv()` gives us Species as a character (chr)
str(iris$Species)

# Most stats functions want a *factor* - a character where R also knows the full
# list of allowed values ("levels")
# Some functions convert quietly for you; others throw confusing errors
# Save yourself the pain and convert up front:

iris$Species <- factor(iris$Species)

str(iris$Species)   # now "Factor w/ 3 levels"
levels(iris$Species)

# Note the levels are in alphabetical order - this matters later, because R
# treats the *first* level as the reference/baseline group


## T-test -----

# A t-test asks: are these means far enough apart that chance is an unconvincing
# explanation? It comes in three flavours

## ---- Flavour 1: one sample ----
# "Is this mean different from some specific number?"
# Eg is the mean sepal length different from 5.5 cm?

t.test(iris$Sepal.Length, mu = 5.5)

# Read the output from the bottom up - it's much easier that way:
#   `mean of x`     = what you actually measured
#   `95 percent confidence interval` = the plausible range for the true mean
#   `p-value`       = how surprising this result would be if mu really were 5.5
#   `t` and `df`    = the machinery that produced the p-value

# Try it with mu = 5.84 and see what changes
# ----------------------------------------


# ----------------------------------------


## ---- Flavour 2: two independent samples ----
# "Do these two *separate* groups have different means?"
# We only have two groups to compare, so we need to drop one species first

two_species <- iris |>
  filter(Species %in% c("setosa", "versicolor"))

# CAREFUL - a very common error lives here
# `filter()` removes the rows, but the factor still remembers virginica exists
levels(two_species$Species)   # still three....

# `droplevels()` forgets the empty ones
two_species <- droplevels(two_species)
levels(two_species$Species)   # now two

# Without that you get: "grouping factor must have exactly 2 levels"

# The ~ ("tilde") means "explained by" - read it as
# "sepal length explained by species"
t.test(Sepal.Length ~ Species, data = two_species)

# You can also write it with two vectors instead, which is sometimes easier
t.test(x = iris$Sepal.Length[iris$Species == "setosa"],
       y = iris$Sepal.Length[iris$Species == "versicolor"])

# Same answer, two ways of asking


## ---- Variation: Welch's vs Student's ----
# Look at the output above - it says "Welch Two Sample t-test"
# Welch's version does *not* assume the two groups have equal variance
# R does this by default (which seems like a good idea to me)

# You can ask for the classic Student's version, which does assume equal variance:
t.test(Sepal.Length ~ Species, data = two_species, var.equal = TRUE)

# Compare the two - the df is the giveaway (Welch's is usually not a whole number)

# You can formally test whether the variances differ 
# (see how this different stats test is basically the same setup 
# with a different function name at the start)
var.test(Sepal.Length ~ Species, data = two_species)

# In practice: just leave Welch's on unless you have a good reason not to


## ---- Variation: one-sided vs two-sided ----
# By default R tests "is there *any* difference" (two-sided)
# If you have a directional hypothesis you can say so
# "alternative" refers to the *first* group relative to the second

t.test(Sepal.Length ~ Species, data = two_species, alternative = "less")

# Note the confidence interval now runs off to -Inf, and the p-value halves
# Only use this if you decided the direction *before* looking at the data


## ---- Flavour 3: paired ----
# "Do these two measurements on the *same* subjects differ?"
# Eg before/after, left eye/right eye, two drugs in the same patient

# We need a new dataset - `sleep` is bundled with R and is the original dataset
# William Gossett (aka Student) used in 1908. Extra hours of sleep on two different 
#drugs, 10 patients, each patient tried both
# Here `extra` is how many extra hours of sleep they got with each drug
# `group` is which drug is being measured 
# ID is the participant ID

sleep

# We need to transform this data so we have the effect of each drug as its own column

sleep_wide <- sleep %>%
  pivot_wider(values_from = extra,
              names_from = group)

colnames(sleep_wide) <- c("ID", "drug_1", "drug_2")

# We now need to add "paired = TRUE" to tell R this is a paried t-test
t.test(sleep_wide$drug_1, sleep_wide$drug_2, data = sleep_wide, paired = TRUE)

# Compare with pretending they are unrelated people:
t.test(sleep_wide$drug_1, sleep_wide$drug_2, data = sleep_wide, paired = FALSE)

# Same numbers, very different p-value - pairing removes the variation
# *between* patients and looks only at the change *within* each one

# WARNING: paired = TRUE just lines the rows up in the order they appear
# It does not check the IDs match. Sort your data first and check it


## Non-parametric alternatives ----------

# t-tests assume roughly normally distributed data
# When that looks doubtful, the rank-based equivalents ask about medians instead

# Always look first:
hist(iris$Sepal.Length)

ggplot(iris) +
  geom_qq(aes(sample = Sepal.Length)) +
  geom_qq_line(aes(sample = Sepal.Length))

# A qq plot puts your data against what perfect normality would look like -
# points on the line = normal-ish. Trust your eyes over any single test here

# There is also a formal test, but it is over-sensitive in big samples and
# under-sensitive in small ones, which is precisely backwards of what we want... 
shapiro.test(iris$Sepal.Length)

# The Wilcoxon rank-sum test (aka Mann-Whitney U) replaces the two-sample t-test
wilcox.test(Sepal.Length ~ Species, data = two_species)

# And the signed-rank version replaces the paired t-test
wilcox.test(sleep_wide$drug_1, sleep_wide$drug_2, data = sleep, paired = TRUE)

# You will often see: "cannot compute exact p-value with ties"
# That is a note, not an error - it just means it used an approximation because
# some values are identical

## More than two groups: ANOVA ----------

# A t-test only ever compares two groups
# Running one for every pair is a bad idea - each test gets its own chance to
# throw up a false positive, so with enough tests you are almost guaranteed one
# ANOVA asks a single question instead: "is *any* group different?"

# Note aov() wants the factor we made earlier
iris_aov <- aov(Sepal.Length ~ Species, data = iris)

# aov() on its own prints very little - summary() is where the answer lives
summary(iris_aov)

# `Pr(>F)` is your p-value. A small one says "at least one group differs" -
# but it does not say *which*, which is rarely what you actually wanted to know

# Tukey's test does all the pairwise comparisons and corrects for having done so
TukeyHSD(iris_aov)

# `p adj` is the adjusted p-value. `lwr` and `upr` are the confidence interval
# for that difference - if it crosses zero, the difference is not convincing

plot(TukeyHSD(iris_aov))

# Run an ANOVA for Petal.Width across the three species
# ----------------------------------------


# ----------------------------------------


## The non-parametric version: Kruskal-Wallis ----------

kruskal.test(Sepal.Length ~ Species, data = iris)

# Same idea as ANOVA, based on ranks


## Categorical data: chi-squared ----------

# So far everything has had a number as the outcome
# For counts in categories we want a different test

# We need a dataset with two categorical variables - `mtcars` is bundled with R
# am = transmission (0 automatic, 1 manual), cyl = number of cylinders

mtcars_tab <- table(mtcars$am, mtcars$cyl)
mtcars_tab

# Always eyeball the table before testing it
chisq.test(mtcars_tab)

# You should get: "Chi-squared approximation may be incorrect"
# This is a real warning worth heeding - chi-squared is unreliable when the
# *expected* counts are small (a controversial rule of thumb is any expected count under 5)

# You can see the expected counts hiding inside the result object:
chisq.test(mtcars_tab)$expected


# For a 2x2 table you would also meet Yates' continuity correction, which R
# applies automatically - turn it off with correct = FALSE


## Correlation ----------

# "Do these two continuous variables move together?"

ggplot(iris) +
  geom_point(aes(x = Sepal.Length, y = Petal.Length))

# Note: cor() gives you just the number, cor.test() gives you the whole test
cor(x = iris$Sepal.Length, y = iris$Petal.Length, use = "complete.obs") # use = "complete.obs" is needed here
                                                                        # as we have so NA values
                                                                        # this tells R to calculate the correlation
                                                                        # from the ones we do have

cor.test(iris$Sepal.Length, iris$Petal.Length)

# The default is Pearson, which measures *straight line* association
# Spearman ranks the data first, so it picks up any consistently increasing
# relationship even if it is non-linear
cor.test(iris$Sepal.Length, iris$Petal.Length, method = "spearman", exact = FALSE) # exact = FALSE is needed here as 
                                                                                   # we have ties in the data

# Correlation runs from -1 to +1. Zero means no *linear* relationship - it does
# not mean no relationship at all, which is why you plot it first


## A closing warning ----------

# R will run any test you ask it to, on any data, without complaint
# It has no idea whether the test suits your question or your data
# The code was never the hard part. 
