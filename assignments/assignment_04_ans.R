##------------------------------------------------------------------------------
## 1. 
library(exampledata)
library(tidyverse)

##------------------------------------------------------------------------------
## 2. 
View(wegmans)
?wegmans

##------------------------------------------------------------------------------
## 3.
wegmans %>%
    ggplot(aes(weight, new_price, size = popularity)) +
        geom_point(color = 'gray70', alpha = .7)

##------------------------------------------------------------------------------
## 4.
wegmans %>%
    mutate(organic = case_when(
        organic == 'y' ~ 'yes', 
        organic == 'n' ~ 'no', 
        TRUE ~ organic
    )) %>%
    ggplot(aes(weight, new_price)) +
        geom_point(aes(color = organic, shape = organic))

##------------------------------------------------------------------------------
## 5. 
wegmans %>%
    mutate(organic = case_when(
        organic == 'y' ~ 'yes', 
        organic == 'n' ~ 'no', 
        TRUE ~ organic
    )) %>%
    ggplot(aes(weight, new_price, color = organic)) +
        geom_point(aes(shape = organic)) +
        geom_smooth(method = 'lm', fill = NA)

##------------------------------------------------------------------------------
## 6.
wegmans %>%
    mutate(popularity2 = case_when(
        popularity > 3 ~ '3.high', 
        popularity == 3 ~ '2. medium', 
        popularity < 3 ~ '1. low'
    )) %>%
    ggplot(aes(popularity2)) +
        geom_bar() +
        facet_wrap(~ department, ncol = 2)