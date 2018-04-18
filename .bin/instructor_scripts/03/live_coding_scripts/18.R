wegmans %>%
    group_by(department) %>%
    summarize(difference = max(new_price) - min(new_price)) %>%
    arrange(desc(difference))


