## Linear regression ----------

# Correlation says "these move together"
# Regression says "how much does y change per unit of x" - and lets you add
# more than one explanatory variable

iris_lm <- lm(Petal.Length ~ Sepal.Length, data = iris)

summary(iris_lm)

# In the Coefficients table:
#   (Intercept)    = predicted petal length when sepal length is 0 (often meaningless)
#   Sepal.Length   = petal length changes by this much per 1 cm of sepal length
#   Pr(>|t|)       = p-value for that slope being zero
#   R-squared      = proportion of the variation in y explained by the model

# We can add species as well - note it is a factor, so R makes setosa (the first
# level) the baseline and reports the others *relative to it*
iris_lm2 <- lm(Petal.Length ~ Sepal.Length + Species, data = iris)

summary(iris_lm2)

# And ggplot will draw the simple version for you
ggplot(iris, aes(x = Sepal.Length, y = Petal.Length)) +
  geom_point() +
  geom_smooth(method = "lm")

# Try that last plot with colour = Species inside the aes() - what happens to
# the number of lines, and why?
# ----------------------------------------


# ----------------------------------------


## Getting the numbers back out ----------

# Printing a test to the console is fine for looking at
# But for a report you want the numbers themselves

my_test <- t.test(Sepal.Length ~ Species, data = two_species)

# It is just a list - so $ works exactly as it did in week 2
my_test$p.value
my_test$conf.int
my_test$estimate

# What else is in there?
names(my_test)

# Neater still: the `broom` package turns any test into a tidy one-row dataframe
# install.packages("broom")
library(broom)

tidy(my_test)

# This works on almost everything, and the output is a dataframe - so it goes
# straight into the tidyverse tools from week 3
tidy(iris_lm)

tidy(iris_aov)

# Which means you can do things like this:
tidy(iris_lm) |>
  filter(p.value < 0.05) |>
  select(term, estimate, p.value)
