##=============
## Intro to EDA
##=============
## In this demonstration we'll be using EDA to explore data.  
## EDA is the roughly the following creative process:
##
##    1. Generate questions about your data.
##    2. Search for answers by visualizing & transforming your data.
##    3. Use what you learn to refine your questions and/or generate new questions.
##
## First I'll model the process then you'll choose a data set and run EDA using
##   the data transformation and visualization tools.



##==================
## Load dependencies
##==================
## Load the exampledata, lubridate, tidyverse packages
if (!require("lubridate")) install.packages("lubridate")
library(exampledata)
library(lubridate)
library(tidyverse)


## We'll be using the `traffic_violations` from exampledata. Use `View()` on 
##   this data set and access the help pages to look at the meta data.






##======================
## EDA Initial Questions
##======================
## How many traffic tickets were issued each year?
## Have the number of tickets remained constant across the three years?
## Are there certain times of the day that traffic tickets are likely to happen? 
## Are there certain days of the week that traffic tickets are likely to happen?


##===========
## Variables
##==========
##   Outcome: number of tickets
##   Predictors: hour of day, weekday, year




##-----------
## Cleaning
## Pseudocode
##-----------
## 1. Convert date character to data [lubridate package] 
## 2. Extract year
## 3. Extract day of week
## 4. Extract hour of day


























## How many traffic tickets were issued each year?



## Have the number of tickets remained constant across the three years?









## Are there certain days of the week that traffic tickets are likely to happen?




























## Are there certain times of the day and/or days of the week that traffic tickets are likely to happen?











## Friday, Saturday, & Sunday have different shapes; what's going on?










##==============================
## "Be Skeptical of & with Data"
##==============================
## Given this data set, what's wrong with the following question and EDA?
## I wonder which cars are more likely to get a ticket? 
traffic_violations_clean %>%
    count(Color) %>%
    arrange(desc(n))




## Now it's your turn.  Use EDA to investigate one of the following data sets:
nycflights13::flights
ggplot2::diamonds
exampledata::traffic_violations
exampledata::carnegie



