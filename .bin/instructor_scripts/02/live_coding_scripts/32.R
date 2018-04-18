wegmans %>%
    mutate(organic2 = case_when(organic == 'y' ~ 'yes', organic == 'n' ~ 'no', TRUE ~ organic))


