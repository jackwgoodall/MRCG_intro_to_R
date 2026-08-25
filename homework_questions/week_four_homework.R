# -----------------------------------
# Homework - Week 4 --------
# -----------------------------------

# This week is all about the tidyverse verbs: filter, mutate, summarise and
# group_by, all joined together with the pipe

# We are going back to the `births` dataset from last week
# You will need the Epi package loaded to use it 

# Question 1
# Edit this code to load the tidyverse, then load the Epi package and the births dataset
# (Remember: install once, load every session)
# ----------------------------------------
library( )

library(Epi )

data(births)
# ----------------------------------------

# Question 2
# Using the pipe and filter(), keep only the babies with a birthweight (bweight is the
# column name) over 3000. 
# How many are there?
# (You can add |> nrow() on the end to count them)
# ----------------------------------------
births |> 
  filter() 

# How many:                               <--- write your answer here
# ----------------------------------------

# Question 3
# Now filter for babies who were BOTH preterm (preterm == 1) AND
# under 2000g
# You can put both conditions in one filter() separated by a comma,
# or use two filters in a row - try both to reassure yourself that you
# getthe same answer
# ----------------------------------------


# ----------------------------------------

# Question 4
# `!=` means "does not equal"
# Use it to keep only the babies who are NOT male (sex == 1 is male)
# ----------------------------------------



# ----------------------------------------

# Question 5
# bweight is currently measure in grams
# Use mutate() to add a new column called `bweight_kg`
# This should be the birth weight in kilograms rather than grams
# Save the result as a new dataframe called `births_with_kg`
# ----------------------------------------



# ----------------------------------------

# Question 6
# Use mutate() with case_when() to add a column called `weight_group`
# It should say:
#   "Low"     when bweight is under 2500
#   "Normal"  when bweight is 2500 or over
# Add a TRUE ~ "CHECK!" line at the end to catch anything that slips through
# Save the result as `births_grouped`
# ----------------------------------------
births_grouped <- births |>
  mutate(weight_group = case_when( ))

# ----------------------------------------

# Question 7
# Check your new column worked using table()
# Did anything come out as "CHECK!"?
# What sort of thing would end up there if it had?
# ----------------------------------------


#                                         <--- write your answer here
# ----------------------------------------

# Question 8
# Use summarise() to get the mean, minimum and maximum birth weight
# all in one go
# Give each one a sensible column name
# ----------------------------------------
births |>
  summarise( )

# ----------------------------------------

# Question 9
# Copy your answer from (9) and add group_by() so that you get 
# those same three numbers separately for boys and girls
# (Reminder: sex is coded 1 for male, 2 for female)
# ----------------------------------------


# ----------------------------------------

# Question 10
# A tricky one to end with!
# Build one chain that does all of this in order:
#   - starts with births dataframe (as always)
#   - groups by preterm
#   - summarises the mean birth weight AND the median maternal age ("matage")
# ----------------------------------------



# ----------------------------------------

# You should get three rows rather than two. Why?
# (Think back to what we found in last week's homework)
#                                         <--- write your answer here
# ----------------------------------------
