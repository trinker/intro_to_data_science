jp_superheroes %>%
    left_join(jp_publishers, by = "publisher") %>%
    left_join(jp_health, by = "sex")


