wegmans %>%
    mutate(
        change = new_price - wholesale,
        prop_change = change/wholesale
    )


