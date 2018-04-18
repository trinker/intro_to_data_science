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

.(1)
# library(exampledata)
# View(wegmans)

## How can we learn more about the built in data set?
#! ?wegmans

## Load the 'tidyverse' package:
#! library(tidyverse)




##=======
## piping
##=======
## First a detour, piping.  Un-nest code for easier cognitive parsing.

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

.(2)
# wegmans %>%
#     select(department, item, new_price)





## We can use the colon operator to select columns from x to y.

.(3)
# wegmans %>%
#     select(department, item, wholesale:popularity)





## We can use negation to drop columns.

.(4)
# wegmans %>%
#     select(-department)




## We can drop several columns at once by using the `c()` function.

.(5)
# wegmans %>%
#     select(-c(wholesale, old_price, popularity:product_of_usa))




## Try a few select statements on your own.





##=======
## filter 
##=======
## We grab observations/rows
## Comparisons: >, >=, <, <=, != (not equal), ==, %in% 
## Booleans: &, |
browseURL('http://r4ds.had.co.nz/transform.html#logical-operators')

## What items are $3.09?

.(6)
# wegmans %>%
#     filter(new_price == 3.09)




## What items are more than $3.09?

.(7)
# wegmans %>%
#     filter(new_price > 3.09)




## What items are at least $3.09?

.(8)
# wegmans %>%
#     filter(new_price >= 3.09)




## What items are above $3.50 or below $2.00?

.(9)
# wegmans %>%
#     filter(new_price < 2.00 | new_price > 3.50)




## What are the items between $2.75 and $3.00?

.(10)
# wegmans %>%
#     filter(new_price >= 2.75 & new_price <= 3.00)





.(11)
# wegmans %>%
#     filter(between(new_price, 2.75, 3.00))




## What items are 5 stars popular and cost less than $3.50?

.(12)
# wegmans %>%
#     filter(popularity == 5 & new_price < 3.50)




## What are all the items that are dairy, produce, or meat?

.(13)
# wegmans %>%
#     filter(department == 'dairy' | department == 'produce' | department == 'produce')





.(14)
# wegmans %>%
#     filter(department %in% c('dairy', 'produce', 'produce'))




## Interesting:  You can filter by logical operators on first letters of strings:

.(15)
# wegmans %>%
#     filter(item > 'r')



##========
## arrange
##========
## We order all rows by a variable(s)

## What are the most popular to least popular items?

.(16)
# wegmans %>%
#     arrange(desc(popularity))




## What are the cheapest to most expensive items?

.(17)
# wegmans %>%
#     arrange(new_price)





.(18)
# wegmans %>%
#     arrange(desc(new_price))




## What are the cheapest to most expensive items in each department? 

.(19)
# wegmans %>%
#     arrange(department, new_price)




## What are the items that were most recently shipped

.(20)
# wegmans %>%
#     arrange(desc(last_shipment))




## Explore the arrange tool a bit more with your own queries.




##=======
## mutate
##=======
## We make a new column from old column(s) [one to one]
## Usually we use window functions 

## What is the unit price on each item?

.(21)
# wegmans %>%
#     mutate(unit_price = round(new_price/weight, 2))




## What is the difference in cost between old and new price?

.(22)
# wegmans %>%
#     mutate(change = old_price - new_price)




## What is the percent change in price?

.(23)
# wegmans %>%
#     mutate(per_change = round(100*(old_price - new_price)/old_price, 1))





## What is the revenue made per item?

.(24)
# wegmans %>%
#     mutate(change = new_price - wholesale)




## Note that you can mutate more than one column at once:

.(25)
# wegmans %>%
#     mutate(
#         change = new_price - wholesale,
#         prop_change = change/wholesale
#     )




## Combing verbs: More power
## Select department, item, wholesale, and new_price and answer:
## What are the items that are marked up at least 25% arrangeged from largest to 
##   smallest percent markup?

.(26)
# wegmans %>%
#     select(department:item, wholesale, new_price) %>%
#     mutate(per_change = round(100*(new_price - wholesale)/wholesale, 1)) %>%
#     arrange(desc(per_change)) %>%
#     filter(per_change > 25)




## Bucketing
## What are the high, medium, and low priced items?

.(27)
# wegmans %>%
#     mutate(price_bucket = cut(new_price, c(0, 2.5, 3.25, 5), labels = c('low', 'medium', 'high')))


.(28)
# cut(1:10, 3)


.(29)
# cut(1:10, c(0, 2, 6, 10))




## Re-grouping
## What items are available as organic, not organic and both (y = yes, n = no)

.(30)
# wegmans %>%
#     mutate(organic2 = case_when(organic == 'y' ~ 'yes', organic == 'n' ~ 'no', TRUE ~ organic))




## Practice with mutate.  make some new columns.  Specifically, try:
## 1. A simple +, -, x, or /
## 2. Combining multiple columns
## 3. Bucketing a numeric variable into a categorical variable
## 4. Regrouping: Combine from departments into: 
##      `allergy` (bread + dairy), `meat`, `produce`, & `beverage`

## Combine select, filter, arrange, & mutate to explore the data further.


