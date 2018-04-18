wegmans %>%
    mutate(price_bucket = cut(new_price, c(0, 2.5, 3.25, 5), labels = c('low', 'medium', 'high')))


