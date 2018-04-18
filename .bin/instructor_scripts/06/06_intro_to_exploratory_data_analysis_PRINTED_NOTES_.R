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

.(1)
# View(traffic_violations)
# ?traffic_violations




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


.(2)
# wd <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", 
#     "Friday", "Saturday")


.(3)
# traffic_violations_clean <- traffic_violations %>%
#     mutate(
#         `Date Of Stop` = 
#     )  

#! traffic_violations_clean <- traffic_violations %>%
#!     slice(1:50) %>%
#!     mutate(
#!         `Date Of Stop` = mdy(`Date Of Stop`),
#!         year_of_stop = year(`Date Of Stop`),
#!         day_of_week = factor(weekdays(`Date Of Stop`), levels = wd),
#!         hour_of_day = `Time Of Stop` %>%
#!             hour() %>%
#!             as.numeric()
#!     )  


.(4)
# traffic_violations_clean %>% 
#     select(`Date Of Stop`, `Time Of Stop`, year_of_stop:day_of_week)




## How many traffic tickets were issued each year?

.(5)
# traffic_violations_clean %>%
#    count(year_of_stop)

## Have the number of tickets remained constant across the three years?

.(6)
# traffic_violations_clean %>%
#     count(day_of_week)



.(7)
# traffic_violations_clean %>%
#     ggplot(aes(day_of_week)) +
#         geom_bar()


## Are there certain days of the week that traffic tickets are likely to happen?

.(8)
# traffic_violations_clean %>%
#     mutate(hour_of_day = factor(hour_of_day)) %>%
#     ggplot(aes(hour_of_day)) +
#         geom_bar()




.(9)
# traffic_violations_clean %>%
#     mutate(
#         hour_of_day = factor(hour_of_day)
#     ) %>%
#     count(hour_of_day) %>%
#     ggplot(aes(hour_of_day, n)) +
#         geom_line() +
#         geom_point()


#! traffic_violations_clean %>%
#!     mutate(
#!         hour_of_day = factor(hour_of_day)
#!     ) %>%
#!     count(hour_of_day) %>%
#!     ggplot(aes(hour_of_day, n, group = 1)) +
#!         geom_line() +
#!         geom_point()



## Are there certain times of the day and/or days of the week that traffic tickets are likely to happen?

.(10)
# traffic_violations_clean  %>%
#     mutate(
#         hour_of_day = factor(hour_of_day)
#     ) %>%
#     count(day_of_week, hour_of_day) %>%
#     ggplot(aes(hour_of_day, n, group = 1)) +
#         geom_line() +
#         facet_wrap(~day_of_week, ncol = 2)



## Friday, Saturday, & Sunday have different shapes; what's going on?

.(11)
# traffic_violations_clean %>%
#     mutate(
#         hour_of_day = factor(hour_of_day)
#     ) %>%
#     count(day_of_week, hour_of_day) %>%
#     ungroup() %>%
#     mutate(weekend = day_of_week %in% c('Sunday', 'Saturday', 'Friday')) %>%  
#     ggplot(aes(hour_of_day, n, group = day_of_week, color = day_of_week)) +
#         geom_line(aes(linetype = weekend), size = .9)

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



