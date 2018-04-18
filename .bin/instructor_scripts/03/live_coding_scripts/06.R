wegmans %>%
    summarize(
        highest = max(new_price),
        lowest = min(new_price)
    )


