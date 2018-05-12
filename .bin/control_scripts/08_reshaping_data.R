##===============
## Reshaping Data
##===============
## In this demonstration we'll be reshaping data from wide, untidy form to
##   tall, tidy data
##
## We will also learn some tools for going back the other way (crosstabs).



##==================
## Load dependencies
##==================
## Load the exampledata, tidyverse packages
library(exampledata)
library(tidyverse)

##======================
## Tidying the Professor
##======================
## Create an untidy professor data set that looks like:

##      ---------------------------------------------------
##      |  Professor  | Course_1_Rating | Course_2_Rating |
##      ===================================================
##      | Professor X |              NA |             3.9 |
##      ---------------------------------------------------
##      | Professor Y |             4.4 |             4.3 |
##      ---------------------------------------------------
##      | Professor Z |             4.6 |             4.7 |
##      ---------------------------------------------------

## You'll need the `data_frame` function.  
##   Assign it to a variable names `profdat`.

# profdat <- data_frame(
#     Professor = c("Professor X", "Professor Y", "Professor Z"),
#     Course_1_Rating = c(NA, 4.4, 4.6),
#     Course_2_Rating = c(3.9, 4.3, 4.7)
# )






## Now let's convert this to tidy form via the `gather` function. 

profdat %>%
   gather(Course, Rating, c(Course_1_Rating, Course_2_Rating))




## One can also select negatively or with colons that may save typing
# profdat %>%
#     gather(Course, Rating, -c(Professor))

# profdat %>%
#     gather(Course, Rating, Course_1_Rating:Course_2_Rating)



##=====================
## Tidying Buffalo Snow 
##=====================
## Look at the `buffalo_snow` data sets.  

buffalo_snow




## Let's tidy the snow data set and fix some variables.
##   1. Tidy the data set
##   2. Snow is character; why? Fix.
##   3. Convert the month variable to a factor to control 
##        plot ordering (hint: stringr may be useful here)
##   4. Assign the result to `buff_snow_tall`
# buffalo_snow %>%
#     gather()


#! library(stringr)
#! 
#! buff_snow_tall <- buffalo_snow %>%
#!     gather(Month, Snow, JUL:JUN) %>%
#!     mutate(
#!         Snow = case_when(Snow == 'T' ~ '0', TRUE ~ Snow) %>%
#!             as.numeric(),
#!         Month = Month %>%
#!             str_to_title() %>%
#!             factor(levels = month.abb)
#!     ) 

##------------
## Visualizing
##------------
## Typically, a heatmap or bubble chart are used to view the correlation 
##   between two categorical variables and an intersecting numeric variable
##   like `buff_snow_tall`.

##~~~~~~~~~~~~~~~~~~~~
## GGPLOT2 BOILERPLATE
##~~~~~~~~~~~~~~~~~~~~
## <<DATA>> %>%
##     ggplot(aes(<<CATEGORICAL_1>>, <<CATEGORICAL_2>>, fill = <<NUMERIC>>)) +
##         geom_tile()

## As a heatmap
# buff_snow_tall %>%
#     ggplot(aes(SEASON, Month, fill = Snow)) +
#         geom_tile()


## As a Bubble plot
# buff_snow_tall %>%
#     ggplot(aes(SEASON, Month, size = Snow)) +
#         geom_point() 


#! buff_snow_tall %>%
#!     ggplot(aes(SEASON, Month, size = Snow)) +
#!         geom_point(alpha = .6) +
#!         scale_size(range = c(-1, 6))

##==================
## Tidy Dogs Example
##==================
## Look at the `breed_name` data set. 
breed_name


## Tidy the `breed_name` data set and assign it to an object 
##  called `breed_name_tall` on your own.
# breed_name_tall <- breed_name %>%
#     rename(Total = n) %>%
#     gather(Name, n, Bella:Rocky)


## Visualize the correlation between breeds and names
# breed_name_tall %>%
#     ggplot(aes(Name, breed, fill = n)) +
#         geom_tile()

# breed_name_tall %>%
#     ggplot(aes(Name, breed, size = n)) +
#         geom_point() +
#         scale_size(range = c(1, 10))



##============================
## Untidying for Understanding
##============================
## Sometimes it is easier to understand cross tabulated data.  The **tidyr**
##   function `spread` is the opposite of `gather`.  Let's use an example with
##   the question:
##
## Are some breeds (that have n > 500) more likely to be selectively male?
nyc_dogs %>%
    count(gender, breed) 

#! nyc_dogs %>%
#!     count(gender, breed) %>%
#!     spread(gender, n) %>%
#!     filter((male + female) > 500) %>%
#!     mutate(per_male = male /(male + female)) %>%
#!     arrange(desc(per_male))




##=============
## Tidy and EDA
##=============
## Explore the `bob_ross` data set.  You'll likely want to reshape from 
##   untidy, wide format to tidy, long format.




