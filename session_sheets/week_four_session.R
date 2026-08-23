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


# --------------------------------------------
## Part 3 - Pivoting data --------------------
# --------------------------------------------

# data set will either be in "long" or "wide" format, depending on how the original
# data collection form has been structured
# wide format is when each variable has it's own column (like in our iris_df data set)
# we can use the command pivot_longer() to switch to long format

iris_df_id <- iris_df |> 
  mutate(flower_id = row_number(), .before = Sepal.Length) # adding a unique id for each observation

iris_df_long <- iris_df_id |> 
  pivot_longer(
    cols = Sepal.Length:Petal.Width,  # Columns to gather
    names_to = "Flower_part",         # New column name for measurement types
    values_to = "Value"               # New column name for the numerical values
  )
# in the new "long" format dataset, the same data is there, however each observation
# now has 4 rows as the variables (sepal length/width and petal length/width) 
# are shown under a single heading/column "Flower_part"
# we will see in the ggplot session why you might want to order data like this

iris_df_wide <- iris_df_long |> 
  pivot_wider(
    names_from = Flower_part,         # Where column names come from
    values_from = Value               # Where the values come from
  )
# Generally pivot_longer() arranges a data set with more rows and fewer columns,
# pivot_wider() arranges data sets to fewer rows and more columns

# Question 4 
# This code makes a new small dataset in a standard 'wide' format

# Use pivot_longer() to make a wide dataset where the PCR target
# is one column called "Target" and the Cq value is its own column
# called "Cq"
# Save this as PCR_wider
# Then use pivot_longer to get it back into the original form
# ----------------------------------------
PCR <- data.frame(patient = c("A", "B", "C"),
           lytA = c(28, 24, 10),
           nuc = c(23, 28, NA),
           sodC = c(NA, NA, 14)) 

PCR |> 
  pivot_longer(cols = lytA:sodC,
               names_to = "Target",
               values_to = "Cq")



# ----------------------------------------


# ---------------------------------------- 
## Part 4 - joint dataframes together ----
# ----------------------------------------

# For our research studies we often have multiple data sets that need combining
# To join data from 2 or more sources you need a matching key across all data sets
# This may be the unique participant id or a date etc

species_info <- tibble(
  Species = c("setosa", "virginica", "sibirica"),
  Common_Name = c("Bristle-pointed iris_df", "Virginia iris_df", "Siberian iris_df"),
  Native_Climate = c("Subarctic", "Subtropical", "Subarctic")
)

# There are a few types of join we can do 
# First look at the iris_df dataset and check how many columns it has:
# ----------------------------------------



# ----------------------------------------

## LEFT JOIN 
# This takes dataset (A) and joins dataset (B) onto it by any of a specified column(s)
# It retains all of dataset (A) and only those of (B) which have a match in (A)
# Try this and check the number of rows and the count of species
# ----------------------------------------
iris_df_left_joined <- iris_df |>
  left_join(species_info, by = "Species")


# ----------------------------------------



