
# -----------------------------------
# Introduction to R - Week 2 --------
# -----------------------------------

# ---------------------------------------------------
## Part 1 - Matrices, dataframes and lists (oh my)---
# ---------------------------------------------------

# Vectors are *one dimensional*, matrices are *two dimensional*
# There are two ways to make a matrix
# The first is to write a vector and tell R to break it into two (or)
# more columns.
# This has the form: matrix(data, nrow, ncol) <- you can supply either nrow, ncol or both 
  
my_matrix <- matrix(1:10, ncol = 2)

print(my_matrix)

# The second is to combine two vectors with `cbind` (short for "column bind")

vector_one <- 1:5
vector_two <- 6:10

cbind(vector_one, vector_two)

# Question 1 
# `rbind` is the "row bind" equivalent
# What does using rbind on these two vectors do? 
# ----------------------------------------


# ----------------------------------------

# Selecting items from a matrix now needs two arguments: 
# Row position then column position 
# I've made this matrix to make it clearer:

clear_matrix <- matrix(c("A1", "B1", "C1", "D1", "E1",
                  "A2", "B2", "C2", "D2", "E2"),
                  ncol = 2)

print(clear_matrix)

# Selecting the entry on the second row of the first column would be: 

clear_matrix[2,1]

# Question 2 
# How would you pick out "D3"?
# ----------------------------------------
clear_matrix[ , ]

# ----------------------------------------

# Anything you can select you can modify 
# This is very useful for reproducible data cleaning as you will see 
# Look at the before and after here

clear_matrix[2,1] <- "B1 modified"

clear_matrix

# Question 3
# Add 2 to every item in `my_matrix`
# ----------------------------------------
my_matrix

my_matrix * my_matrix

# ----------------------------------------

# Dataframes are fancy matrices 
# You can make them fresh like this 
# data.frame(col1 = ..., col2 = ....) 
# eg 

my_data_frame <- data.frame(col1 = c("A", "B", "C", "D", "E", "F"),
           col2 = 1:6)

# Or by coercing a matrix 

as.data.frame(my_matrix) # note this doesn't have any column names as matrices never do.... 

# You can see the column names with colnames()

colnames(my_data_frame)

# The column names are just a vector so
# as always you can select one or more of them 
# eg 

colnames(my_data_frame)[2]

# Question 4
# Rename `col2` and `column_two`
# ----------------------------------------


# ----------------------------------------

# You can select individual columns from a dataframe in two ways
# If you leave one side of the comma blank then this tells R to select all of those 

my_data_frame[ , 1] # All rows, just column one

# You could also use the name of the column

my_data_frame[ , "col1"]

# or TRUE/FALSE again

my_data_frame[ , c(TRUE, FALSE)]

# You can also use the dollar sign ($) operator, which needs the actual name

my_data_frame$col1

# Question 5 
# Data frames need data in the right format 
# Why doesn't think work? 
# ----------------------------------------
data.frame(col1 = c("A", "B", "C"),
           col2 = 1:10)
#
# ----------------------------------------


# If you do need to store vectors of different length togther a list is what you need

my_list <- list(item1 = c("A", "B", "C"),
     item2 = 1:10)

# You can then retrive them with the dollar operator 

my_list$item1

# ---------------------------------------
## Part 2 - Intro to packages ---------
# ---------------------------------------

# There are a lot: https://cran.r-project.org/web/packages/available_packages_by_name.html

# Download a package (note the quotes)

installed.packages("readr") # You only need to do this once

# Then load it 

library(readr) # You need to do this every time you start R

# ---------------------------------------
## Part 3 - Getting data into R ---------
# ---------------------------------------

# Download the `iris.csv` file if you haven't already and save in a folder called `data`

# Using the inbuilt load function (which uses readr) ----> 

# You can copy and paste the output here: 

iris <- read_csv("data/iris.csv") 