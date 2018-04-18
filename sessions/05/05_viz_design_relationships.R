##=============================
## viz relationships & patterns
##=============================
## In this demonstration we'll be:
##
##     1. Using various geoms to explore specific relationships*
##     2. Finding patterns within those plots
##     3. How to use the R `factor` data type to set ordering
##
## *Relationships include: correlation, distribution, time series, 
##      nominal comparison, parts of a whole     

##==================
## Load dependencies
##==================
## Load the exampledata & tidyverse packages
library(exampledata); library(tidyverse)

## View the cereal and buffalo_snow_tidy data sets that 
##   will be used in this session
View(cereal)
View(buffalo_snow_tidy)





##============
## Correlation
##============
## What's the relationship between  calories and sugars?
cereal %>%
    ggplot(aes(calories, sugars)) + 
        geom_point()

## Note the overplotting because both variables are integers


## geom_jitter (adds slight random variation) can be one way 
##   to alleviate overplotting
cereal %>%
    ggplot(aes(calories, sugars)) + 
        geom_jitter()

## Note the moderate, positive relationship.  
##   Also note observation with ~15 sugars and ~100 calories...outlier?????
## Why is this potential outlier high in sugars and low in calories?
cereal %>%
    filter(calories < 105 & sugars > 14)




## Is there a relationship between fiber and potassium?
cereal %>%
    ggplot(aes(fiber, potass)) +
        geom_jitter()

## Hmm that was interesting.  They often put kid cereals on shelf 2
##   and adult cerals higher on shelf 3.  Is this related?
cereal %>%
    ggplot(aes(fiber, potass)) +
        geom_jitter(aes(color = shelf))

## Note that the coloring is a gradient rather than distinct colors...why?

## Shelf colored as a factor
cereal %>%
    mutate(shelf = factor(shelf)) %>%
    ggplot(aes(fiber, potass)) +
        geom_jitter(aes(color = shelf))

## Facet to see the difference between shelf groups
cereal %>%
    mutate(shelf = factor(shelf)) %>%
    ggplot(aes(fiber, potass)) +
        geom_jitter(aes(color = shelf)) +
        facet_wrap(~shelf, ncol = 1)

## Note:
##   1. A few more extreme fiber value cereals.  Who are they?
##   2. Most everything on shelf 2 is low potassium and fiber.  
##      Are these indeed kid cereals?
##   3. What is that very high fiber and potassium cereal on the kids' shelf (2)? 

## Extreme fiber cereals: Who are they?
cereal %>%
    filter(fiber > 7)

## Is shelf 2 kid cereals?
cereal %>%
    filter(shelf == 2) %>%
    print(n = Inf)

cereal %>%
    filter(shelf != 2) %>%
    print(n = Inf)


## What is this high fiber kid cereal?
cereal %>%
    filter(shelf == 2 & fiber > 4)






##===================
## nominal comparison
##===================
## Answers the question: How do elements of x compare on y?


## What are the most and least sugary cereals?
##   - Use stat = 'identity' in geom bar if you have a y value to pass in.  The
##       default assumes stat = 'count' and counts the groups in a categorical 
##       variable to produce x and y positions.
##   - coord_flip makes long names easier to read.  Try it without coord_flip()
cereal %>%
    filter(sugars > 1) %>%
    ggplot(aes(name, sugars)) +
        geom_bar(stat = 'identity') +
        coord_flip()
        
## Note that the unordered bars are hard to see.  Ordering by the y value makes
##   pattern finding easier.


## Ordering 
## If your questions uses the term 'order'/'sort' & 'plot',
##     the answer is almost always be: "Reorder your factor levels"
cereal %>%
    filter(sugars > 1) %>%
    arrange(sugars) %>%
    mutate(name = factor(name, levels = name)) %>%
    ggplot(aes(name, sugars)) +
        geom_bar(stat = 'identity') +
        coord_flip() +
        theme(axis.text.y = element_text(size = 7))

## Note the use of theme to make axis text smaller and easier to read.
##   While theming is beyond the scope of this course, note that ggplot2
##   plots are customizable and can be made publication quality.


## Points can show the same comparison (don't require zero in the scale)
cereal %>%
    filter(sugars > 1) %>%
    arrange(sugars) %>%
    mutate(name = factor(name, levels = name)) %>%
    ggplot(aes(name, sugars)) +
        geom_point() +
        coord_flip() +
        theme(axis.text.y = element_text(size = 7))




## Follow-up question: Are all the sugary cereals kid cereals (on shelf 2)?
##   Adda fill aesthetic mapped to shelf
cereal %>%
    filter(sugars > 1) %>%
    arrange(sugars) %>%
    mutate(
        name = factor(name, levels = name),
        shelf = factor(shelf)
    ) %>%
    ggplot(aes(name, sugars, fill = shelf)) +
        geom_bar(stat = 'identity') +
        coord_flip() +
        theme(axis.text.y = element_text(size = 7))




##=============
## distribution
##=============
## Answers questions about the spread and shape of distributions.


## What does the distribution of calorie counts look like for these cereals?
##   Note that `binwidth` OR `bins` can be altered.  Adjust this value to see.
cereal %>%
    ggplot(aes(calories)) +
        geom_histogram(binwidth = 10)

## Hmm, most cereals are between 85 and 125 calories.  Note the mass to the far
##   left with fewer calories.  This may be a clump for further examination.


## Does the shape of the calorie distribution hold across vitamin levels?
cereal %>%
    ggplot(aes(calories)) +
        geom_histogram(binwidth = 10) +
        facet_wrap(~vitamins, ncol = 1)

## We can see that the 0 vitamin group have fewer calories in their 
##   distribution as compared to the 100% vitamins group.  This may 
##   indicate that the trade-off of low calorie is vitamins.
##
## For count based histograms it often can be somewhat hard to compare 
##   across groups because histogram uses count by default and some groups 
##   have far fewer observations.








## A density plot (geom_density) can help but the y axis isn't interpretable.
cereal %>%
    ggplot(aes(calories)) +
        geom_density() +
        facet_wrap(~vitamins, ncol = 1)

## An advantage of density plots is that can be overlaid and colored when 
##  the number being compared is smaller.
cereal %>%
    mutate(vitamins = factor(vitamins)) %>% 
    ggplot(aes(calories, color = vitamins)) +
        geom_density(bw = 10)



## Boxplots can also be useful tools for examining distributions
cereal %>%
    mutate(vitamins = factor(vitamins)) %>% 
    ggplot(aes(x = vitamins, y = calories)) +
        geom_boxplot(width = .3)


##=================
## parts of a whole
##=================
## Answers the question of what is the make up of x?


## What is the percent make up of vitamin cereals?
cereal %>%
    mutate(vitamins = factor(vitamins)) %>%
    ggplot(aes(vitamins)) +
        geom_bar()

## We can use dodged bar counts but percentages often make the part of 
##   whole metaphor easier cognitively.  



## The position = 'stacked' bar plot with a color fill works well for 
##   this but still lacks a percentage scale. 
## Note that there is no x position so we assign 1 inside an aes?
cereal %>%
    mutate(vitamins = factor(vitamins)) %>%
    ggplot(aes(x = 1)) +
        geom_bar(position = 'stack', aes(fill = vitamins))

## The position = 'fill' is like the stacked bar but uses a percentage scale.
cereal %>%
    mutate(vitamins = factor(vitamins)) %>%
    ggplot(aes(x = 1)) +
        geom_bar(position = 'fill', aes(fill = vitamins))


## We could have achieved the same thing by manually computing the proportions
##   within a mutate first.  But who has time for that?
cereal %>%
    mutate(
        vitamins = factor(vitamins)
    ) %>%
    count(vitamins) %>%
    mutate(prop = n/sum(n)) %>%
    ggplot(aes(x = 1, y = prop)) +
        geom_bar(stat = 'identity', aes(fill = vitamins))


## Also not that a pie chart is a stacked bar plot in a polar coordinate.  
##   Theta controls the variable (x or y?) that the angle is mapped to.  What
##   happens if we map theta = "x" instead?  
cereal %>%
    mutate(vitamins = factor(vitamins)) %>%
    ggplot(aes(x = 1)) +
        geom_bar(position = 'fill', aes(fill = vitamins)) +
        coord_polar(theta = "y")


## What manufacturer has the biggest percentage of low vitamin cereals?
##   High vitamin cereals?
##
## The techniques above generalize to multiple groups.
## 
## It's hard to read the x axis.  How can we fix this?
cereal %>%
    mutate(
        mfr2 = case_when(
            mfr == 'A' ~ 'American Home Food Products', 
            mfr == 'G' ~'General Mills', 
            mfr == 'K' ~'Kelloggs', 
            mfr == 'N' ~'Nabisco', 
            mfr == 'P' ~'Post', 
            mfr == 'Q' ~'Quaker Oats', 
            mfr == 'R' ~'Ralston Purina'
        ),
        vitamins = factor(vitamins)
    ) %>%
    ggplot(aes(x = mfr2)) +
        geom_bar(position = 'fill', aes(fill = vitamins))

## A more advanced technique for comparison of proportions that gives a common 
##   zero point to all groups requires computing the proportions first and then faceting.
cereal %>%
    mutate(
        mfr2 = case_when(
            mfr == 'A' ~ 'American Home Food Products', 
            mfr == 'G' ~'General Mills', 
            mfr == 'K' ~'Kelloggs', 
            mfr == 'N' ~'Nabisco', 
            mfr == 'P' ~'Post', 
            mfr == 'Q' ~'Quaker Oats', 
            mfr == 'R' ~'Ralston Purina'
        ),
        vitamins = factor(vitamins)
    ) %>%
    count(mfr2, vitamins) %>%
    group_by(mfr2) %>%
    mutate(prop = n/sum(n)) %>%
    ggplot(aes(x = mfr2)) +
        geom_bar(stat = 'identity', aes(fill = vitamins, y = prop)) +
        coord_flip() +
        facet_wrap(~vitamins, ncol = 3)


## For die hard pie chart people we can do pie charts for multiple groups.
cereal %>%
    mutate(
        mfr2 = case_when(
            mfr == 'A' ~ 'American Home Food Products', 
            mfr == 'G' ~'General Mills', 
            mfr == 'K' ~'Kelloggs', 
            mfr == 'N' ~'Nabisco', 
            mfr == 'P' ~'Post', 
            mfr == 'Q' ~'Quaker Oats', 
            mfr == 'R' ~'Ralston Purina'
        ),
        vitamins = factor(vitamins)
    ) %>%
    ggplot(aes(x = 1)) +
        geom_bar(position = 'fill', aes(fill = vitamins)) +
        coord_flip() +
        facet_wrap(~ mfr2) +
        coord_polar(theta = "y")

## "A table is nearly always better than a dumb pie chart; the
##   only worse design than a pie chart is several of them, for 
##   then the viewer is asked to compare quantities located in 
##   spatial disarray both within and between charts"
##                                         -Edward Tufte, 1983-



##============
## time series
##============
## For this last section we'll be examining change over time.  We'll need a
##   data set that reflects change across time.  We'll be using the 
##   `buffalo_snow_tidy` data set.


## Are the snowfall amounts across months generally similar?
buffalo_snow_tidy %>%
    ggplot(aes(Month, Snow, group = Year)) +
        geom_line()



## We can also use boxes to look at change in distributions across time.
## How variable are the snowfall amounts in Buffalo across months?
buffalo_snow_tidy %>%
    ggplot(aes(Month, Snow)) +
        geom_boxplot()

## We can compare Decades via facetting to see if the snowfall is 
##   becoming more/less variable
buffalo_snow_tidy %>%
    ggplot(aes(Month, Snow)) +
        geom_boxplot(outlier.color = 'blue') +
        facet_wrap(~Decade)

## We can flip the month and decade variable mapping to campare within 
##   months easier.  The boxplot allows us to see both central tendency 
##   and variability.
buffalo_snow_tidy %>%
    ggplot(aes(Decade, Snow)) +
        geom_boxplot(outlier.color = 'blue') +
        facet_wrap(~Month)

## Are Feb & Mar becoming more variable? 
## Note the very snowy outlier in October & November in the 2000 
##   decade.  Any guess when the October outlier was?

buffalo_snow_tidy %>%
    filter(Month == 'Oct' & Decade == 2000)










