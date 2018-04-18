##------------------------------------------------------------------------------
## 1.
library(tidyverse)

##------------------------------------------------------------------------------
## 2. 
starwars2 <- starwars %>%
    select(-c(films:starships)) %>%
    mutate(
        height_in = height * 0.3937007874,
        weight_lbs = mass * 2.2046226218,
        bmi = (weight_lbs/(height_in^2)) * 703,
        risk_level = case_when(
            bmi < 18.5 ~ 'Underweight', 
            bmi >= 18.5 & bmi < 25 ~ 'Normal Weight', 
            bmi >= 25 & bmi < 30 ~ 'Overweight', 
            bmi >= 30 ~ 'Obese'
        )     
    ) 

##------------------------------------------------------------------------------
## 3. 
starwars2 %>%
    summarize(
        mean = mean(height, na.rm = TRUE), 
        sd = sd(height, na.rm = TRUE), 
        median = median(height, na.rm = TRUE), 
        maximum = max(height, na.rm = TRUE), 
        minimum = min(height, na.rm = TRUE),
        n = length(height)
    )

## `NA`s returned (except for length)
starwars2 %>%
    summarize(
        mean = mean(height), 
        sd = sd(height), 
        median = median(height), 
        maximum = max(height), 
        minimum = min(height),
        n = length(height)
    )

##------------------------------------------------------------------------------
## 4.
starwars2 %>%
    filter(!is.na(height)) %>%
    summarize(
        mean = mean(height), 
        sd = sd(height), 
        median = median(height), 
        maximum = max(height), 
        minimum = min(height),
        n = length(height)
    )

## Note that n is different.  In #3 we included thm in the count.  
##    Here they have been removed.  In order to not use `filter` and get a 
##    count of non-missing values use this approach:
starwars2 %>%
    summarize(
        mean = mean(height, na.rm = TRUE), 
        n = sum(!is.na(height))
    )

##------------------------------------------------------------------------------
## 5.
starwars2 %>%
    filter(!is.na(bmi)) %>%
    group_by(species) %>%
    summarize(
        mean = mean(bmi), 
        sd = sd(bmi), 
        median = median(bmi), 
        maximum = max(bmi), 
        minimum = min(bmi),
        n = length(bmi)
    ) %>%
    arrange(desc(mean))

##------------------------------------------------------------------------------
## 6.
starwars2 %>%
    filter(!is.na(bmi)) %>%
    group_by(species) %>%
    summarize(
        mean = mean(bmi), 
        sd = sd(bmi), 
        median = median(bmi), 
        maximum = max(bmi), 
        minimum = min(bmi),
        n = length(bmi)
    ) %>%
    filter(n != 1) %>%
    arrange(desc(mean))

##------------------------------------------------------------------------------
## 7.
starwars2 %>%
    group_by(risk_level) %>%
    summarize(
        missing_birth_year = sum(is.na(birth_year)),
        total = length(birth_year)
    ) %>%
    mutate(prop_missing = missing_birth_year/total) %>%
    arrange(prop_missing) 

##------------------------------------------------------------------------------
## 8.
starwars2 %>%
    group_by(hair_color, eye_color) %>%
    summarize(
        n = length(eye_color),
        n2 = n()   # short cut for length(x)
    ) %>%
    filter(n > 1) %>%
    arrange(desc(hair_color, n))

## Shortcut for data + group_by + summarize(n())
starwars2 %>%
    count(hair_color, eye_color) %>%
    filter(n > 1) %>%
    arrange(desc(hair_color, n))
    
##------------------------------------------------------------------------------
## 9.
starwars2 %>%
    count(hair_color, eye_color) %>%
    filter(n > 1) %>%
    arrange(hair_color, desc(n)) %>%
    group_by(hair_color) %>%
    mutate(max = max(n)) %>%
    filter(n == max)

## we could cut out the `mutate` all together, but this is more difficult to reason about
starwars2 %>%
    count(hair_color, eye_color) %>%
    filter(n > 1) %>%
    arrange(hair_color, desc(n)) %>%
    group_by(hair_color) %>%
    filter(n == max(n))

## There is also a `slice` function that can take the first n observation of a 
##   variable that is useful if you've arrange the rows as we have:
starwars2 %>%
    count(hair_color, eye_color) %>%
    filter(n > 1) %>%
    arrange(hair_color, desc(n)) %>%
    group_by(hair_color) %>%
    slice(1)

##------------------------------------------------------------------------------
## 10.
starwars2 %>%
    filter(hair_color == 'none') %>%
    print(n = Inf) # this will print all the rows rather than truncating

##------------------------------------------------------------------------------
## 11.
starwars2 %>%
    group_by(gender) %>%
    summarize(n = length(gender)) %>%
    mutate(perc = 100 * round(n/sum(n), 2)) %>%
    arrange(perc)

## Preferred approach
starwars2 %>%
    count(gender) %>%
    mutate(perc = 100 * round(n/sum(n), 2)) %>%
    arrange(perc)

## Without using a `mutate` after the `summarize` (more difficult cognitively)
starwars2 %>%
    group_by(gender) %>%
    summarize(
        n = length(gender),
        perc = 100 * round(length(gender)/nrow(.), 2)
    ) %>%
    arrange(perc)


