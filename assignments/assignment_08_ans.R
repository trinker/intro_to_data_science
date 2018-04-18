##------------------------------------------------------------------------------
## 1.
library(tidyverse)
library(exampledata)

##------------------------------------------------------------------------------
## 2. 
bob_ross %>%
    gather(element, n, aurora_borealis:winter) %>%
    group_by(element) %>%
    summarize(n = sum(n)) %>%
    arrange(n) %>%
    mutate(
        element = factor(element, levels = element)
    ) %>%
    ggplot(aes(element, n)) +
        geom_bar(stat = 'identity') +
        coord_flip()


## We could also convert to percentages to say how frequent the elements 
##   were reletive to all episodes (there are 403 episodes)
bob_ross %>%
    gather(element, n, aurora_borealis:winter) %>%
    group_by(element) %>%
    summarize(n = sum(n)) %>%
    arrange(n) %>%
    mutate(
        element = factor(element, levels = element),
        percent = 100 * (n/403)
    ) %>%
    ggplot(aes(element, percent)) +
        geom_bar(stat = 'identity') +
        coord_flip() +
        labs(
            title = 'Bob Ross had a Lot of Happy Accidents that Became Tree(s)!'    
        )


##------------------------------------------------------------------------------
## 3.
set.seed(14)
dat <- data_frame(
    year = c(2017, 2017, 2017, 2017, 2018, 2018, 2018, 2018),
    quarter = paste0('Q', c(1, 2, 3, 4, 1, 2, 3, 4)),
    revenue = rnorm(8, mean = 100000, sd = 20000)
)

dat %>%
    spread(quarter, revenue)




##------------------------------------------------------------------------------
## 4. 
set.seed(14)
dat <- data_frame(
    year = c(2017, 2017, 2017, 2017, 2018, 2018, 2018, 2018),
    quarter = paste0('Q', c(1, 2, 3, 4, 1, 2, 3, 4)),
    revenue = rnorm(8, mean = 100000, sd = 20000)
)

dat %>%
    spread(year, revenue) %>%
    mutate(
        change = `2018` - `2017`,
        per_change = round(100 * (change/`2017`), 0)
    )



