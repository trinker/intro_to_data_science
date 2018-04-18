margins <- wegmans %>%
    mutate(
        markup = new_price - wholesale,
        expected_units = 100 * popularity,
        profit = round(expected_units * markup, 0)
    ) %>%
    arrange(department, desc(profit)) %>%
    select(department, item, new_price, popularity, markup:profit) 


