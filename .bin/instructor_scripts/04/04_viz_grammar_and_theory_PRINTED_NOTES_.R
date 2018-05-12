##=================================
## viz  grammar & theory
##=================================
## In this demonstration we'll be:
##
##     1. Using visualization theory to select gggplot2 aesthetics to represent 
##          variables.
##     2. Using facetting to gain additional views of the data
##     3. Displaying primary and secondary data components in the same ggplot2
##          plot

##==================
## Load dependencies
##==================
## Load the exampledata & tidyverse packages

.(1)
# library(exampledata)
# library(tidyverse)




## We'll be using the `buffalo_snow_tidy` from example data and `starwars` from
##  the tidyverse package.  Use `View()` on these two data sets.

.(2)
# View(buffalo_snow_tidy)
# View(starwars)




##=====================
## Selecting Aesthetics
##=====================
## What is the distribution of eye colors?
## Count of Eye Color [constant fill value]
starwars %>%
    ggplot(aes(eye_color)) +
        geom_bar(fill = 'orange') 


.(3)
# ggplot(data = starwars, aes(eye_color)) +
#     geom_bar(fill = 'orange') 


#! not runable in this state

.(4)
# starwars %>%
#     group_by(eye_color) %>%
#     summarize(n = length(eye_color)) %>%
#     ggplot(aes(eye_color)) +
#         geom_bar(fill = 'orange') 


## What genders make up the distribution within eye colors?
## Count of Eye Color [fill by gender]
starwars %>%
    ggplot(aes(eye_color)) +
        geom_bar(aes(fill = gender)) 


## Count of Eye Color [fill by gender; w/ coord flip for long x axis text]
starwars %>%
    ggplot(aes(eye_color)) +
        geom_bar(aes(fill = gender)) +
        coord_flip()



## What is the relationship between height and mass?
## Correlation of height & mass reveals outlier [who are you?]
starwars %>%
    ggplot(aes(height, mass)) +
    geom_point()


## Who is the outlier from above? (use your data transformation skills)
starwars %>%
    filter(mass > 250)


## Re-plot without outlier 
starwars %>%
    filter(mass < 250) %>%
    ggplot(aes(height, mass)) +
    geom_point()



## Does the height/mass relationship hold across genders?
## Categorical Variables & Useful Aesthetics
##------------------------------------------
## Categorical = {pre-attentive attributes: color, shape}


.(5)
# Gender = color
starwars %>%
    filter(mass < 250) %>%
    ggplot(aes(height, mass)) +
    geom_point(aes(color = gender))



.(6)
# Gender = shape
starwars %>%
    filter(mass < 250) %>%
    ggplot(aes(height, mass)) +
    geom_point(aes(shape = gender)) +
        scale_shape_manual(values = c(4, 16, 0))

## Available shapes:
browseURL('http://sape.inf.usi.ch/sites/default/files/ggplot2-shape-identity.png')




.(7)
# Gender = coor & shape
starwars %>%
    filter(mass < 250) %>%
    ggplot(aes(height, mass)) +
    geom_point(aes(shape = gender, color = gender)) +
        scale_shape_manual(values = c(4, 16, 0))+
        scale_color_manual(values = c('red', 'black', 'blue'))




## Are older people heavier and taller?
## 3 numeric variables....2-d position & size
##--------------------------------------
## Same correlation from above but  pre-attentive attribute of size mapped 
##   to birth year. Note: Year born (BBY = Before Battle of Yavin)
starwars %>%
    filter(mass < 250) %>%
    ggplot(aes(height, mass)) +
    geom_point(aes(size = birth_year))


## Who is that old, short, light character? (use the data transformation force)
starwars %>%
    filter(mass < 250) %>%
    filter(birth_year > 500)





## Is the correlation between height and weight consistent across species?
##   This is sensation overload...
starwars %>%
    filter(mass < 250) %>%
    ggplot(aes(height, mass)) +
    geom_point(aes(color = species))


## Are there species groups we could combine? (use the data transformation force)
starwars %>%
    filter(mass < 250) %>%
    count(species) %>%
    arrange(desc(n))
    


## Is the correlation between height and weight consistent for humans 
##   and non-humans?
starwars %>%
    filter(mass < 250) %>%
    mutate(human = case_when(species == 'Human' ~ 'Human', TRUE ~ 'Other')) %>%
    ggplot(aes(height, mass)) +
    geom_point(aes(color = human)) 



##=====================
## Facetting
##=====================
## Two types of facetting:
##   - facet_grid (table)
##   - facet_wrap (wrapped from line to line)


## Is the correlation between height and weight consistent for 
##   humans and non-humans?
starwars %>%
    filter(mass < 250) %>%
    mutate(
        human = case_when(
            species == 'Human' ~ 'Human', 
            TRUE ~ 'Other'
        )
    ) %>%
    ggplot(aes(height, mass)) +
    geom_point(aes(color = human)) +
    facet_wrap(~ human, ncol = 1)


## Is the correlation between height and weight consistent for 
##   humans vs. non-humans and males vs. females?
starwars %>%
    filter(mass < 250) %>%
    filter(gender %in% c('male', 'female')) %>%
    mutate(
        human = case_when(
            species == 'Human' ~ 'Human', 
            TRUE ~ 'Other'
        )
    ) %>%
    ggplot(aes(height, mass)) +
    geom_point(aes(color = human)) +
    facet_grid(gender ~ human, scales = 'free_x')

## Note `scales = 'free_x'`







##===========================================
## Adding Summary Geoms (secondary component)
##===========================================
## Sometimes we can use ggplot2 geoms that take raw data and make 
##   summary geoms like the geom_smooth below


## Back to the original correlation between mass and height.
starwars %>%
    filter(mass < 250) %>%
    ggplot(aes(height, mass)) +
    geom_point()

## Quick Styline Detour Demo: Multiple aesthetics set to constant values 
##   (alpha useful for overplotting)
starwars %>%
    filter(mass < 250) %>%
    ggplot(aes(height, mass)) +
    geom_point(alpha = 2/10, shape = 21, fill = "blue", 
        colour = "black", size = 4)


## Adding a regression trend-line
starwars %>%
    filter(mass < 250) %>%
    ggplot(aes(height, mass)) +
    geom_point() +
    geom_smooth(method = 'lm', fill = NA)


## Adding a regression trend-line and facetting by human vs. non-human and 
##   male vs. female w/ margin totals
starwars %>%
    filter(mass < 250) %>%
    filter(gender %in% c('male', 'female')) %>%
    mutate(human = case_when(species == 'Human' ~ 'Human', TRUE ~ 'Other')) %>% 
    ggplot(aes(height, mass)) +
    geom_point(aes(color = human)) +
    geom_smooth(aes(color = human), method = 'lm', fill = NA) +
    facet_grid(gender ~ human, scales = 'free_x', margins = TRUE)

## Note `margins = TRUE`



##=====================================================
## Computing Summary Geoms (secondary components)
##=====================================================
## Sometimes we need to compute the summary data set and supply it
##   directly to a geom as we do with `sumdat` below

## What is the distribution of snow totals across months? [strip plot]
buffalo_snow_tidy %>%
    ggplot(aes(Month, Snow)) +
        geom_jitter(height = 0, width = .2, color = 'gray40', size = .8) 


## Can we add the mean for each month as a point?

## First compute a mean for each month (plus min/max values for later use)
sumdat <- buffalo_snow_tidy %>%
    group_by(Month) %>%
    summarize(
        min = min(Snow),
        max = max(Snow),
        ave = mean(Snow)
    )
    
## Supply this as a data set to a new point geom and provide a new y position
buffalo_snow_tidy %>%
    ggplot(aes(Month, Snow)) +
        geom_jitter(height = 0, width = .2, color = 'gray40', size = .8) +
        geom_point(data = sumdat, aes(y = ave), color = 'red', size = 3)


## Same plot and 2ndary mean but as a segment rather than a point
buffalo_snow_tidy %>%
    ggplot(aes(Month, Snow)) +
    geom_jitter(height = 0, width = .2, color = 'gray40', size = .8) +
    geom_segment(
        data = sumdat, 
        aes(
            y = ave, 
            yend = ave, 
            x = as.numeric(Month) - .2, 
            xend = as.numeric(Month) + .2
        ), 
        color = 'blue',
        size = 1.3
    )


## Add boxes via `geom_crossbar` to represent mean and range (3 values)
buffalo_snow_tidy %>%
    ggplot(aes(Month, Snow)) +
        geom_jitter(height = 0, width = .2, color = 'gray40', size = 1) +
        geom_crossbar(data = sumdat, aes(y =ave, ymin = min, ymax = max), color = 'blue')

## A boxplot gets at similar information but uses the median and 
##   25/75th percentiles (boxplots provide more details about the distribution;
##   5 data points plus highlights outliers)
buffalo_snow_tidy %>%
    ggplot(aes(Month, Snow)) +
        geom_boxplot(fill = NA, color= 'blue') +
        geom_jitter(height = 0, width = .2, color = 'gray40', size = .9)


## We can add a layer to the previous plot with the means (`geom_point`).  
## We can also add the min/max ranges as well (`geom_crossbar`).
##
##   - Does the order we add the geoms matter?
##   - How have we changed the way geom_crossbar displays from when 
##     we used it above? (look at the color and fill aesthetics)
buffalo_snow_tidy %>%
    ggplot(aes(Month, Snow))  +
        geom_crossbar(data = sumdat, aes(y =ave, ymin = min, ymax = max), 
            color = NA, fill = 'lightblue') +
        geom_boxplot(fill = NA, color= 'blue', outlier.color = NA) +
        geom_jitter(height = 0, width = .2, color = 'gray40', size = .9)  +
        geom_point(data = sumdat, aes(y = ave), color = 'blue')


## Is the distribution of snow the same across decades? 
##  Add color aesthetic and map to Decade
##  Does this reveal anything interesting or overwhelm?
buffalo_snow_tidy %>%
    ggplot(aes(Month, Snow)) +
        geom_jitter(height = 0, width = .2, size = 1, aes(color = Decade))


## Facet it to reduce the overplotting.  Does that help?
buffalo_snow_tidy %>%
    ggplot(aes(Month, Snow)) +
        geom_jitter(height = 0, width = .2, size = 1, aes(color = Decade)) +
        facet_wrap(~Decade)



## Summarize the snowfall across months within decades and replot
decade_month_dat <- buffalo_snow_tidy %>%
    group_by(Decade, Month) %>%
    summarize(
        min = min(Snow),
        max = max(Snow),
        ave = mean(Snow)
    )

## Notice the same general distribution?
decade_month_dat %>%
    ggplot(aes(Month, ave)) +
        geom_line(aes(group = Decade))


## Add a summary trend-line 
##   Notice there are two summary data sets being used &
##   `group = Decade` vs. `group = 1`
decade_month_dat %>%
    ggplot(aes(Month, ave)) +
        geom_line(aes(group = Decade), color = 'grey50') +
        geom_line(data = sumdat, aes(group = 1), color = 'blue', size = 1) +
        geom_point(data = sumdat, color = 'blue', size = 1.5, shape = 15)


## What are those decades that have much higher than usual average 
##  snowfalls in December and January?
decade_month_dat %>%
    filter(Month == 'Dec') %>%
    arrange(desc(ave))

decade_month_dat %>%
    filter(Month == 'Jan') %>%
    arrange(desc(ave))

