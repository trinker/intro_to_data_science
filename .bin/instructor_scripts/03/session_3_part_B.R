##------------------------------------------------
## THIS SCRIPT IS IN THE SLACK CHANEL
## Do Now (time to struggle): Do Parts I through VI
##------------------------------------------------
## I. Dependencies
## 1. Open RStudio
## 2. Load these packages: 'tidyverse', 'exampledata'
    
##------------------------
## II. Combine multiple querying verbs 
## 1.  Look at the `wegmans` dataset from example data.
## 2.  Select just these columns: 'popularity', 'product_of_usa', 'new_price' and 
##     assign the output to an object names `small_wegmans`.
## 3. Use `small_wegmans` and do the following:
##    
##    A. Break popularity into high (4-5) and low (1-3).  
##    B. Get the average price of items by high/low popularity within domestic/foreign?  
##    C. Arrange the results from highest to lowest average price.


##------------------------
## III. Combine multiple querying verbs 
## 1. Using the full `wegmans` data set, what is the average number of items across 
##    departments?




# -------------- 
# If you get to 
#  here skip to 
#   line 68! Moo!
# --------------- 
#     \   ^__^ 
#      \  (oo)\ ________ 
#         (__)\         )\ /\ 
#              ||------w|
#              ||      ||

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Floating Point: A Tale of Danger and Peril [mini lesson]
## Spoiler...no one dies.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Which item in each department has the largest profit margin?
wegmans %>%
    mutate(change = new_price - wholesale) %>%
    group_by(department) %>%
    mutate(max = max(change)) %>%
    arrange(department, desc(max))


   
## Floating point detour:
##   This should be equal right? :-@
sqrt(2)^2 == 2

## Here's how the number is actually stored.
sprintf("%.20f", sqrt(2)^2)

## So to check for equality of numeric/floats...
near(sqrt(2)^2, 2)
   
## For more on floating point precision see:
## browseURL('https://docs.python.org/3/tutorial/floatingpoint.html')

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## IV. Combine multiple querying verbs 
## 1. Which item had the largest percentage increase in price?



##------------------------
## V. Combine multiple querying verbs 
## 1. Create a price_bucket variable (break at 2.50 & 3.25) [low, medium, high]
## 2. Are cheaper products more popular? (We'll group_by on price_bucket & 
##    find the average popularity per group)


##------------------------
## VI. Combine multiple querying verbs
## Which department had the lowest average change in price?




