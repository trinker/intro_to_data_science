wegmans %>%
    select(department:item, wholesale, new_price) %>%
    mutate(per_change = round(100*(new_price - wholesale)/wholesale, 1)) %>%
    arrange(desc(per_change)) %>%
    filter(per_change > 25)


