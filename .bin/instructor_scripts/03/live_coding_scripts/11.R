wegmans %>%
    group_by(department) %>%
    summarize(
        highest = max(new_price),
        lowest = min(new_price)
    )


