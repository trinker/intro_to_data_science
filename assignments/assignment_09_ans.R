##------------------------------------------------------------------------------
## 1. 
library(nycflights13)
library(tidyverse)

##------------------------------------------------------------------------------
## 2. 
airlines
airports 
flights
planes
weather

?airlines
?airports 
?flights
?planes
?weather

##------------------------------------------------------------------------------
## 3.
## The `year` variable in the `planes` data set is not the same as the `year` 
##    variable in the `flights` data.  Renaming it helps to understand which 
##    year goes with what.  Similarly, `name` in the `airports` and `airlines` 
##    tables are describing different things.
full_flights <- flights %>%
    left_join(
        planes %>%
            rename(build_year = year), 
        by = c("tailnum")
    ) %>%
    left_join(weather, by = c("month", "day", "origin", "hour", "time_hour", "year")) %>%
    left_join(airports, by = c('origin' = 'faa')) %>%
    left_join(
        airlines %>% 
            rename(airline_name = name), 
        by = c("carrier")
    )

##------------------------------------------------------------------------------
## 4.
## A. Yes the number of rows in both `flights` and `full_flights` is 336,776.
## B. The matching is one to one because the table did not grow.

##------------------------------------------------------------------------------
## 5. 
full_flights %>%
    count(airline_name) %>%
    arrange(n) %>%
    mutate(airline_name = factor(airline_name, levels = airline_name)) %>%
    ggplot(aes(airline_name, n)) +
        geom_bar(stat = 'identity') +
        coord_flip()

##------------------------------------------------------------------------------
## 6.
full_flights %>%
    group_by(airline_name) %>% 
    summarize(
        ave_year = mean(build_year, na.rm = TRUE)
    ) %>%
    arrange(desc(ave_year))

##------------------------------------------------------------------------------
## 7.
full_flights %>%
    ggplot(aes(build_year)) +
        geom_histogram(binwidth = 1) +
        facet_wrap(~ airline_name, ncol = 2)

## We can make the patterns more meaningful by ordering the facets using the 
##   results from the previous question and filling the facet vertically.
ordering <- full_flights %>%
    group_by(airline_name) %>% 
    summarize(
        ave_year = mean(build_year, na.rm = TRUE)
    ) %>%
    arrange(ave_year) %>%
    pull(airline_name)

full_flights %>%
    mutate(airline_name = factor(airline_name, rev(ordering))) %>%
    ggplot(aes(build_year)) +
        geom_histogram(binwidth = 1) +
        facet_wrap(~ airline_name, ncol = 2, dir = "v")


## Another nice technique for comparing distributions are ridgeline plots
## https://cran.r-project.org/web/packages/ggridges/vignettes/introduction.html
## The code below shows how to make a ridgeline plot ordered by airline average
## plane year taken from the previous answer.
if (!require(ggridges)) install.packages(ggridges)
library(ggridges)


full_flights %>%
    mutate(airline_name = factor(airline_name, ordering)) %>%
    ggplot(aes(build_year, airline_name)) +
        geom_density_ridges()


##------------------------------------------------------------------------------
## 8.
## There are many ways to investigate this question.  Here are 2 possible approaches.
##
## There doesn't appear to be a strong relationship between build year and arrival delays.
full_flights %>%
    ggplot(aes(build_year, arr_delay)) +
        geom_jitter(alpha = .3)


full_flights %>%
    ggplot(aes(build_year, arr_delay)) +
        geom_hex()






