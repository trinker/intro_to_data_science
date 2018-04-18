people %>%
    rename(person_name = name) %>%
    left_join(
        pets %>% 
            rename(pet_type = name), 
        by = c('petId' = 'id')
    )


