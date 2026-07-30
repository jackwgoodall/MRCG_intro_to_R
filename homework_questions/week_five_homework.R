# ------------------------------
# - Week five homework ---------
# ------------------------------

# Everything this week is ggplot2
# Remember the "steps" from the session:
# 1. prepare your data, 2. add the data, 3. format the labels, 4. format the plot
# The userguide is your friend: https://ggplot2.tidyverse.org/articles/ggplot2.html

library(tidyverse)

# Load the iris dataset (same as the session)
iris <- read_csv(file = "data/iris.csv")

# Question 1
# Make a scatter plot of `Petal.Length` on the x axis and `Petal.Width` on the y axis
# (We used the Sepal columns in the session - these are the Petal ones)
# ----------------------------------------
ggplot(data = iris) +

# ----------------------------------------

# Question 2
# Make every point on that plot the same colour - your choice which
# (Think carefully about where this goes)
# ----------------------------------------


# ----------------------------------------

# Question 3
# Now make the colour of the points depend on `Species` instead
# Why did this one have to go somewhere different to Question 2?
# ----------------------------------------

#                                         <--- write your answer here
# ----------------------------------------

# Question 4
# Take your Question 3 plot and add:
# - a title and a subtitle
# - sensible x and y axis labels (with units - the iris measurements are in cm)
# - a legend title of "Iris species"
# Save the whole thing as an object called `petal_plot`
# ----------------------------------------
petal_plot <-

# ----------------------------------------

# Question 5
# We only tried theme_minimal() in the session
# Add theme_bw() to `petal_plot`, then try theme_classic()
# Which do you prefer?
# (Remember you can add layers onto a saved plot with a + )
# ----------------------------------------


# ----------------------------------------

# Question 6
# Now build your own theme() layer onto `petal_plot` to:
# - make the title bold and size 16
# - remove the panel background entirely (hint: element_blank())
# - move the legend to the bottom
# ----------------------------------------


# ----------------------------------------

# Question 7
# Make a box plot with `Species` on the x axis and `Petal.Length` on the y axis
# Give it a title and a better y axis label
# ----------------------------------------


# ----------------------------------------

# Question 8
# Layer the individual points on top of that box plot using geom_jitter()
# Stop the box plot drawing its outliers, so outlying points aren't plotted twice
# Only let the points move sideways, not up and down - and not too far
# ----------------------------------------


# ----------------------------------------

# Question 9
# First, make a new column `Petal.Length.cat` that is "Short" when `Petal.Length`
# is below 2.5, "Long" when it is above 5, and "Medium" otherwise
# (case_when() from the session - watch the order of your conditions)
# Then make a bar chart of `Petal.Length.cat` filled by `Species`, showing
# proportions rather than counts, and choose your own three colours
# ----------------------------------------


# ----------------------------------------

# Question 10
# A tricky one to end with!
# We are going to use and air quality dataset taken in New York, one row per day
# Download this from week 5 data: https://jackwgoodall.github.io/MRCG_intro_to_R/timetable.html
# Add it to your `data/` folder 
# Use `readr` to import it as `air`
# ----------------------------------------
air <- 

  
# ----------------------------------------

# Filter it to just Month 5, then use pivot_longer() on the four measurement
# columns c("Ozone", "Solar.R", "Wind", "Temp") so you get one row per
# measurement, with the measurement name in a column called `measure` and the
# number in a column called `value`
# Complete this code:
# ----------------------------------------
air_longer <- air %>%
  filter( ) %>%
  pivot_longer( )

# ----------------------------------------

# Now make a line plot of `value` against `Day`, with a different coloured line
# for each `measure`
# ----------------------------------------

 
# ----------------------------------------

# You should find that plot is fairly useless - the four measures are on wildly
# different scales, so Solar.R flattens everything else
# facet_wrap() splits a plot into one small panel per group, which fixes this
# It goes on as its own layer, and the ~ means "split by this variable":
# Eg  + facet_wrap(~ measure)
# Add that to your plot
# ----------------------------------------


# ----------------------------------------

# Each panel still shares one y axis, so it is still hard to read
# Look up the `scales` argument of facet_wrap() and use it to give each panel
# its own y axis
# ----------------------------------------


# ----------------------------------------

# Finally - R will have warned you about rows being removed
# Why? (Hint: look at the Ozone column)
# ----------------------------------------

#                                         <--- write your answer here
# ----------------------------------------
