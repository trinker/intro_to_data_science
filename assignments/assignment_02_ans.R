##------------------------------------------------------------------------------
## 1.
library(tidyverse)

##------------------------------------------------------------------------------
## 2. 
View(starwars)

##------------------------------------------------------------------------------
## 3. 
?starwars
# Answer: height = cm; mass = kg

##------------------------------------------------------------------------------
## 4.
## negative selection
starwars2 <- starwars %>%
    select(-c(films, vehicles, starships))

## negative selection (colon operator [preferred method])
starwars2 <- starwars %>%
    select(-c(films:starships))

# positive selection (colon operator)
starwars2 <- starwars %>%
    select(name:species)

##------------------------------------------------------------------------------
## 5.
starwars2 %>%
    filter(height > 200)

##------------------------------------------------------------------------------
## 6.
starwars2 %>%
    filter(mass < 50) %>%
    arrange(mass)

##------------------------------------------------------------------------------
## 7.
starwars2 %>%
    mutate(
        height_in = height * 0.3937007874,
        weight_lbs = mass * 2.2046226218
    )

##------------------------------------------------------------------------------
## 8.
starwars2 %>%
    mutate(
        height_in = height * 0.3937007874,
        weight_lbs = mass * 2.2046226218,
        bmi = (weight_lbs/(height_in^2)) * 703
    )

##------------------------------------------------------------------------------
## 9.
starwars2 %>%
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
## 10.
starwars2 %>%
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
    ) %>%
    filter(!is.na(height) & !is.na(mass)) %>%
    #filter(!(is.na(height) | is.na(mass))) %>%  # De Morgan’s law   
    arrange(desc(bmi))



