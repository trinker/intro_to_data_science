people %>%
    left_join(pets, by = c('petId' = 'id'))


