wegmans %>%
    mutate(
        product_of_usa2 = case_when(
            product_of_usa == 1 ~ 'Domestic', 
            TRUE ~ 'Import'
        )
    ) %>%
    count(department, product_of_usa2)


