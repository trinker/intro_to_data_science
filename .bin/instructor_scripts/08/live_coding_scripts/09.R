breed_name_tall %>%
    ggplot(aes(Name, breed, size = n)) +
        geom_point() +
        scale_size(range = c(1, 10))


