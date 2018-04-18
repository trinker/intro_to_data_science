miss6 <- bp_cyl_6 %>%
    mutate(
        hp = case_when(vs == 0 ~ 999, TRUE ~ hp),
        car = case_when(carb == 4 ~ 'NULL', TRUE ~ car) 
    )


