# ------------------------------
# - Week five homework ---------
# ------------------------------

# Everything this week is ggplot2
# Remember the "steps" from the session:
# 1. prepare your data, 2. add the data, 3. format the labels, 4. format the plot
# The userguide is your friend: https://ggplot2.tidyverse.org/articles/ggplot2.html

library(tidyverse)

# We are using the `air` dataset - air quality measurements taken in New York,
# one row per day across the summer of 1973
# Download it from the week 5 Data column on the timetable and save it in your
# `data` folder, then import it here:
air <- read_csv(file = "data/air.csv")

# The columns are:
#   Ozone    - ozone concentration, in parts per billion (ppb)
#   Solar.R  - solar radiation, in Langleys
#   Wind     - wind speed, in miles per hour
#   Temp     - temperature, in degrees Fahrenheit
#   Month    - month, from 5 (May) to 9 (September)
#   Day      - day of the month

# Have a quick look before you start
str(air)

# Question 1
# Make a scatter plot of `Temp` on the x axis and `Wind` on the y axis
# ----------------------------------------
ggplot(data = air) +

# ----------------------------------------

# Question 2
# Make every point on that plot the same colour - your choice which
# (Think carefully about where this goes)
# ----------------------------------------


# ----------------------------------------

# Question 3
# Now make the colour of the points depend on `Month` instead
# Why did this one have to go somewhere different to Question 2?
# ----------------------------------------

#                                         <--- write your answer here
# ----------------------------------------

# Question 4
# Take your Question 3 plot and add:
# - a title and a subtitle
# - sensible x and y axis labels (remember the units above!)
# - a legend title of "Month"
# Save the whole thing as an object called `air_plot`
# ----------------------------------------
air_plot <-

# ----------------------------------------

# Question 5
# Add theme_bw() to `air_plot`, then try theme_classic() and theme_minimal()
# Which do you prefer?
# (Remember you can add layers onto a saved plot with a + )
# ----------------------------------------


# ----------------------------------------

# Question 6
# Now build your own theme() layer onto `air_plot` to:
# - make the title bold and size 16
# - remove the panel background entirely (hint: element_blank())
# - move the legend to the bottom
# ----------------------------------------



# ----------------------------------------

# Question 7
# We need a categorical variable for the next few plots, so let's make one
# Use mutate() and case_when() to add a column called `temp_cat` that is:
#   "Cool"  when Temp is below 65
#   "Hot"   when Temp is above 80
#   "Mild"  otherwise
# Save the result back into `air`
# (case_when() from week 4 - watch the order of your conditions)
# ----------------------------------------
air <- air |>
  mutate(temp_cat = case_when( ))

# ----------------------------------------

# Question 8
# Make a box plot with `temp_cat` on the x axis and `Wind` on the y axis
# Give it a title and a better y axis label
# ----------------------------------------


# ----------------------------------------

# Question 9
# Layer the individual points on top of that box plot using geom_jitter()
# Stop the box plot drawing its outliers, so outlying points aren't plotted twice
# Only let the points move sideways, not up and down - and not too far
# ----------------------------------------


# ----------------------------------------

# Question 10
# A tricky one to end with!
# We are going to plot how ozone changes over time

# First, filter the data to just Month 5 (May), then make a line plot
# of `Ozone` (y) against `Day` (x) using geom_line()
# ----------------------------------------


# ----------------------------------------

# You will see a warning about rows being removed - hold that thought

# Now go back to the WHOLE dataset (all months) and make the same line plot
# On its own this is a mess, because the days from different months all land
# on top of each other
# facet_wrap() fixes this - it splits a plot into one small panel per group
# It goes on as its own layer, and the ~ means "split by this variable":
#   Eg   + facet_wrap(~ Month)
# Add that to your plot
# ----------------------------------------


# ----------------------------------------

# Each panel still shares one y axis, so they are hard to compare
# Look up the `scales` argument in facet_wrap() help page and use it to give each panel
# its own y axis
# ----------------------------------------


# ----------------------------------------

# Finally - about that warning that rows were removed
# Why is it happening? (Hint: look at the Ozone column with summary())
# ----------------------------------------

#                                         <--- write your answer here
# ----------------------------------------
