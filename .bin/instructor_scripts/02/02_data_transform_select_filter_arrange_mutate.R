##=================================
## select, filter, arrange & mutate
##=================================
## In this demonstration we'll be interacting with the 4 of the 5 verbs Hadley
##   boasts address 90% of data manipulation problems.  These verbs:
##
##       1. select
##       2. filter
##       3. arrange 
##       4. mutate
##
##   are presented in an order of least to greatest cognitive difficulty.  
##   However, they can be combined and used in any order to accomplish the task
##   at hand.

##==================================================
## Install a pre-built data set package: exampledata
##==================================================
## We will need a package that contains a data set with fake Wegmans grocery items.
##   We have to install the package from GitHub.  Run the 2 lines below to install 
##   the exampledata package.
if (!require("devtools")) install.packages("devtools"); library(devtools)
install_github('trinker/exampledata')


## Now load it via the `library()`  function and view the `wegmans` data set 
##   with the `View()` function. 
library(exampledata)
View(wegmans)


## How can we learn more about the built in data set?
?wegmans

## Load the 'tidyverse' package:
library(tidyverse)




##=======
## piping
##=======
## First a detour, piping.  Un-nest code for easier cognitive parsing.
## Hadley on the pipe:
browseURL('https://www.youtube.com/embed/K-ss_ag2k9E?list=PLNtpLD4WiWbw9Cgcg6IU75u-44TrrN3A4?rel=0;start=1288;end=1383')


## Nested Coding
set.seed(10)
round(mean(rnorm(20)), digits = 2)



## Piping
set.seed(10)
rnorm(20) %>%
    mean() %>%
    round(digits = 2)





##=======
## select
##=======
##  We select variables/columns
wegmans %>%
    select(department, item, new_price, wholesale, old_price ,new_price, popularity)



## We can use the colon operator to select columns from x to y.
wegmans %>%
    select(department, item, wholesale:popularity)



## We can use negation to drop columns.
wegmans %>%
    select(-department, -weight)



## We can drop several columns at once by using the `c()` function.
wegmans %>%
    select(-c(wholesale, old_price, popularity:product_of_usa))



## Try a few select statements on your own.





##=======
## filter 
##=======
## We grab observations/rows
## Comparisons: >, >=, <, <=, != (not equal), ==, %in% 
## Booleans: &, |
browseURL('http://r4ds.had.co.nz/transform.html#logical-operators')

## What items are $3.09?
wegmans %>%
    filter(new_price == 3.09)




## What items are more than $3.09?
wegmans %>%
    filter(new_price > 3.09)




## What items are at least $3.09?
wegmans %>%
    filter(new_price >= 3.09)




## What items are above $3.50 or below $2.00?
wegmans %>%
    filter(new_price < 2.00 | new_price > 3.50)




## What are the items between $2.75 and $3.00?
wegmans %>%
    filter(new_price >= 2.75) %>%
    filter(new_price <= 3.00)



## A nice shortcut for finding things between 2 points
wegmans %>%
    filter(between(new_price, 2.75, 3.00))




## What items are 5 stars popular and cost less than $3.50?
wegmans %>%
    filter(popularity == 5 & new_price > 3.50)




## What are all the items that are dairy, produce, or meat?
wegmans %>%
    filter(department == 'dairy' | department == 'produce' | department == 'meat')




wegmans %>%
    filter(department %in% c('dairy', 'produce', 'meat'))




## Interesting:  You can filter by logical operators on first letters of strings:
wegmans %>%
    filter(item > 'r')



##========
## arrange
##========
## We order all rows by a variable(s)

## What are the most popular to least popular items?
wegmans %>%
    arrange(desc(popularity))




## What are the cheapest to most expensive items?
wegmans %>%
    arrange(new_price)



## descending
wegmans %>%
    arrange(desc(new_price))




## What are the cheapest to most expensive items in each department? 
wegmans %>%
    arrange(desc(department), desc(new_price))




## What are the items that were most recently shipped
wegmans %>%
    arrange(desc(last_shipment))




## Explore the arrange tool a bit more with your own queries.




##=======
## mutate
##=======
## We make a new column from old column(s) [one to one]
## Usually we use window functions 

## What is the unit price on each item?
wegmans %>%
    mutate(unit_price = new_price/weight)




## What is the difference in cost between old and new price? In other words, how
##   much ahs the price gone up?
wegmans %>%
    mutate(change = new_price - old_price)




## What is the percent change in price?
wegmans %>%
    mutate(per_change = 100 * (new_price - old_price)/old_price)





## What is the revenue made per item?
wegmans %>%
    mutate(revenue = new_price - wholesale) %>%
    select(revenue, everything())




## Note that you can mutate more than one column at once:
wegmans %>%
    mutate(
        revenue = new_price - wholesale,
        prop_markup = revenue/wholesale
    )




## Combing verbs: More power
## Select department, item, wholesale, and new_price and answer:
## What are the items that are marked up at least 25% arrangeged from largest to 
##   smallest percent markup?
foo <- wegmans %>%
    select(department:item, wholesale, new_price) %>%
    mutate(per_change = 100*(new_price - wholesale)/wholesale, w = '4') %>%
    arrange(desc(per_change)) %>%
    filter(per_change > 25) 

foo %>%
    mutate(per_change2 = per_change * 2)



##----------
## Bucketing
##----------
## Equal buckets
cut(1:10, 3)

## Cutpoints
cut(1:10, c(2, 6))
cut(1:10, c(0, 2, 6, 10))
cut(1:10, c(0, 2, 6, 10), labels = c('low', 'medium', 'high'))
cut(1:10, c(0, 2, 6, 11), right = FALSE)

## Seeing it together
data_frame(
    i = 1:10,
    equal_bucket = cut(1:10, 3),
    cut_points = cut(1:10, c(0, 2, 6, 10)),
    labeled_cut_points = cut(1:10, c(0, 2, 6, 10), labels = c('low', 'medium', 'high')),
    cut_points_left = cut(1:10, c(0, 2, 6, 11), right = FALSE)    
)


## What are the high, medium, and low priced items?
wegmans %>%
    mutate(
        price_bucket = cut(
            x = new_price, 
            breaks = c(0, 2.5, 3.25, 5), 
            labels = c('low', 'medium', 'high')
        )
    )





##------------
## Re-grouping
##------------
x <- c('boxer', 'poodle', 'Siamese', 'Garfield', 'Odie', 'Fish', 'Sylvester')

case_when(
    x == 'boxer' ~ 'dog'
)



## What items are available as organic, not organic and both (y = yes, n = no)
wegmans %>%
    mutate(
        organic2 = case_when(
            organic == 'y' ~ 'yes', 
            organic == 'n' ~ 'no', 
            TRUE ~ organic
        )
    )




## Practice with mutate.  make some new columns.  Specifically, try:
## 1. A simple +, -, x, or /
## 2. Combining multiple columns
## 3. Bucketing a numeric variable into a categorical variable
## 4. Regrouping: Combine from departments into: 
##      `allergy` (bread + dairy), `meat`, `produce`, & `beverage`

## Combine select, filter, arrange, & mutate to explore the data further.


