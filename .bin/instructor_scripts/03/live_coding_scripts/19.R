wegmans %>%
    mutate(per_change = round(100*(new_price - old_price)/old_price, 1)) %>%
    arrange(desc(per_change))


