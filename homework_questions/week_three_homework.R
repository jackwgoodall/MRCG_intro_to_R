# -----------------------------------
# Homework - Week 3 --------
# -----------------------------------

# Question 8
# Using the `iris` dataframe from the lesson, select only the `Sepal.Width` column
# (There are several ways you can do this - by preference is with the $ operator
# but the choice is yours)
# ----------------------------------------


# ----------------------------------------

# Question 9
# Expand this to make a vector of TRUE/FALSE for when `Sepal.Width` is greater than 3
# ----------------------------------------

# Question 10
# Now use this to select only the rows where the `Sepal.Width` is greater than 3
# ----------------------------------------


# ----------------------------------------

# Question 11
# A tricky one to end with! 
# An & sign can be used to return TRUE only when *both* conditions are met 
# Eg (4 > 3) & (4 > 5) will return FALSE as only the first condition is TRUE
# Use this to select only the rows where `Sepal.Width` is greater than 3 AND `Petal.Width` 
# is less than 1.5
# ----------------------------------------



# ----------------------------------------



# For the homework you will be working with the 'births' datset from the Epi Package
# For each answer include both the code and final answer

# Install Epi and load births
install.packages("Epi")
library(Epi)
data("births")

# Question 1 
# How many rows and how many columns does the births dataset have?
# ----------------------------------------

# ----------------------------------------


# Question 2
# What type of variable is contained in each column of the births dataset?
# Which variables are logical (True/False), which variable are continous numerical?
# ----------------------------------------

# ----------------------------------------


# Question 3
# What is the range, interquartile range, mean and median of birth weights?
# ----------------------------------------

# ----------------------------------------

# Question 4
# How many babies are born preterm?
# ----------------------------------------

# ----------------------------------------

# Question 5
# Create a new data frame of only preterm births, save at pt_births
# For babies born preterm, what is the range, IQR, mean and median birth weight?
# ----------------------------------------

# ----------------------------------------


# Question 6
# using the original births dataset, filter by preterm birth and summarise the
# median maternal age
# ----------------------------------------

# ----------------------------------------


# Question 8
# Plot a boxplot of bweight for term (preterm = 0) and preterm (preterm =1) babies
# ----------------------------------------

# ----------------------------------------


# Question 9
# Considering the summary values and the boxplot, in 3 sentences summarise your 
# initial observations regarding birth weight and gestation length
# ----------------------------------------


# ----------------------------------------