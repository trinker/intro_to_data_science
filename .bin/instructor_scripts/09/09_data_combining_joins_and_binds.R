##===============
## Combining Data
##===============
## In this demonstration we'll be combining data via joins and binds.
##
## Joins match records in one table to records in another based on a common
## key(s).  Binds are simple stacks or side by side gluing of tabular data.


##==================
## Load dependencies
##==================
## Load the exampledata, tidyverse packages
library(exampledata)
library(tidyverse)

##========
## Joining
##========
## The `exampledata` package contains the following 3 tables for practicing 
##   joins (jp = join practice).  Look at each of them in the console.  
jp_superheroes
jp_publishers
jp_health


## What are the key columns that can be used for joining `jp_superheroes` &
##   `jp_publishers`?


## Perform a left and inner join on these two tables and compare the results.
##   How are they the same and different?  






## Note: The `by` argument explicitly states the key columns.  Key columns can 
##   have different names so long as they have the same content.


##----------------
## Multiple Tables
##----------------
## Now add the health information from the `jp_health` table to the prior join
##    using left joins (retain all records).
jp_superheroes %>%
    left_join(jp_publishers, by = "publisher") %>%
    left_join(jp_health, by = "sex")



##------------------------------
## Gotchas: Different Named Keys
##------------------------------
## As noted above, key columns often have different names.  We can use the `by` 
##   argument to explicitly set the column names as being keyed.  The `carnegie`
##   & `region` data sets are perfect examples of this.  `carnegie` contains a 
##   column called `REGIONID` that matches a column called `ID` in the `Region`
##   data set.  We can use: `by = c('REGIONID' = 'ID')` for keys with different 
##   names.
##
## Let's try joining these two tables.  Select `UNITID` through `CONTROL` columns
##   in the `carnegie` data set in order to see the columns from the `region` 
##   data set easier.  How many rows are in the table?  Why did it grow?





## The problem of tables having many to many connections is common.  Be aware
##   of your table size before and after the merge.  In this case we have 
##   duplicates of the key we're merging on.  We don't actually care about the
##   states so we can remove them and get the distinct rows to make a unique
##   lookup key (10 rows [one for each region] vs. 60 rows).
region2 <- region %>%
    select(-State) %>%
    distinct()

carnegie %>%
    select(UNITID:CONTROL) %>%
    left_join(region2, by = c('REGIONID' = 'ID'))

##------------------------
## Gotchas: Growing Tables
##------------------------
## Sometimes we do expect the table to grow.  For example, the `fake_sales_person`
##   data set has a sales person an an associated region id.  Let's say we 
##   wanted to know the schools each person is responsible for we can join the
##   `fake_sales_person` to the `carnegie` data set and determine the schools
##   each is responsible for.  Select only the `PERSON`, `REGIONID`, & `NAME`
##   columns.
fake_sales_person

## Why does this fail?  How can we fix it?
fake_sales_person %>%
    left_join(carnegie, by = "REGIONID") %>%
    select(PERSON, REGIONID, NAME)






## The main thing to think about is for the keys you're joining do we expect a
##   one to one match or a one to many match.  If the former then a left join
##   will yield the same number of rows as the left table.  If the later we can
##   expect many more rows in the new table.

##---------------------------------------
## Gotchas: Same Name Different Variables
##---------------------------------------
## dplyr will try to determine the join columns automatically by matching names.
##   In theory this sounds good but it is indeed VERY BAD!!!!!!  Be Explicit!!
##
## Run the following code to make the people and pets tables and 
##   then look at them in the console.
people <- data_frame(
    id = 1:3,
    name = c('Larry', 'Curly', 'Moe'),
    petId = c(101, 103, 101)
)

pets <- data_frame(
    id = 101:103,
    name = c('dog', 'cat', 'fish'),
    latin = c('canis lupus familiaris', 'felis catus', 'gallus gallus domesticus')
)

## What is the actual key that links them?
people
pets

## Run the following code without being explicit about the keys.  
##   Did it join correctly?
people %>%
    left_join(pets)




## When we're explicit we get the correct merge but the names are ambiguous.






## Use dplyr's `rename` function to make the names more sensible.










##------------
## A Full Join
##------------
## Occasionally full joins are useful.  All rows from table 1 (left) and table 2 
##  (right) are used.
people %>%
    rename(person_name = name) %>%
    full_join(
        pets %>% 
            rename(pet_type = name), 
        by = c('petId' = 'id')
    )


##-------------------
## Joins for Recoding
##-------------------
## We have used the `case_when` function to recode a variable.  
cereal %>%
    mutate(
        mfr2 = case_when(
            mfr == 'A' ~ 'American Home Food Products', 
            mfr == 'G' ~ 'General Mills', 
            mfr == 'K' ~ 'Kelloggs', 
            mfr == 'N' ~ 'Nabisco', 
            mfr == 'P' ~ 'Post', 
            mfr == 'Q' ~ 'Quaker Oats',
            mfr == 'R' ~ 'Ralston Purina'
        )
    ) %>%
    select(name, mfr, mfr2)

## This is often the right tool but for some tasks the recoding is too numerous 
##   and requires a great deal of time to type.  Often this recoding exists as a 
##   table or a recoding table can easily be made and a left join can be used to 
##   accomplish the same task.  Here we  make a manual lookup table for joining.
lookup <- data_frame(
    mfr = c("A", "G", "K", "N", "P", "Q", "R"),
    mfr2 = c(
        "American Home Food Products", "General Mills", "Kelloggs", 
        "Nabisco", "Post", "Quaker Oats", "Ralston Purina"
    )
)

lookup

cereal %>%
    left_join(lookup, by = "mfr") %>%
    select(name, mfr, mfr2)


##===================
## Binding: Row Binds
##===================
## Use row binds for stacking tables with the same fields.

## Look at the following tables.  What's similar/different?
bp_cyl_8
bp_cyl_6
bp_cyl_4


## We can use the `bind_rows` function from the dplyr package to bind these 
##   together.  
## 
##   - What happened to the columns that we missing in some table?
##   - What information is lost (hint the table names)?


## How can we add the lost cylinder information back?











##======================
## Binding: Column Binds
##======================
## Column binding is the last form of combining data sets.  It is the least used 
##   because it has the strictest assumption: The rows in table 1 all match 
##   exactly (1 to 1) to the rows in table 2.

## Let's build some fake data sets and column bind them together with the 
##   `bind_cols` function.
set.seed(10)
dat_1 <- data_frame(
    v = month.abb,
    w = sample(state.name, size = 12)
)

dat_2 <- data_frame(
    x = rnorm(1:12),
    y = LETTERS[1:12]
)


dat_3 <- data_frame(
    z = sample(1:12)
)



## Look at the tables we just created
dat_1
dat_2
dat_3

## Bind them together with `bind_rows`
bind_cols(dat_1, dat_2, dat_3)

