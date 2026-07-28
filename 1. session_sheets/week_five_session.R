# -----------------------------------
# Introduction to R - Week 5 --------
# -----------------------------------

# ----------------------------------
## ggplot2 part 1: scatter plots ----
# -----------------------------------

# The `ggplot2()` package is a member of the tidyverse 
# This means you can download and call it separately 
# But if you already loaded the tidyverse package then you already have ggplot 

# ggplot2 uses the 'grammer of graphics' and this is a little different to what we've seen before
# Layers get progressively added to a base to 'finesse' your image 
# The ggplot2 userguide is excellent: https://ggplot2.tidyverse.org/articles/ggplot2.html

# I'm calling these "steps" 

# --------------------------------
## Step 1 - prepare your data ----
# --------------------------------

# This can be the hardest step! 
# ggplot needs your data in the right format for the plot 
# We are starting with the (relatively easy) scatter plot - but will see some other examples later 

# All we need to do for a scatter plot is load our data and make sure it looks okay
# We're sticking with the iris dataset here
# load it if needed: 

iris <- read_csv(file = "data/iris.csv")

# Check both of these are numeric:
str(iris$Sepal.Length)
str(iris$Sepal.Width)

# --------------------------------
## Step 2 - Add the data ---------
# --------------------------------

# First we tell ggplot which dataframe we are using:

ggplot(data = iris) # This won't give an error but it will just produce a blank chart

# We can then add our chart type and define our x and y axes
ggplot(data = iris) + # the plus has to be on the same line
  geom_point(aes(x = Sepal.Length, y = Sepal.Width))

# The size and colour of the points can be changed here 
# If we want them to all be same colour then this is outside the aes()
# eg 

ggplot(data = iris) + 
  geom_point(aes(x = Sepal.Length, 
                 y = Sepal.Width), 
             colour = "red")

# If we want this to depend on a variable in the dataset this goes inside the aes()
# eg 

ggplot(data = iris) + 
  geom_point(aes(x = Sepal.Length, 
                 y = Sepal.Width, 
                 colour = Species))

# This can also be continous
# eg

ggplot(data = iris) + 
  geom_point(aes(x = Sepal.Length, 
                 y = Sepal.Width, 
                 colour = Petal.Width ))

# We can also change the shape (this must be a categorical variable - i.e. 'chr' (character) type)

str(iris$Species)

ggplot(data = iris) + 
  geom_point(aes(x = Sepal.Length, 
                 y = Sepal.Width, 
                 colour = Petal.Width,
                 shape = Species))
  
# --------------------------------
## Step 3 - Format the labels ----
# --------------------------------

# The labels can all be modified 
# The options are: 
## title = 
## subtitle = 
## x = 
## y = 
## colour = (changes the legend title for the colour variable)
## shape = (ditto for the shape variable)

# We're going to save this as an object now 

my_plot <- ggplot(data = iris) + 
  geom_point(aes(x = Sepal.Length, 
                 y = Sepal.Width, 
                 colour = Petal.Width,
                 shape = Species)) + 
  labs(title = "My beautiful plot",
       subtitle = "Isn't it beautiful",
       x = "Septal Length",
       y = "Septal Width",
       colour = "Petal Width")

my_plot

# ----------------------
## Step 4 - Format -----
# ----------------------

# Essentially all elements of the plot can be formatted by adding a `theme()` layer
# For anything not shown today the best way is to look them up: https://ggplot2.tidyverse.org/reference/theme.html
## These need two 'layers' of command
# First what you want to change; what aspect of it you want to change; finally how you want to change it

my_plot + # You could type out the whole plot above - this is just a way to keep things neat
  theme(title = # what we want to modify
          element_text( # which bit of it we want to modify 
            size = 4) # how we want to modify it
        ) 

 my_plot + 
   # The text elements can all be changed with element_text()
   theme(plot.title = element_text(size = 16, 
                              colour = "#0066CC",
                              face = "bold"),
         plot.subtitle = element_text(size = 12, 
                                 colour = "#0066CC",
                                 face = "italic"),
         
         # This can also be used to remove the ticks
         axis.ticks = element_line(colour = "hotpink",
                                   linewidth = 2),
         
         # The panel background can also be made blank (element_blank())
         panel.background = element_rect(fill = "#e6e6ff"),
         
         # Note how you can either change all of them or just the x/y separately
         panel.grid.major.y = element_line(colour = "black"),
         panel.grid.minor = element_line(colour = "lightgrey"),
         panel.grid.major.x = element_blank(), 
         legend.position = "bottom") # "none" here would remove the legend

 # There are some built in themes 
 
 my_plot + 
   theme_minimal()
 
 # Try adding theme_classic() and theme_bw() to my_plot
 # ----------------------------------------
 
 
 # ----------------------------------------
 
 # ------------------------------------------------
 ## ggplot2 part 2: box plot and layering ---------
 # ------------------------------------------------
 
 # Box plots are pretty similar you just need a categorical x and `geom_boxplot()`
 
 ggplot(data = iris) + 
   geom_boxplot(aes(x = Species, y = Sepal.Width))

 # Can you modify this code to add a title and change the y axis? 
 # ----------------------------------------
 
 
 # ----------------------------------------
 
 # Layered plots 
 
 # You can layer plots on top of each other, such as adding the points here
 
 ggplot(data = iris) + 
   geom_boxplot(aes(x = Species, y = Sepal.Width)) + 
   geom_point(aes(x = Species, y = Sepal.Width))
 
 # Note how these are all sitting ontop of each other? 
 # `geom_jitter()` is a variation on `geom_point` that "jitters" the points
 # You can control how much and in which direction they move
 # Here the y axis *is* the value so we only want them to move in the a axis
              
 ggplot(data = iris) + 
   geom_boxplot(aes(x = Species, y = Sepal.Width), 
                outliers = FALSE) + # This is added to stop the outliers being shown 
                                    # as points as we are adding the points on
   geom_jitter(aes(x = Species, y = Sepal.Width, colour = Species),
               height = 0,
               width = 0.2) # Play around with these numbers (I've added colour to make it more obvious)
 
 
 # ------------------------------------------------
 ## ggplot2 part 3: bar chart and layering --------
 # ------------------------------------------------

 iris <- iris %>%
   mutate(Sepal.Width.cat = case_when(Sepal.Width < quantile(iris$Sepal.Width, 1/3) ~ "Small",
                                      Sepal.Width > quantile(iris$Sepal.Width, 2/3) ~ "Large",
                                      TRUE ~ "Medium"))

 
 ggplot(data = iris) + 
   geom_bar(aes(x = Sepal.Width.cat))
 
 # You can to the same thing with summarised data 
 # You just need an odd extra term "stat = identity" 
 
 sepal_width <- iris %>% 
   group_by(Sepal.Width.cat) %>%
   summarise(Count = n())
 
 # See what this looks like
 sepal_width
 
 # Now plot like this: 
 ggplot(data = sepal_width) + 
   geom_bar(aes(x = Sepal.Width.cat, y = Count), 
            stat = "identity")

 # You can fill by another categorical variable
 ggplot(data = iris) + 
   geom_bar(aes(x = Sepal.Width.cat,
                fill = Species))
 
 # You can make proportions with 'position = "fill")
 ggplot(data = iris) + 
   geom_bar(aes(x = Sepal.Width.cat,
                fill = Species), 
            position = "fill") + 
   labs(y = "Proportion")

 # You can choose the colours with scale_fill_ ... 
 # There are some "presets" (just type `scale_fill` and the options will show)
 # but we are going to pick our own
 # (https://colorkit.co/palettes/ is a great resource)
 
 ggplot(data = iris) + 
   geom_bar(aes(x = Sepal.Width.cat,
                fill = Species), 
            position = "fill") + 
   labs(y = "Proportion") + 
   scale_fill_manual(values = c("#003f5c", 
                                "#bc5090",
                                "#ffa600"))

 # ------------------------------------------------
 ## ggplot2 part 4: line chart and layering --------
 # ------------------------------------------------
 
 # We need a new dataset for this 
 # This is one of R's bundled datasets
 # (It is a time series object which is a bit fiddly - we
 # can make it into a dataframe in the same way we did in week 2)

stock_markets <- as.data.frame(datasets::EuStockMarkets)
 
stock_markets$time <- time(datasets::EuStockMarkets)
 
 ggplot(data = stock_markets) + 
   geom_line(aes(x = time, y = DAX))


 # Use pivot longer on all the stock market columns  (c("DAX", "SMI", "CAC", "FTSE"))
 # Complete this code
 # ----------------------------------------
 stock_markets_longer <- stock_markets %>%
   pivot_longer(cols = c("DAX", "SMI", "CAC", "FTSE"), 
                values_to = "amount",
                names_to = "market")
 # ----------------------------------------
 
 # Now make a line plot with all four markets on
 # We now need the same line structure as before but now "market" becomes a colour variable
 # with group = market
 # ----------------------------------------
 stock_market_plot <- ggplot(stock_markets_longer) + 
   geom_line(aes(x = time, y = amount, colour = market))
 
 
 # ----------------------------------------
 
 # Add a title 
 # Improve the x and y axis labels and the legend title
 # Remove the grey background 
 # Only have some light grey horizontal grid lines
 
 # ----------------------------------------
 
 
 
 # ----------------------------------------