wegmans %>%
    group_by(department) %>%
    summarize(
        oldest = min(last_shipment),
        newest = max(last_shipment)
    ) %>%
    mutate(difference = difftime(newest, oldest, units = "days")) %>%
    arrange(difference)


