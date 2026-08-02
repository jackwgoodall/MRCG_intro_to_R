# ------------------------------
# - Week three homework --------
# ------------------------------

# This week was about getting to know a dataset before you trust it
# The order of these questions matters - Q5 depends on what you do in Q3 and Q4
# so work through them in order

# Question 1
# Load the tidyverse, then read the iris data into an object called `iris`
# Check how many rows and columns it has
# ----------------------------------------
library( )

iris <-

# ----------------------------------------

# Question 2
# Find the mean, the median and the range of `Petal.Length`
# Write the mean and median down on the comment lines - we are coming back to
# them in Question 5
# ----------------------------------------


# Mean =                                  <--- write your answer here

# Median =                                <--- write your answer here
# ----------------------------------------

# Question 3
# `summary()` is not much use on a character column
# Use `unique()` or `table()` on `Species` to see what values are actually in there
# There is a mistake. Find it, then correct it
# ----------------------------------------


# ----------------------------------------

# Question 4
# Now plot `Petal.Length` on its own, and then as a boxplot
# One value is obviously wrong (an iris petal is not that long!)
# We cannot go back and check the original measurement, so the honest thing is
# to set it to NA rather than guess at what it should have been
# Do that, and leave a dated comment above it saying what you did and why -
# just like the one in the session sheet
# ----------------------------------------


# ----------------------------------------

# Question 5
# Now find the mean and median of `Petal.Length` again
# (Careful - this will not work the way it did in Question 2 any more. If you
# get NA back, look up the `na.rm` argument)
# ----------------------------------------


# New mean =                              <--- write your answer here

# New median =                            <--- write your answer here

# Which of the two moved more when you removed that one bad value?
# Why do you think that is?
#                                         <--- write your answer here
# ----------------------------------------

# Question 6
# Using `filter()`, how many setosa flowers have a `Sepal.Width` greater than 3.5?
# (Remember `==` for "is equal to", and `&` for "and")
# ----------------------------------------


# How many:                               <--- write your answer here
# ----------------------------------------

# Question 7
# Use `group_by()` and `summarise()` to make a small table with one row per
# species, showing:
# - the mean petal length
# - the number of flowers
# Save it as `iris_summary`
# One species should have a slightly smaller count of usable measurements than
# the others - can you see why?
# ----------------------------------------
iris_summary <- iris |>


# ----------------------------------------

# Question 8
# Use `mutate()` to add a new column `Sepal.Area`, which is `Sepal.Length`
# multiplied by `Sepal.Width`
# Move it so that it sits just after `Sepal.Width` (hint: `relocate()`)
# Then `arrange()` the whole dataset so the largest sepal area is at the top
# Which species takes most of the top ten places?
# ----------------------------------------


# Which species:                          <--- write your answer here
# ----------------------------------------

# Question 9
# Give each flower a unique id with `mutate(flower_id = row_number())`
# Then pivot the four measurement columns into long format, so each flower has
# four rows - one per measurement
# Then pivot it straight back into wide format
# Did you get back exactly what you started with? Check rather than assume
# ----------------------------------------
iris_id <- iris |>

iris_long <- iris_id |>

iris_wide <- iris_long |>

# ----------------------------------------

# Question 10
# A tricky one to end with!
# Here is a small reference table. Note it is missing one of our species, and
# includes one we do not have any flowers for:

species_info <- tibble(
  Species = c("setosa", "virginica", "sibirica"),
  Common_Name = c("Bristle-pointed Iris", "Virginia Iris", "Siberian Iris"),
  Native_Climate = c("Subarctic", "Subtropical", "Subarctic")
)

# BEFORE you write any code, predict how many rows you will get from each join
# of `iris` and `species_info`. Write your predictions here:

# left_join  rows =                       <--- predict first
# right_join rows =                       <--- predict first
# inner_join rows =                       <--- predict first
# full_join  rows =                       <--- predict first

# Now run all four and check
# ----------------------------------------


# ----------------------------------------

# Were any of your predictions wrong? Which join surprised you, and why?
#                                         <--- write your answer here
# ----------------------------------------

# One last thought:
# If you were joining real study data - say lab results onto a participant list -
# which of these four joins would quietly lose you participants, and which would
# quietly invent rows for people you never recruited?
#                                         <--- write your answer here
# ----------------------------------------
