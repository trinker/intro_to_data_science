wegmans %>%
    mutate(change = new_price - old_price) %>%
    group_by(department) %>%
    summarize(ave_change = mean(change)) %>%
    arrange(ave_change)


