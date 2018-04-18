wegmans %>%
    mutate(unit_price = round(new_price/weight, 2))


