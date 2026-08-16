# -----------------------------------
# Introduction to R - Week 3 --------
# -----------------------------------

# ---------------------------------------
## Part 1 - Intro to packages -----------
# ---------------------------------------

# There are a lot: https://cran.r-project.org/web/packages/available_packages_by_name.html

# Download a package (note the quotation marks)

install.packages("readr") # You only need to do this once

# Then load it 

library(readr) # You need to do this every time you start R

# putting a question mark first will tell you what the package is 
# in the help -----> 

?readr 

# `vignette()` will give you some examples about how this is used
# (note the quotation marks)
vignette("readr")

# Putting two colons after it will bring up a list of all of the functions 
# that package contains (useful if you forget the exact name of the function
# you need!)
# Type two colons after this:

readr

# Typing a question mark before the function tells you how to use it

?read_csv

# ---------------------------------------
## Part 2 - Getting data into R ---------
# ---------------------------------------

# Download the `iris_df.csv` file if you haven't already and save in a folder called `data`

# Using the inbuilt load function (which uses readr) ----> 

# You can copy and paste the output here: 

iris_df <- read_csv(file = "data/iris.csv") # this will only work if you have save this is a folder called `data`.  
                                         # getwd() tells you where your project is located (if this isn't working you might not
                                         # be where you think you are!)

# Click on the iris_df.xlsx to see how this can be done the same with a excel 
# file (just with a different package)

# As always we can get the structure with str()

str(iris_df)

# We can look at the first few rows using `head()`

head(iris_df)

# Or the bottom few rows with `tail()`

tail(iris_df)

# We can change how many we see by changing `head(df, n = x)`

head(iris_df, n = 10)

# Question 1 
# Can you print the `Sepal.Length` column three  ways? 
# ----------------------------------------
# 1st way


# 2nd way


# 3rd way


# ----------------------------------------

# If we ask R whether a condition is met it will reply with TRUE/FALSE
# The most useful here are `==` (exactly equal to), > (greater than) or < (less than)
# eg 

4 < 5

# We can use this to make a vector of TRUEs and FALSEs 
# eg 

iris_df$Species == "versicolor"

# We see here that the middle chunk are all "veriscolor" (look at the dataframe in the viewer
# to confirm this)

# We can use this to subset our dataframe to only the "versicolor" species
# eg 

iris_df[(iris_df$Species == "versicolor"), ]    # Note I've wrapped the `iris_df$Species == "versicolor"` in brackets 
                                          # These aren't actually needed here - I've used them to make the
                                          # code easier to read

# We can explore the dimensions (rows and columns) of a dataset individually too
dim(iris_df)
nrow(iris_df)
ncol(iris_df)

#Aggregations
sum(iris_df$Sepal.Length)           			       # Sum 
max(iris_df$Sepal.Length)               			   # Max value 
min(iris_df$Sepal.Length)               			   # Min value 
range(iris_df$Sepal.Length)         			       # Min and max 
mean(iris_df$Sepal.Length, na.rm = TRUE)         # Mean 
median(iris_df$Sepal.Length, na.rm = TRUE)       # Median 

# to summarise the dataset we use summary()
summary(iris_df)

# Question 2
# what are the median and mean petal length values?
# how many species are in this dataset?

# ----------------------------------------

# Mean = 

# Median = 

# How many species: 

# ----------------------------------------

# This data exploration is very useful as it allows us to identify potential errors
# This step should always be supplemented with visual/graphical exploration

# summary() works well for numeric variables but for character variables
# unique() and table() are helpful
unique(iris_df$Species)
table(iris_df$Species)

# It is likely that "Setosi" is a typo of "setosa"
# We can correct it like this:
iris_df$Species[iris_df$Species == 'Setosi'] <- 'setosa' #some of this code may be familiar from end of session 2

# Plotting the data

plot(iris_df$Petal.Length)
plot(iris_df$Petal.Width~iris_df$Petal.Length)
boxplot(iris_df[, c('Petal.Width', 'Petal.Length')])

# Handling errors:
# Rather than going back and meddling with a redcap download etc, R can provide
# a transparent way to correct errors such as this. eg. we could write:

# JG 17/08/2026 - spotted implausible value, unable to confirm original so changed to NA:
iris_df$Petal.Length[iris_df$Petal.Length == '69'] <- NA

# rechecking our dataset
plot(iris_df$Petal.Length)
plot(iris_df$Petal.Width~iris_df$Petal.Length)
boxplot(iris_df[, c('Petal.Width', 'Petal.Length')])

# ---------------------------------------
## Part 2 - Welcome to the tidyverse ----
# ---------------------------------------

# Question 3
# Install and load the tidyverse package 
# ----------------------------------------


# ----------------------------------------

iris_df_long_sepal <- iris_df |>              # 'assign' (<-) new output to iris_df_1, |> means 'pipe'
              filter(Sepal.Length > 5.5)      # filtering for variables with sepal length > 5.5

iris_df_long_petal_versicolor <- iris_df |>
              filter(Species == "versicolor" & Petal.Length > 1.2)  

iris_df_summary <- iris_df |> 
                group_by(Species) |>
                summarise(
                      avg_sepal_length = mean(Sepal.Length),
                      sample_count = n())

print(iris_df_summary) #The above code creates a new dataframe in the environment
                    #this code prints it out in the console

# Question 4
# Can you modify this code so that it excludes all the `virginica`?
# ----------------------------------------
iris_df_summary_no_virginica <- iris_df |> 
                             group_by(Species) |>
                             summarise(
                                    avg_sepal_length = mean(Sepal.Length),
                                    sample_count = n())

# ----------------------------------------

# back to the main iris_df dataset

iris_df_sorted <- iris_df |>      #arranging the dataset by ascending order of sepal length
  arrange(Sepal.Length)

iris_df_sorted_desc <- iris_df |>    #arranging the dataset by descending order of sepal length
  arrange(desc(Sepal.Length))

iris_df_multi_sort <- iris_df |>          # 2-step arrange, descending sepal length but within species
  arrange(Species, desc(Sepal.Length))

# note arrange() changes the order of the rows without changes which rows are present

# For the iris_df dataset the petal length is currently measured in cm, we want to change this to mm
# for this we use mutate(), this command affects columns without changing rows

iris_df_mutated <- iris_df |> 
  mutate(Petal.Length.mm = Petal.Length * 10)

iris_df_mutated <- iris_df_mutated |> 
  relocate(Petal.Length.mm, .after = Petal.Length)
# relocating the new column after the original to aid comparison


