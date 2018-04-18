traffic_violations_clean %>%
    mutate(
        hour_of_day = factor(hour_of_day)
    ) %>%
    count(day_of_week, hour_of_day) %>%
    ungroup() %>%
    mutate(weekend = day_of_week %in% c('Sunday', 'Saturday', 'Friday')) %>%  
    ggplot(aes(hour_of_day, n, group = day_of_week, color = day_of_week)) +
        geom_line(aes(linetype = weekend), size = .9)


