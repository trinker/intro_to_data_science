bind_rows(
    bp_cyl_8 %>%
        mutate(cyl = 8), 
    bp_cyl_6 %>%
        mutate(cyl = 6), 
    bp_cyl_4 %>%
        mutate(cyl = 4)
)


