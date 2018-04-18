##========================================
## Import/Export Data: Tabular & Graphical
##========================================
## In this demonstration we'll be learning how to:
##
##     1. write and read .csv files
##        - plus make missing values truly missing
##     2. save ggplot2 objects as image files



##==================
## Load dependencies
##==================
## Load the exampledata, tidyverse packages
library(exampledata)
library(tidyverse)

##=============
## Writing .csv
##=============
## Use the `bp_cyl_6` set to:
## 
##   1. Change cells in `hp` column to 999 if `vs` is zero
##   2. Change cells in `car` column to 'NULL' if `carb` is equal to four
##   3. Assign the output to a variable/object called `miss6`

.(1)
# miss6 <- bp_cyl_6 %>%
#     mutate(
#         hp = case_when(vs == 0 ~ 999, TRUE ~ hp),
#         car = case_when(carb == 4 ~ 'NULL', TRUE ~ car) 
#     )

## Write `miss6` to an external .csv file called:
##
##   - 'six_cyl_data_with_missing_values.csv'

.(2)
# write_csv(miss6, path = 'six_cyl_data_with_missing_values.csv')


## Open this and examine your freshly minted .csv file

##=============
## Reading .csv
##=============
## Read the contents of 'six_cyl_data_with_missing_values.csv' back in to R.

.(3)
# read_csv('six_cyl_data_with_missing_values.csv')


## Notice that the input contains 'NULL' (SQL for missing value) and 999.  
##   Convert this to proper missing values when the file is being read in.


#! read_csv('six_cyl_data_with_missing_values.csv', na = c('NA', '', 'NULL', 999))

##-----------
## Skip Lines
##-----------
## Run the following 4 lines of code.  It will make a .csv file in your working 
##   directory.  Open the file up in Excel.  Notice there is meta data at the top
##   that we dobn't want read into R?
cat(
    "Property of awesomesauce,,\n,,\n4/18/2018,,\n,,", 
    "Person,Day,Score\nDoug,1,99\nBart,2,67\nSally,1,87", sep ='\n', 
    file = 'skipped.csv'
)


## Read the file into R via the code below.  Is the table what we want?
## simply add the number of lines to skip as an argument (`skip = 4`).
read_csv('skipped.csv')





##==============
## Saving Images
##==============
## Make a table of counts and relative proportions of all New York dogs that 
##   are dachshunds.  Arrange the summary in descending order.
nyc_dachshunds <- nyc_dogs %>%
    count(breed) %>%
    mutate(prop = n/sum(n)) %>%
    filter(grepl('^Dach', breed)) %>%
    arrange(desc(n))

## Use the `nyc_dachshunds` object we just made to make a ordered, horizontal 
##   barplot showing the proportion of dachshunds types relative to the rest of
##   the `nyc_dogs` data set. Hint: you'll need to make a factor.

.(4)
# nyc_dachshunds %>%
#     mutate(breed = factor(breed, levels = rev(breed))) %>%
#     ggplot(aes(breed, prop)) +
#         geom_bar(stat = 'identity') +
#         coord_flip()

## What story can you tell with the graph?
#! 8 in every 1000 dogs in NYC is a Smooth Dachshund, pretty much as many as the 
#!   rest of the other dachshunds combined.




## Use ggsave tosave the plot to an external .png and .pdf file

.(5)
# ggsave('dachshunds.pdf')
# ggsave('dachshunds.png')





## Use the heigth and width arguments to make a very large (20 x 20) .pdf.  
##   The width and height arguments are in inches.

.(6)
# ggsave('dachshunds2.pdf', width = 20, height = 20)



##=================
## Independent Work
##=================
## Select a data set we've used that you are familiar with and save it as a .csv


## Find a .csv you have on your computer or from the Internet and read it into R.
## You can convert a .xlsx file to .csv in Excel or install the readxl package
## and use the `read_excel` function (works almost identical to `read_csv`).


## Explore the carnegie, traffic_violations, buffalo_snow_tidy, diamonds, and/or
## flights data sets and make interesting plots and/or tables.  Save the plots
## and/or tables to an external file.

