breed_name_tall <- breed_name %>%
    rename(Total = n) %>%
    gather(Name, n, Bella:Rocky)


