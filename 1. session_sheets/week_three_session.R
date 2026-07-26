install.packages("readr")


# -----------------------------------
# Introduction to R - Week 3 --------
# -----------------------------------

# Using the dataset iris, that we met last week
# We are going to cover how to:
# 1. explore and summarise this data
# 2. visualise the data
# 3. correct errors
# Both in base R and tidyverse

# Question 1
# Install and load tidyverse (Hint: see week 2 notes and installing readr)
# ----------------------------------------


# ----------------------------------------

# load the iris dataset to your environment
iris <- read_csv("data/iris.csv") 

# --------------------------------------------
## Part 1 - Getting acquainted with your data! -
# --------------------------------------------

# Click on the iris dataset in the environment, this will open the dataset 
# in a new tab above the script where you can view the dataset

# Question 2
# Recap from last week: look at the first 10 rows of the iris dataset
# Recap from last week: look at the last 10 rows of the iris dataset

# ----------------------------------------


# ----------------------------------------

# we can explore the structure of the dataset using str() function
str(iris)

# the structure should be summarised in the console (types of variables/factors etc)

# We can explore the dimensions (rows and columns) of a dataset individually too
dim(iris)
nrow(iris)
ncol(iris)

#Aggregations
sum(iris$Sepal.Length)           			      # Sum 
max(iris$Sepal.Length)               			    # Max value 
min(iris$Sepal.Length)               			    # Min value 
range(iris$Sepal.Length)         			      # Min and max 
mean(iris$Sepal.Length, na.rm = TRUE)        # Mean 
median(iris$Sepal.Length, na.rm = TRUE)      # Median 
quantile(iris$Sepal.Length, probs = 0:20/20) # Quantiles 


# to summarise the dataset we use summary()
summary(iris)

# Question 3
# what are the median and mean petal length values?
# how many species are in this dataset?

# ----------------------------------------


# ----------------------------------------

# This data exploration is very useful as it allows us to identify potential errors
# This step should always be supplemented with visual/grahical exploration

# Summary() works well for numeric variabd$name[d$name %in% c('Bab', 'Bobby')] <- 'Bob'les, but for character variables
# unique() and table() are helpful
unique(iris$Species)
table(iris$Species)

# It is likely that Setosi is a typo of setosa ... lets correct that!
iris$Species[iris$Species %in% c('Setosi')] <- 'setosa' #some of this code may be familiar from end of session 2

# Plotting the data

plot(iris$Petal.Length)
plot(iris$Petal.Width~iris$Petal.Length)
boxplot(iris[, c('Petal.Width', 'Petal.Length')])

# Handling errors
# If you have access to the original data you can correct the value from this
# Team iris have not shared their OG data with us, so we need to remove this value

iris$Petal.Length[iris$Petal.Length == '69'] <- NA

# rechecking our dataset
plot(iris$Petal.Length)
plot(iris$Petal.Width~iris$Petal.Length)
boxplot(iris[, c('Petal.Width', 'Petal.Length')])

# --------------------------------------------
## Part 2 - Getting acquainted with your data in Tidyverse
# --------------------------------------------
