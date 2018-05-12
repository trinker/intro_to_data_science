wegmans %>%
    group_by(department) %>%
    summarize(
        total_old = sum(old_price), 
        total_new = sum(new_price)
    ) %>%
    mutate(percent_increase = 100 * (total_new - total_old)/total_old) %>%
    arrange(percent_increase)


