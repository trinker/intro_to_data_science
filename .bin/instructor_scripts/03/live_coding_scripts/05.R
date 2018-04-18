wegmans %>%
    summarize(
        ave_new = mean(new_price),
        ave_old = mean(old_price),
        med_new = median(new_price),
        med_old = median(old_price)
    )


