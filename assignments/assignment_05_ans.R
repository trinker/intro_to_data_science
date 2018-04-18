##------------------------------------------------------------------------------
## 1. 
library(nycflights13)
library(tidyverse)

##------------------------------------------------------------------------------
## 2. 
View(flights)
?flights

View(diamonds)
?diamonds

##------------------------------------------------------------------------------
## 3.
starwars %>%
    filter(species == 'Human' & !is.na(height)) %>%
    arrange(height) %>%
    mutate(name = factor(name, levels = name)) %>%
    ggplot(aes(name, height)) +
        geom_bar(stat = 'identity') +
        coord_flip()

## Note that the point doesn't require a zero point, making the comparisons
##   between characters to be easier.
starwars %>%
    filter(species == 'Human' & !is.na(height)) %>%
    arrange(height) %>%
    mutate(name = factor(name, levels = name)) %>%
    ggplot(aes(height, name)) +
        geom_point() 


##------------------------------------------------------------------------------
## 4.
## One can use bars or points geoms to map characters and heights.  In addition,
##   one can color bars/points and/or use facets to break out the gender variable
##   patterns.  The code below shows a few possible iterations of plots:

starwars %>%
    filter(species == 'Human' & !is.na(height)) %>%
    arrange(height) %>%
    mutate(name = factor(name, levels = name)) %>%
    ggplot(aes(name, height)) +
        geom_bar(stat = 'identity', aes(fill = gender)) +
        coord_flip()

starwars %>%
    filter(species == 'Human' & !is.na(height)) %>%
    arrange(height) %>%
    mutate(name = factor(name, levels = name)) %>%
    ggplot(aes(height, name)) +
        geom_point(aes(color = gender)) 

starwars %>%
    filter(species == 'Human' & !is.na(height)) %>%
    arrange(height) %>%
    mutate(name = factor(name, levels = name)) %>%
    ggplot(aes(name, height)) +
        geom_bar(stat = 'identity', aes(fill = gender)) +
        coord_flip() +
        facet_grid(gender ~ ., scales = 'free_y', space = 'free_y')

starwars %>%
    filter(species == 'Human' & !is.na(height)) %>%
    arrange(height) %>%
    mutate(name = factor(name, levels = name)) %>%
    ggplot(aes(name, height)) +
        geom_point(aes(color = gender)) +
        coord_flip() +
        facet_grid(gender ~ ., scales = 'free_y', space = 'free_y')

## Oddity: There are no human females taller than human males.


##------------------------------------------------------------------------------
## 5. 
diamonds %>%
    ggplot(aes(carat, price)) +
        geom_point()

diamonds %>%
    ggplot(aes(carat, price)) +
        geom_hex()

##   A. Positive correlation between carat and price.  
##   B. Becomes more spread as price/carat increases.


##------------------------------------------------------------------------------
## 6.
diamonds %>%
    ggplot(aes(price)) +
        geom_histogram(bins = 100)

diamonds %>%
    ggplot(aes(price, fill = color)) +
        geom_histogram(bins = 100)

##------------------------------------------------------------------------------
## 7.
flights %>%
    ggplot(aes(dep_delay, arr_delay)) +
        geom_hex() +
        geom_smooth(method = 'lm', color = 'orange')

## points take a lot more time to render than hexbins because each point must 
##   be plotted.  This approach is not recommended for larger data sets.
flights %>%
    ggplot(aes(dep_delay, arr_delay)) +
        geom_point(alpha = .01) +
        geom_smooth(method = 'lm', color = 'orange')

## There is a very strong positive correlation.  The departure/arrival trend is 
##  more variable with delays < 400.


##------------------------------------------------------------------------------
## 8.
flights %>%
    filter(origin == 'JFK') %>%
    mutate(month = factor(month)) %>%
    group_by(month) %>%
    summarize(med_arr_delay = median(arr_delay, na.rm = TRUE)) %>%
    ggplot(aes(month, med_arr_delay, group = 1)) +
        geom_line(size = 1) +
        geom_point(size = 2)

##  The fall might be the ideal time to fly and arrive on time.  Summer and 
##    winter holidays might make delays more likely.


## Note we could have accomplished the same via boxplots and got more information.
##   In order to do so and not have the outliers dominate the plot area we can 
##   clip the plot at the 10 and 90 percentiles and pass into `coord_cartesian`.
##   This is a more advanced technique but can be useful.
percentiles <- flights %>%
    filter(origin == 'JFK') %>% 
    pull(arr_delay) %>% 
    quantile(c(0.1, 0.9), na.rm = TRUE)
        
flights %>%
    filter(origin == 'JFK') %>%
    mutate(month = factor(month)) %>%
    ggplot(aes(month, arr_delay)) +
        geom_boxplot(outlier.color = NA)+
        coord_cartesian(ylim = percentiles) 

## This reveals that in addition to the patterns above that the fall is more 
##   consistent in arrival delays.  This makes sense if value goes down then 
##   consistency should go up.  This begs the question of there are less flights 
##   in the fall and more over the late summer and winter holidays at JFK.
flights %>%
    filter(origin == 'JFK') %>%
    mutate(month = factor(month)) %>%    
    ggplot(aes(month)) +
        geom_bar()


## There appear to be more flights in July but just as many in August when 
##   delays decrease and become more consistent.  December doesn't have a high 
##   number of flight relative to the rest of the year.  Maybe there is less
##   labor or more passengers during these months that account for the 
##   variability and delay time rather than more flights.



