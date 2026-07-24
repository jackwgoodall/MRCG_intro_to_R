
# -----------------------------------
# Introduction to R - Session 1 -----
# -----------------------------------

# --------------------------------------------
## Part 1 - R as a fancy calculator ---------- 
# --------------------------------------------

# R will function very well as a calculator. 
# You have all the standard tools :
# + is add; - is subtract 
# * is multiply;  / is divide
# ^ raises to a power
# sqrt() is the square roots 
# log() is the natural log; exp() is the exponent

# Round brackets can be used (remember BODMAS?) 

# Run this to see what you get:

4 + 5 / 3

# Which is different to 

(4 + 5) / 3 

# Notice how some have empty brackets after them? 
# These are functions and the number you want to evaluate goes into the function eg: 

sqrt(100)

# Question 1: 
##  Find the square root of 5 times 3
# ----------------------------------------


# ----------------------------------------

# All the output that is currently going into the Console is not being saved. 
# You can save using "<-" and then recall that by running what you saved
# eg 

my_sum <- 4 + 5 / 3

# Either running this or printing it will do the same thing:: 

my_sum

print(my_sum)

## Question 2 
# Save the output of your sum from question 1 as "my_next_sum" and output this to the console
# ----------------------------------------
my_next_sum <- 

# ----------------------------------------

# R doesn't really care about spaces. If you can put a single space
# in then you can put as many as you like
## eg 

no_gaps <- 5+2

some_gaps <- 5 + 2

long_gaps <- 5                  +                 2

space <-  5 + 
  
  2

print(no_gaps)
print(some_gaps)  # <- this one is probably the best here, but they're all okay
print(long_gaps)
print(space)

# On the other hand it is *very* sensitive to spaces when they shouldn't be there
# eg see the difference between 

my_gappy_sum <- 5 + 4
print(my_gappy_sum)

my gappy sum <- 5 + 4
print(my gappy sum)

# (Do you spot the warning that R is trying to give you?)

# --------------------------------------------
## Part 2 - The R environment ---------------- 
# --------------------------------------------


# The R environment shows you the objects you have saved -----> 
# The can also be listed with ls()

ls()

# You can remove objects you no longer need / made by accident with rm()

rm(no_gaps)

# Question 3 
# How would you confirm that 'no_gaps' has been removed 
# (Without just looking at the enviroment)
# ----------------------------------------


# ----------------------------------------

# The "type" of object is important as it determines what R will do (or not do with it)
# str() tell you what type of object you have 

str(my_sum)

# Characters are generally denoted by double quotation marks: " " 

print("hello world") 

# Question 4
# Save the phrase "hello world" as an object called `my_phrase`
# ----------------------------------------
my_phrase <- 

# ----------------------------------------

# Putting quotes around a number will make R think this is a character 
# which will prevent you doing any "maths" with it
# eg.

my_confused_number <- "5"

my_confused_number + 3

# Question 5 
# Use a function to find out what type of object this is
# ----------------------------------------


# ----------------------------------------

# --------------------------------------------
## Part 3 - Vectors -------------------------- 
# --------------------------------------------

# R can store multiple objects of the *same type* together in a vector

## The numbers 1-5 can be written like this:

my_numbers_short <- 1:5

# or like this 

my_numbers_long <- c(1,2,3,4,5)

print(my_numbers_short)
print(my_numbers_long)

# A neat way to check that two things are the same is by using 'double equals': ==
# This checks item by item in your vector:

my_numbers_short == my_numbers_long

# or to check everything is the same (i.e. all are TRUE):

all(my_numbers_short == my_numbers_long)

# Question 6 
# Can you write the numbers 1,2,3,4,5,10,20 without writing them all out? 
# Feel free to save them as an object or just print them out
# ----------------------------------------


# ----------------------------------------

# You can then manipulate all the numbers in a vector at one time
# eg 

my_numbers_big <- my_numbers_long * 10

print(my_numbers_big)

# You can select a certain element of a vector using square brackets [ ]
# To select the 3rd item you can do: 

my_numbers_big[3]

# To select more than one item use the same syntax as before
# eg,

my_numbers_big[c(3,5)]

# You can also specify whether to pick a number with TRUE/FALSE 
# (You will see why this is so useful later...)

my_numbers_big[c(FALSE, FALSE, TRUE, FALSE, TRUE)]

