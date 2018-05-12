starwars %>%
    group_by(eye_color) %>%
    summarize(n = length(eye_color)) %>%
    ggplot(aes(eye_color)) +
        geom_bar(fill = 'orange') 


