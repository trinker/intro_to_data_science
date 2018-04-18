traffic_violations_clean  %>%
    mutate(
        hour_of_day = factor(hour_of_day)
    ) %>%
    count(day_of_week, hour_of_day) %>%
    ggplot(aes(hour_of_day, n, group = 1)) +
        geom_line() +
        facet_wrap(~day_of_week, ncol = 2)


