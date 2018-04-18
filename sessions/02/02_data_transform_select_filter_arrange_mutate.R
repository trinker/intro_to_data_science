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



## How can we learn more about the built in data set?


## Load the 'tidyverse' package:





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







## We can use the colon operator to select columns from x to y.







## We can use negation to drop columns.






## We can drop several columns at once by using the `c()` function.






## Try a few select statements on your own.





##=======
## filter 
##=======
## We grab observations/rows
## Comparisons: >, >=, <, <=, != (not equal), ==, %in% 
## Booleans: &, |
browseURL('http://r4ds.had.co.nz/transform.html#logical-operators')

## What items are $3.09?






## What items are more than $3.09?






## What items are at least $3.09?






## What items are above $3.50 or below $2.00?






## What are the items between $2.75 and $3.00?












## What items are 5 stars popular and cost less than $3.50?






## What are all the items that are dairy, produce, or meat?












## Interesting:  You can filter by logical operators on first letters of strings:





##========
## arrange
##========
## We order all rows by a variable(s)

## What are the most popular to least popular items?






## What are the cheapest to most expensive items?












## What are the cheapest to most expensive items in each department? 






## What are the items that were most recently shipped






## Explore the arrange tool a bit more with your own queries.




##=======
## mutate
##=======
## We make a new column from old column(s) [one to one]
## Usually we use window functions 

## What is the unit price on each item?






## What is the difference in cost between old and new price?






## What is the percent change in price?







## What is the revenue made per item?






## Note that you can mutate more than one column at once:









## Combing verbs: More power
## Select department, item, wholesale, and new_price and answer:
## What are the items that are marked up at least 25% arrangeged from largest to 
##   smallest percent markup?









## Bucketing
## What are the high, medium, and low priced items?










## Re-grouping
## What items are available as organic, not organic and both (y = yes, n = no)






## Practice with mutate.  make some new columns.  Specifically, try:
## 1. A simple +, -, x, or /
## 2. Combining multiple columns
## 3. Bucketing a numeric variable into a categorical variable
## 4. Regrouping: Combine from departments into: 
##      `allergy` (bread + dairy), `meat`, `produce`, & `beverage`

## Combine select, filter, arrange, & mutate to explore the data further.


