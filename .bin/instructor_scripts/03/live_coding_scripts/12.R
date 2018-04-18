wegmans %>%
    mutate(
        product_of_usa2 = case_when(
            product_of_usa == 1 ~ 'Domestic', 
            TRUE ~ 'Import'
        )
    ) %>%
    group_by(product_of_usa2) %>%
    summarize(
        ave_price = mean(new_price)
    )


