wegmans %>%
    mutate(change = new_price - wholesale) %>%
    group_by(department) %>%
    filter(change == max(change))


