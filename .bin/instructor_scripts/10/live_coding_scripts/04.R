nyc_dachshunds %>%
    mutate(breed = factor(breed, levels = rev(breed))) %>%
    ggplot(aes(breed, prop)) +
        geom_bar(stat = 'identity') +
        coord_flip()


