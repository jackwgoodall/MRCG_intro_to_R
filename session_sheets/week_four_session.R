# -----------------------------------
# Introduction to R - Week 4 --------
# -----------------------------------

# ---------------------------------------
## Part 1 - Welcome to the tidyverse ----
# ---------------------------------------

# Question 1
# Install and load the tidyverse package 
# ----------------------------------------


# ----------------------------------------

# The tidyverse uses the pipe to make sequential changes to a dataframe
# You can either use the tidyverse's own pipe (%>%) or the relative new 
# native R pipe (|>) 
# These both do the same thing and you will see both in other people's code - 
# Just pick your favourite... 

## Filter ---- 

iris_df |>                        # |> means 'pipe'
  filter(Sepal.Length > 5.5)      # filtering for variables with sepal length > 5.5

# We can of course add as many conditions as we choose
# You can do this on the same line or seperately
# eg
iris_df |>
  filter(Species == "versicolor" & Petal.Length > 1.2)  

# or 
iris_df |>
  filter(Species == "versicolor") |> 
  filter(Petal.Length > 1.2)  

# You can use != to mean "does not equal" to exclude rather than 
# include variables

# Question 2
# Modify this code so that it *excludes* rather than includes the veriscolours
# ----------------------------------------
iris_df |>
  filter(Species == "versicolor") |> 
  filter(Petal.Length > 1.2)  

# ----------------------------------------

## Mutate ---- 

# This is a really helpful command which I suspect you will use all the time
# It makes a new column based on criteria you set

# The lengths in this dataset are all in cm. Imagine we wanted them in mm 
# You could do: 
iris_df_mutated <- iris_df |> 
  mutate(Petal.Length.mm = Petal.Length * 10)

# We can make more complex conditional columns with 'case_when()' 
# This uses the syntax case_when(column, condition ~ outcome) i.e.

iris_df_petal_size <- iris_df |> 
  mutate(Petal.Size =  case_when (Petal.Length < 3.7 ~ "Small",
                                  Petal.Length >= 3.7 ~ "Big"
                                  TRUE ~ "CHECK!") ) 

# The TRUE ~ tells R what to do with anything that doesn't meet any of the conditions
# You don't have to use this (you might expect NAs) but I use it as a 
# check that I haven't made a mistake! 


# Question 3
# Make a new column in the iris dataframe called one_point_five
# This should be "Yes" when Petal.Length is 1.5 and "No" when it isn't
# ----------------------------------------
iris_df |>
  mutate(one_point_five = )

# ----------------------------------------

# --------------------------------------------
## Part 2 - Summarising data -----------------
# --------------------------------------------

# It can be very helpful to summarise you data
# You can do this with the whole dataset or subsetted by other variables

iris_df |>
  summarise(mean(Sepal.Length))

# Note how this makes quite a clumsy column name 
# Whether this matters depends on whether you just need to know this result 
# or whether you are going to save this as a new dataframe and continue using it

# You can set the name like this:
iris_df |>
  summarise(mean_sepal_length = mean(Sepal.Length))

# We can add more summary options 
# eg 
iris_df |>
  summarise(mean_sepal_length = mean(Sepal.Length),
            min_septal_length = min(Sepal.Length),
            max_septal_length = max(Sepal.Length))

# The real power here comes when you add a grouping variable
iris_df |>
  group_by(Species) |>
  summarise(mean_sepal_length = mean(Sepal.Length),
            min_septal_length = min(Sepal.Length),
            max_septal_length = max(Sepal.Length))

# Question 3
# Modify this code to summarise the mean Petal.Length by species
# ----------------------------------------
iris_df |>
  group_by() |> 
  summarise(mean_petal_length = )

# ----------------------------------------