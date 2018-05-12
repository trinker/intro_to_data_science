margins <- wegmans %>%
    mutate(
        markup = new_price - wholesale,
        expected_units = 100 * popularity,
        profit = expected_units * markup
    ) %>%
    arrange(department, desc(profit)) %>%
    select(department, item, new_price, wholesale, popularity, markup:profit) 


