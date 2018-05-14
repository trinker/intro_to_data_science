carnegie %>%
    select(UNITID:CONTROL) %>%
    left_join(region, by = c('REGIONID' = 'ID'))


