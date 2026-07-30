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
# Install and load the tidyverse package (Hint: see week 2 notes:installing readr)
# ----------------------------------------


# ----------------------------------------

# load the iris dataset to your environment
iris <- read_csv("data/iris.csv") 

# ----------------------------------------------
## Part 1 - Getting acquainted with your data! -
# ----------------------------------------------

# Click on the iris dataset in the environment, this will open the dataset 
# in a new tab above the script where you can view the dataset

# Question 2
# Recap from last week: look at the first 10 rows of the iris dataset
# Recap from last week: look at the last 10 rows of the iris dataset

# ----------------------------------------


# ----------------------------------------

# we can explore the structure of the dataset using str() function
str(iris)

# the structure should be summarised in the console (types of variables and their first few entries)

# We can explore the dimensions (rows and columns) of a dataset individually too
dim(iris)
nrow(iris)
ncol(iris)

#Aggregations
sum(iris$Sepal.Length)           			       # Sum 
max(iris$Sepal.Length)               			   # Max value 
min(iris$Sepal.Length)               			   # Min value 
range(iris$Sepal.Length)         			       # Min and max 
mean(iris$Sepal.Length, na.rm = TRUE)        # Mean 
median(iris$Sepal.Length, na.rm = TRUE)      # Median 
quantile(iris$Sepal.Length, probs = seq(0, 1, by = 0.05)) # Quantiles 


# to summarise the dataset we use summary()
summary(iris)

# Question 3
# what are the median and mean petal length values?
# how many species are in this dataset?

# ----------------------------------------

# Mean = 

# Median = 

# How many species: 

# ----------------------------------------

# This data exploration is very useful as it allows us to identify potential errors
# This step should always be supplemented with visual/graphical exploration

# Summary() works well for numeric variables but for character variables
# unique() and table() are helpful
unique(iris$Species)
table(iris$Species)

# It is likely that "Setosi" is a typo of "setosa" ... lets correct that!
iris$Species[iris$Species %in% c('Setosi')] <- 'setosa' #some of this code may be familiar from end of session 2

# Plotting the data

plot(iris$Petal.Length)
plot(iris$Petal.Width~iris$Petal.Length)
boxplot(iris[, c('Petal.Width', 'Petal.Length')])

# Handling errors:
# Rather than going back and meddling with a redcap download etc, R can provide
# a transparent way to correct errors such as this. eg. we could write:


# JG 17/08/2026 - spotted implausble value, unable to confirm original so changed to NA:
iris$Petal.Length[iris$Petal.Length == '69'] <- NA

# rechecking our dataset
plot(iris$Petal.Length)
plot(iris$Petal.Width~iris$Petal.Length)
boxplot(iris[, c('Petal.Width', 'Petal.Length')])

# ---------------------------------------------------
## Part 2 - Getting acquainted with your data in ----
#           Tidyverse (filter, group_by, summarise, -
#           arrange, mutate, select)                -
# ---------------------------------------------------

library("tidyverse")

iris_long_sepal <- iris |>                             # 'assign' (<-) new output to iris_1, |> means 'pipe'
              filter(Sepal.Length > 5.5)      # filtering for variables with sepal length > 5.5

iris_long_petal_versicolor <- iris |>
              filter(Species == "versicolor" & Petal.Length > 1.2) #note the == is a logical = 

iris_summary <- iris |> 
                group_by(Species) |>
                summarise(
                      avg_sepal_length = mean(Sepal.Length),
                      sample_count = n())

print(iris_summary) #The above code creates a new dataframe in the environment
                    #this code prints it out in the console

# Question 4
# Can you modify this code so that it excludes all the `virginica`?
# ----------------------------------------
iris_summary_no_virginica <- iris |> 
                             group_by(Species) |>
                             summarise(
                                    avg_sepal_length = mean(Sepal.Length),
                                    sample_count = n())

# ----------------------------------------

# back to the main iris dataset

iris_sorted <- iris |>      #arranging the dataset by ascending order of sepal length
  arrange(Sepal.Length)

iris_sorted_desc <- iris |>    #arranging the dataset by descending order of sepal length
  arrange(desc(Sepal.Length))

iris_multi_sort <- iris |>          # 2-step arrange, descending sepal length but within species
  arrange(Species, desc(Sepal.Length))

# note arrange() changes the order of the rows without changes which rows are present

# For the iris dataset the petal length is currently measured in cm, we want to change this to mm
# for this we use mutate(), this command affects columns without changing rows

iris_mutated <- iris |> 
  mutate(Petal.Length.mm = Petal.Length * 10)

iris_mutated <- iris_mutated |> 
  relocate(Petal.Length.mm, .after = Petal.Length)
# relocating the new column after the original to aid comparison


# --------------------------------------------
## Part 3 - Pivoting data --------------------
# --------------------------------------------

# data set will either be in "long" or "wide" format, depending on how the original
# data collection form has been structured
# wide format is when each variable has it's own column (like in our Iris data set)
# we can use the command pivot_longer() to switch to long format

iris_id <- iris |> 
  mutate(flower_id = row_number(), .before = Sepal.Length) # adding a unique id for each observation

iris_long <- iris_id |> 
  pivot_longer(
    cols = Sepal.Length:Petal.Width,  # Columns to gather
    names_to = "Flower_part",         # New column name for measurement types
    values_to = "Value"               # New column name for the numerical values
  )
# in the new "long" format dataset, the same data is there, however each observation
# now has 4 rows as the variables (sepal length/width and petal length/width) 
# are shown under a single heading/column "Flower_part"
# we will see in the ggplot session why you might want to order data like this

iris_wide <- iris_long |> 
  pivot_wider(
    names_from = Flower_part,         # Where column headers come from
    values_from = Value               # Where cell numbers come from
  )
# Generally pivot_longer() arranges a data set with more rows and fewer columns,
# pivot_wider() arranges data sets to fewer rows and more columns


# ---------------------------------------- 
## Part 4 - joint dataframes together ----
# ----------------------------------------

# For our research studies we often have multiple data sets that need combining
# To join data from 2 or more sources you need a matching key across all data sets
# This may be the unique participant id or a date etc

species_info <- tibble(
  Species = c("setosa", "virginica", "sibirica"),
  Common_Name = c("Bristle-pointed Iris", "Virginia Iris", "Siberian Iris"),
  Native_Climate = c("Subarctic", "Subtropical", "Subarctic")
)

# There are a few types of join we can do 
# First look at the iris dataset and check how many columns it has:
# ----------------------------------------


# ----------------------------------------

## LEFT JOIN 
# This takes dataset (A) and joins dataset (B) onto it by any of a specified column(s)
# It retains all of dataset (A) and only those of (B) which have a match in (A)
# Try this and check the number of rows and the count of species
# ----------------------------------------
iris_left_joined <- iris |>
  left_join(species_info, by = "Species")


# ----------------------------------------

## RIGHT JOIN 
# This does the same but now all of (B) is retained
# Try this and check the number of rows and count of species
# ----------------------------------------
iris_right_joined <- iris |>
  right_join(species_info, by = "Species")

table(iris_right_joined$Species)
# ----------------------------------------

## INNER JOIN
# This joins only when the joining column features in *both* dataframes
# Try this and check the number of rows and count of species
# ----------------------------------------
iris_inner_joined <- iris |>
  inner_join(species_info, by = "Species")

table(iris_inner_joined$Species)
# ----------------------------------------

## FULL JOIN 
# This joins where it is able but retains all columns from both datasets 
# Try this and check the number of rows and count of species
# ----------------------------------------
iris_full_joined <- iris |>
  full_join(species_info, by = "Species")

table(iris_full_joined$Species)
# ----------------------------------------
