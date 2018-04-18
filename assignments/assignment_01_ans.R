##------------------------------------------------------------------------------
## 1.
scores <- c(1, 4, 12, 7, 2)

##------------------------------------------------------------------------------
## 2. 
product <- c('CE', 'Outcomes', 'Beacon', 'Engage', 'Insight')

##------------------------------------------------------------------------------
## 3.
library(tidyverse)

##------------------------------------------------------------------------------
## 4.
qrev <- data_frame(
    quarter = c(1, 2, 3, 4),
    revenue = c(16000, 22000, 26000, 17000)
)

# Note there is a shortcut for consecutive integers using a colon as follows:
qrev <- data_frame(
    quarter = 1:4,
    revenue = c(16000, 22000, 26000, 17000)
)

##------------------------------------------------------------------------------
## 5. 
install.packages('car')
library('car')

##------------------------------------------------------------------------------
## 6.
## Adams, G. D. and Fastnow, C. F. (2000) A note on the voting irregularities in 
##  Palm Beach, FL. Formerly at http://madison.hss.cmu.edu/

##------------------------------------------------------------------------------
## 7.
# 13,891

##------------------------------------------------------------------------------
## 8.
library(carnegie)

##------------------------------------------------------------------------------
## 9.
ggplot() +
    geom_bar(data = carnegie, aes(x = BASIC2015)) +
    coord_flip()

##------------------------------------------------------------------------------
## 10.
ggplot() +
    geom_jitter(data = carnegie, aes(x = ROOMS, y = BACCDEG), alpha = .1) 

##------------------------------------------------------------------------------
## 11.
ggplot(data = carnegie, aes(x= ROOMS)) +
    geom_histogram()

ggplot(data = carnegie, aes(x= ROOMS)) +
    geom_histogram(binwidth = 250)

##------------------------------------------------------------------------------
## 12.
ggplot(data = qrev, aes(x = revenue, y = quarter)) +
    geom_point() 

# Above & Beyond: Reverse an axis scale via the `trans` argument in `scale_._xxx`
ggplot(data = qrev, aes(x = revenue, y = quarter)) +
    geom_point() +
    scale_y_continuous(trans = "reverse")

# See `?scale_y_continuous` for more info





