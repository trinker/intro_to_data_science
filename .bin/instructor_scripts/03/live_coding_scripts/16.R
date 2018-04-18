wegmans %>%
    summarize(
        departments = length(unique(department)),
        department_total_items = length(department)    
    ) %>%
    mutate(ave_items_per_dept = department_total_items/departments)


