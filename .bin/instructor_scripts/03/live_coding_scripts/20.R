wegmans %>%
    mutate(
        price_bucket = cut(
            new_price, 
            breaks = c(0, 2.5, 3.25, 5), 
            labels = c('low', 'medium', 'high')
        )
    ) %>%
    group_by(price_bucket) %>%
    summarize(ave_popularity = mean(popularity))


