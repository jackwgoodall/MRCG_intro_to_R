# -----------------------------------
# Homework with answers - Week 3 --------
# -----------------------------------

# For the homework you will be working with the 'births' datset from the Epi Package
# Install Epi and load births

install.packages("Epi")
library(Epi)
data("births")

# Question 1 
# How many rows and how many columns does the births dataset have?
# ----------------------------------------
nrow(births) #500
ncol(births) #8
# ----------------------------------------


# Question 2
# What type of variable is contained in each column of the births dataset?
# Which variables are logical (True/False), which variable are continous numerical?
# ----------------------------------------
str(births)
#numerical
#log = lowbw, preterm, hyp, sex
# cont = bweight, gestwks, matage
# ----------------------------------------


# Question 3
# What is the range, interquartile range, mean and median of birth weights?
# ----------------------------------------
range(births$bweight) #628 to 4553
#IQR shown in summary() 2862 to 3551
mean(births$bweight) #3136.89
median(births$bweight) #3188.5
# ----------------------------------------

# Question 4
# How many babies are born preterm?
# ----------------------------------------
births |> count(preterm)
# 63
# ----------------------------------------

# Question 5
# Create a new data frame of only preterm births, save as pt_births
# For babies born preterm, what is the range, IQR, mean and median birth weight?
# ----------------------------------------
pt_births <- births |> 
  filter(preterm == 1) 

range(pt_births$bweight)
mean(pt_births$bweight)
median(pt_births$bweight)
# ----------------------------------------


# Question 6
# using the original births dataset, filter by preterm birth and summarise the
# median maternal age
# ----------------------------------------
births |> filter(preterm == 1) |>
  summarise(median(matage))
# ----------------------------------------


# Question 8
# Plot a boxplot of bweight for term (preterm = 0) and preterm (preterm =1) babies
boxplot(bweight ~ preterm, data = births)


# Question 9
# Considering the summary values and the boxplot, in 3 sentences summarise your 
# initial observations regarding birth weight and gestation length
# ----------------------------------------


# ----------------------------------------