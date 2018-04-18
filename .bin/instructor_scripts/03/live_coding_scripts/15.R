wegmans %>%
    mutate(
        popularity2 = case_when(popularity >= 4 ~ 'High', TRUE ~ 'Low'),
        product_of_usa2 = case_when(
            product_of_usa == 1 ~ 'Domestic', 
            TRUE ~ 'Import'
        )  
    ) %>%
    group_by(popularity2, product_of_usa2) %>%
    summarize(ave_price = mean(new_price)) %>%
    arrange(desc(ave_price))


