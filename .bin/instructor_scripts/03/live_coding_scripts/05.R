wegmans %>%
    mutate(per_change = 100 * (new_price - old_price)/old_price) %>%
    arrange(desc(per_change))


