traffic_violations_clean %>%
    mutate(
        hour_of_day = factor(hour_of_day)
    ) %>%
    count(hour_of_day) %>%
    ggplot(aes(hour_of_day, n)) +
        geom_line() +
        geom_point()


