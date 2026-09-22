# --------------------------------------------
## Part 1 - Pivoting data --------------------
# --------------------------------------------

# data set will either be in "long" or "wide" format, depending on how the original
# data collection form has been structured
# wide format is when each variable has it's own column (like in our iris_df data set)
# we can use the command pivot_longer() to switch to long format

# This needs tidyr which is a package in the tidyverse.  So first lets load the tidyverse

library(tidyverse)

# We'll make a small dataset so we can see clearly what is happening 

small_df <- data.frame(entry = c("A", "B", "C"),
                       value_one = c(1, 2, 3),
                       value_two = c(777, 888, 999))

small_df

# Here we give pivot_longer the minimum number of arguments - which is just which columns it should 
# pivot the data from

small_df.long <- small_df |> 
  pivot_longer(cols = c(value_one, value_two))

small_df.long

# One key feature is that you need some unique identifer so you know which entries 'belong' 
# together.  Most dataframes have this (pid, participant_number, ID, name etc) but the iris
# dataset doesn't.

# Uncomment and run these lines if you have cleared your environment of the iris df we made
#iris_df <- read_csv(file = "data/iris.csv")
#iris_df$Species[iris_df$Species == 'Setosi'] <- 'setosa'
#iris_df$Petal.Length[iris_df$Petal.Length == 69] <- NA

# We can add an ID column here:

iris_df_id <- iris_df |> 
  mutate(flower_id = row_number(), .before = Sepal.Length) # adding a unique id for each observation

iris_df.long <- iris_df_id |> 
  pivot_longer(
    cols = Sepal.Length:Petal.Width,  # Columns to gather
    names_to = "Flower_part",         # New column name for measurement types
    values_to = "Value"               # New column name for the numerical values
  )

head(iris_df.long, n=20)

# This longform data is especially useful for plotting. eg. 

ggplot(iris_df.long, aes(x = Flower_part, y = Value)) + geom_boxplot()

# We can convert back in a very similar way 
# First with our small dataframe 
small_df.long |> 
  pivot_wider(names_from = name,
              values_from = value)

# Then with the iris dataframe 
iris_df.wide <- iris_df.long |> 
  pivot_wider(
    names_from = Flower_part,         # Where column names come from
    values_from = Value               # Where the values come from
  )


# Question 1
# This code makes a new small dataset in a standard 'wide' format

# Use pivot_longer() to make a wide dataset where the PCR targets
# are joinws into one column called "Target" and the Cq value is its own column
# called "Cq"
# Save this as PCR_wider
# Then use pivot_longer to get it back into the original form
# ----------------------------------------
PCR <- data.frame(patient = c("A", "B", "C"),
                  lytA = c(28, 24, 10),
                  nuc = c(23, 28, NA),
                  sodC = c(NA, NA, 14)) 


# ----------------------------------------


# ---------------------------------------- 
## Part 2 - joint dataframes together ----
# ----------------------------------------

# For our research studies we often have multiple data sets that need combining
# To join data from 2 or more sources you need a matching key across all data sets
# This may be the unique participant id or a date etc

species_info <- data.frame(
  Species = c("setosa", "virginica", "sibirica"),
  Common_Name = c("Bristle-pointed iris", "Virginia iris", "Siberian iris"),
  Native_Climate = c("Subarctic", "Subtropical", "Subarctic")
)

# There are a few types of join we can do 
# First look at the iris_df dataset and check how many columns it has:
# ----------------------------------------



# ----------------------------------------

## LEFT JOIN 
# This takes dataset (A) and joins dataset (B) onto by the specified column(s)
# It retains all of dataset (A) and only those of (B) which have a match in (A)
# Try this and check the number of rows and the count of species
# ----------------------------------------
iris_df_left_joined <- iris_df |>
  left_join(species_info, by = "Species")


# ----------------------------------------

# There are three other joins you can use. 
# A detailed guide can be found here: https://r4ds.hadley.nz/joins.html

## RIGHT JOIN 
# Is the opposite of a left join, retaining all entries in B and only keeping those in A which have a match

## INNER JOIN
# Only keeps entries where the entries appear in A and B. Unmatched rows from either input are excluded.  

## FULL JOIN 
# Keeps all entries from A and B 