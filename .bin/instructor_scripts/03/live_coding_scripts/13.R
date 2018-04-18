wegmans %>%
    mutate(
        product_of_usa2 = case_when(
            product_of_usa == 1 ~ 'Domestic', 
            TRUE ~ 'Import'
        )
    ) %>%
    group_by(department, product_of_usa2) %>%
    summarize(n = length(item))


