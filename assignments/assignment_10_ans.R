##------------------------------------------------------------------------------
## 1.
library(tidyverse)
library(exampledata)

##------------------------------------------------------------------------------
## 2. 
## PROCEDURAL: NO ANSWER


##------------------------------------------------------------------------------
## 3.
## PROCEDURAL: NO ANSWER


##------------------------------------------------------------------------------
## 4. 
## Not that the path names will be different depending on where you stored the files.
data <- read_csv("C:/Users/trinker/Desktop/API_SP.DYN.LE00.IN_DS2_en_csv_v2.csv", skip = 4)
meta <- read_csv("C:/Users/trinker/Desktop/Metadata_Country_API_SP.DYN.LE00.IN_DS2_en_csv_v2.csv") 


##------------------------------------------------------------------------------
## 5. 
life <- data %>%
    left_join(meta, by = "Country Code")


##------------------------------------------------------------------------------
## 6. 
life %>%
    select(-c(`Indicator Name`, `Indicator Code`, X6, X63)) 


##------------------------------------------------------------------------------
## 7. 
life %>%
    select(-c(`Indicator Name`, `Indicator Code`, X6, X63)) %>%
    gather(Year, Age, `1960`:`2017`)


##------------------------------------------------------------------------------
## 8. 
clean_life <- life %>%
    select(-c(`Indicator Name`, `Indicator Code`, X6, X63)) %>%
    gather(Year, Age, `1960`:`2017`) %>%
    mutate(
        Year = as.integer(Year),
        Age = as.numeric(Age)
    )


##------------------------------------------------------------------------------
## 9.
clean_life %>%
    ggplot(aes(Year, Age, group = `Country Name`)) +
        geom_line(alpha = .6) +
        facet_wrap(~Region)


##------------------------------------------------------------------------------
## 10.
## Note that if you set 'group = `Country Name`' globally geom_smooth will try 
##   to use this as it's default.  Either set group = `Country Name` only in the
##   geom_line or add an `aes(group = NULL)` to geom_smooth as shown below.
clean_life %>%
    ggplot(aes(Year, Age)) +
        geom_line(alpha = .5, aes(group = `Country Name`)) +
        geom_smooth(color = 'darkred') +
        facet_wrap(~Region)

clean_life %>%
    ggplot(aes(Year, Age, group = `Country Name`)) +
        geom_line(alpha = .5) +
        geom_smooth(color = 'darkred', aes(group = NULL)) +
        facet_wrap(~Region)

##------------------------------------------------------------------------------
## 11.
## The drop in life expectancy in the late 1980s that is beginning to recover may 
## be associated with the HIV/AIDS epidemic that swept across the region: 
## https://www.avert.org/professionals/hiv-around-world/sub-saharan-africa/overview.


##------------------------------------------------------------------------------
## 12.
clean_life %>%
    ggplot(aes(Year, Age)) +
        geom_line(alpha = .5, aes(group = `Country Name`)) +
        geom_smooth(color = 'darkred') +
        facet_wrap(~IncomeGroup)
