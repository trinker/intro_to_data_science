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
# library(exampledata)
# library(tidyverse)

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
# margins <- wegmans %>%
#     mutate(
#         markup = new_price - wholesale,
#         expected_units = 100 * popularity,
#         profit = round(expected_units * markup, 0)
#     ) %>%
#     arrange(department, desc(profit)) %>%
#     select(department, item, new_price, popularity, markup:profit) 

#! View(margins)




##==========
## summarize
##==========
## We summarize a variable into a single value [many to one]
## We use with a summary function

## Is there an practical difference in the average old and new price?
## a. What is the average current price?
# wegmans %>%
#     summarize(ave_new = mean(new_price))


## b. What is the average old price?
# wegmans %>%
#     summarize(ave_old = mean(old_price))


## We can summarize more than one column, or different summary functions on the
##  same column, all in one shot.
# wegmans %>%
#     summarize(
#         ave_new = mean(new_price),
#         ave_old = mean(old_price),
#         med_new = median(new_price),
#         med_old = median(old_price)
#     )





## What is the most and least expensive price?
# wegmans %>%
#     summarize(
#         highest = max(new_price),
#         lowest = min(new_price)
#     )




## How many total items are there?
# wegmans %>%
#     summarize(department_total_items = length(department))




## How many unique departments are there?
# wegmans %>%
#     summarize(departments = length(unique(department)))




## What is the percent of items made in the United States?
# wegmans %>%
#     summarize(prop_usa = 100 * round(mean(product_of_usa), 2))




## What is the standard deviation of weights?
# wegmans %>%
#     summarize(sd = sd(weight))




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
# wegmans %>%
#     group_by(department) %>%
#     summarize(
#         highest = max(new_price),
#         lowest = min(new_price)
#     )




## Is there a difference in average price by domestic products?
# wegmans %>%
#     mutate(
#         product_of_usa2 = case_when(
#             product_of_usa == 1 ~ 'Domestic', 
#             TRUE ~ 'Import'
#         )
#     ) %>%
#     group_by(product_of_usa2) %>%
#     summarize(
#         ave_price = mean(new_price)
#     )




## Within each department, how many items are domestic and foreign?
# wegmans %>%
#     mutate(
#         product_of_usa2 = case_when(
#             product_of_usa == 1 ~ 'Domestic', 
#             TRUE ~ 'Import'
#         )
#     ) %>%
#     group_by(department, product_of_usa2) %>%
#     summarize(n = length(item))




## The `count` function is a shortcut got `group_by` %>% `summarize(length(x)`
# wegmans %>%
#     mutate(
#         product_of_usa2 = case_when(
#             product_of_usa == 1 ~ 'Domestic', 
#             TRUE ~ 'Import'
#         )
#     ) %>%
#     count(department, product_of_usa2)




##======================
## combining query verbs
##======================
## This is where things get powerful...when we can combine the 5 verbs + group_by

## Break popularity into high (4-5) and low (1-3).  What is the average price by
##  high and low popularity and domestic/foreign items?  Arrange the results 
## from highest to lowest average price.
# wegmans %>%
#     mutate(
#         popularity2 = case_when(popularity >= 4 ~ 'High', TRUE ~ 'Low'),
#         product_of_usa2 = case_when(
#             product_of_usa == 1 ~ 'Domestic', 
#             TRUE ~ 'Import'
#         )  
#     ) %>%
#     group_by(popularity2, product_of_usa2) %>%
#     summarize(ave_price = mean(new_price)) %>%
#     arrange(desc(ave_price))



## What is the average number of items across departments?
# wegmans %>%
#     summarize(
#         departments = length(unique(department)),
#         department_total_items = length(department)    
#     ) %>%
#     mutate(ave_items_per_dept = department_total_items/departments)




## Which item in each department has the largest profit margin?
# wegmans %>%
#     mutate(change = new_price - wholesale) %>%
#     group_by(department) %>%
#     filter(change == max(change))




## Which department has the biggest difference int the highest and lowest priced
##   items?
# wegmans %>%
#     group_by(department) %>%
#     summarize(difference = max(new_price) - min(new_price)) %>%
#     arrange(desc(difference))




## Which item had the largest percentage increase in price?
# wegmans %>%
#     mutate(per_change = round(100*(new_price - old_price)/old_price, 1)) %>%
#     arrange(desc(per_change))



## Create a price_bucket variable (break at 2.50 & 3.25), group_by on it, summarize
## Are cheaper products more popular? 
# wegmans %>%
#     mutate(
#         price_bucket = cut(
#             new_price, 
#             breaks = c(0, 2.5, 3.25, 5), 
#             labels = c('low', 'medium', 'high')
#         )
#     ) %>%
#     group_by(price_bucket) %>%
#     summarize(ave_popularity = mean(popularity))




## Which department had the largest average decrease in price?
# wegmans %>%
#     mutate(change = new_price - old_price) %>%
#     group_by(department) %>%
#     summarize(ave_change = mean(change)) %>%
#     arrange(ave_change)




## What are the earliest and oldest last shipment shipments by department?  How
##   many days difference are between the two dates?  Order the output by this 
##   difference.
# wegmans %>%
#     group_by(department) %>%
#     summarize(
#         oldest = min(last_shipment),
#         newest = max(last_shipment)
#     ) %>%
#     mutate(difference = difftime(newest, oldest, units = "days")) %>%
#     arrange(difference)





## Which department had the largest percent increase?
# wegmans %>%
#     group_by(department) %>%
#     summarize(total_old = sum(old_price), total_new = sum(new_price)) %>%
#     mutate(prop_increase = 100*(total_new - total_old)/total_old) %>%
#     arrange(prop_increase)



## Combine select, filter, arrange, mutate, summarize, & group_by to explore 
##   the data further.









