# ------------------------------
# - Week six homework ----------
# ------------------------------

# This week was reshaping data (pivot_longer / pivot_wider) and joining
# datasets together (left, right, inner and full joins)

# Everything you need is made below, so there is nothing to download

library(tidyverse)

# `labs` holds haemoglobin (g/dL) for four children, measured on three days of
# a small iron-supplementation trial. It is in "wide" format: one row per child,
# one column per visit.
labs <- data.frame(
  patient  = c("P01", "P02", "P03", "P04"),
  hb_day0  = c(9.2, 10.1, 8.4, 11.0),
  hb_day7  = c(10.0, 10.5, 9.1, 11.2),
  hb_day14 = c(11.1, 10.8, 10.2, 11.3)
)

# `patient_info` is a separate lookup table with each child's trial arm and
# area Look carefully - it is NOT quite the same list of children as `labs`.
patient_info <- data.frame(
  patient = c("P01", "P02", "P03", "P05"),
  arm     = c("Iron", "Placebo", "Iron", "Placebo"),
  area = c("Keneba", "Fajara", "Keneba", "Basse")
)

# Have a look at both before you start
labs
patient_info

# Question 1
# `labs` is in wide format. Use pivot_longer() to make a long version where:
# - the three hb_day columns are gathered into one column called `visit`
# - their numbers go into one column called `hb`
# Save the result as `labs_long`
# ----------------------------------------
labs_long <- labs |>
  pivot_longer( )

# ----------------------------------------

# Question 2
# How many rows does `labs_long` have now, and how many did `labs` have?
# Why has the number changed?
# ----------------------------------------


# Rows before:                            <--- write your answer here
# Rows after:                             <--- write your answer here
# Why:                                    <--- write your answer here
# ----------------------------------------

# Question 3
# Long data is well suited to plotting
# Using `labs_long`, make a boxplot with `visit` on the x axis and `hb` on
# the y axis
# Give it a title and a sensible y axis label (haemoglobin is in g/dL)
# ----------------------------------------


# ----------------------------------------

# Question 4
# Now turn `labs_long` back into the original wide shape with pivot_wider()
# (the column names come from `visit`, the values from `hb`)
# Save it as `labs_wide`
# Does it match the `labs` you started with?
# ----------------------------------------
labs_wide <- labs_long |>
  pivot_wider( )

# ----------------------------------------

# Question 5
# Now we want to attach the trial arm and area onto the lab results
# BEFORE you write any code, look at `labs` and `patient_info` and predict how
# many rows each of the four joins will return. Write your predictions here:

# left_join(labs, patient_info)  rows =   <--- predict first
# right_join(labs, patient_info) rows =   <--- predict first
# inner_join(labs, patient_info) rows =   <--- predict first
# full_join(labs, patient_info)  rows =   <--- predict first
# ----------------------------------------


# ----------------------------------------

# Question 6
# Run a left_join() of `labs` and `patient_info`, matching on `patient`
# How many rows do you get?
# One child has NA for arm and area. Which one, and why?
# ----------------------------------------


#                                         <--- write your answer here
# ----------------------------------------

# Question 7
# Now a right_join() of the same two tables
# How many rows this time? Which child now has NAs, and in which columns?
# ----------------------------------------


#                                         <--- write your answer here
# ----------------------------------------

# Question 8
# Now an inner_join()
# How many rows? Which children have been dropped, and why?
# ----------------------------------------


#                                         <--- write your answer here
# ----------------------------------------

# Question 9
# Finally a full_join()
# How many rows? Were any of your predictions in Question 5 wrong?
# ----------------------------------------


#                                         <--- write your answer here
# ----------------------------------------

# Question 10
# A tricky one to end with!
# Build one chain that does all of this in order:
# - starts with `labs`
# - inner_join()s `patient_info` onto it (so every child has a trial arm)
# - pivot_longer()s the three hb_day columns into `visit` and `hb`
# - plots a boxplot of `hb` by `visit`, filled by `arm`
# ----------------------------------------


# ----------------------------------------

# One last thought:
# If this were real trial data, which of the four joins would quietly LOSE a
# participant, and which would quietly INVENT a row for a participant who has no
# lab results? Why does it matter which one you reach for?
#                                         <--- write your answer here
# ----------------------------------------
