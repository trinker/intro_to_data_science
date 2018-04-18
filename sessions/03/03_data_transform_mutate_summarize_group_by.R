##=================================
## mutate, summarize, & group_by
##=================================
## In this demonstration we'll be interacting with the last 2 (mutate &  
##   summarize + group_by) of the 5 verbs Hadley boasts address 90% of data 
##   manipulation problems.  These verbs:
##
##       1. select
##       2. filter
##       3. arrange 
##       4. mutate
##       5. summarize
##
##       AND group_by
##
##   are presented in an order of least to greatest cognitive difficulty.  
##   However, they can be combined and used in any order to accomplish the task
##   at hand.  

##==================
## Load dependencies
##==================
## Load the exampledata & tidyverse packages



## Install the textshape package and load it
if (!require("textshape")) install.packages("textshape"); library(textshape)

## Note that we can see the data sets within a package using:
utils::data(package = 'exampledata')


##=============
## Quick Review
##=============
## [Use the wegmans data set from the exampledata package]
##
## Task 1: If popularity means we can expect to sell 100 units for every level
##   of popularity a month (e.g., a rating of 3 can expect to sell 300 units),
##   how much profit could we expect to see for each item? 
## Task 2: Order the results by department, descending by profit.
## Task 3: Assign to an object.
## Task 4: Drop columns not related to this question.
## Task 5: Use the `View()` function to inspect the data set














##==========
## summarize
##==========
## We summarize a variable into a single value [many to one]
## We use with a summary function

## Is there an practical difference in the average old and new price?
## a. What is the average current price?




## b. What is the average old price?




## We can summarize more than one column, or different summary functions on the
##  same column, all in one shot.












## What is the most and least expensive price?









## How many total items are there?






## How many unique departments are there?






## What is the percent of items made in the United States?






## What is the standard deviation of weights?






##==========
## group_by
##==========
## We apply summarizations (and potentially muattions) across pieces of the 
##   table.



## DEMONSTATION:
## What is the average price by department?
## Description: group_by breaks a data set into pieces on a grouping variable so 
##   that you can apply summary functions across groups.
##
##   This is called the split-apply-combine strategy to data manipulation.
##
##   This is what a group by does:
## 1. Split apart by department
wegmans %>%
    split(.$department)


## 2. Apply the mean summary function across each department's price column 
wegmans  %>%
    split(.$department)%>%
    lapply(function(x) round(mean(x$new_price), 2))


## 3. Combine back together 
wegmans  %>%
    split(.$department)%>%
    lapply(function(x) round(mean(x$new_price), 2)) %>%
    textshape::tidy_list('department', 'ave_price')

## Of course this split-apply-combine can be done with the group_by function 
##   coupled with a summary function.  
wegmans %>%
    group_by(department) %>%
    summarize(ave_price = round(mean(new_price), 2)) %>%
    arrange(desc(ave_price))



## How many items are in each department?
wegmans %>%
    group_by(department) %>%
    summarize(items = length(item))

    
    
    
## What is the most and least expensive price by department?










## Is there a difference in average price by domestic products?















## Within each department, how many items are domestic and foreign?













## The `count` function is a shortcut got `group_by` %>% `summarize(length(x)`












##======================
## combining query verbs
##======================
## This is where things get powerful...when we can combine the 5 verbs + group_by

## Break popularity into high (4-5) and low (1-3).  What is the average price by
##  high and low popularity and domestic/foreign items?  Arrange the results 
## from highest to lowest average price.














## What is the average number of items across departments?










## Which item in each department has the largest profit margin?








## Which department has the biggest difference int the highest and lowest priced
##   items?








## Which item had the largest percentage increase in price?






## Create a price_bucket variable (break at 2.50 & 3.25), group_by on it, summarize
## Are cheaper products more popular? 














## Which department had the largest average decrease in price?









## What are the earliest and oldest last shipment shipments by department?  How
##   many days difference are between the two dates?  Order the output by this 
##   difference.













## Which department had the largest percent increase?








## Combine select, filter, arrange, mutate, summarize, & group_by to explore 
##   the data further.









