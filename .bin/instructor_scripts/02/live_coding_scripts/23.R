wegmans %>%
    mutate(per_change = round(100*(old_price - new_price)/old_price, 1))


