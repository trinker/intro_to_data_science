library(teach)

# make_lectures()
# make_instructor_scripts_dir()
make_lesson(
    session_number = 1,
    instructor_script_control_file = ".bin/control_scripts/01_intro_to_r.R"
)


make_lesson(
    session_number = 2,
    instructor_script_control_file = ".bin/control_scripts/02_data_transform_select_filter_arrange_mutate.R"
)


make_lesson(
    session_number = 3,
    instructor_script_control_file = ".bin/control_scripts/03_data_transform_mutate_summarize_group_by.R"
)


make_lesson(
    session_number = 4,
    instructor_script_control_file = ".bin/control_scripts/04_viz_grammar_and_theory.R"
)


make_lesson(
    session_number = 5,
    instructor_script_control_file = ".bin/control_scripts/05_viz_design_relationships.R"
)


make_lesson(
    session_number = 6,
    instructor_script_control_file = ".bin/control_scripts/06_intro_to_exploratory_data_analysis.R"
)



make_lesson(
    session_number = 8,
    instructor_script_control_file = ".bin/control_scripts/08_reshaping_data.R"
)



make_lesson(
    session_number = 9,
    instructor_script_control_file = ".bin/control_scripts/09_data_combining_joins_and_binds.R"
)


make_lesson(
    session_number = 10,
    instructor_script_control_file = ".bin/control_scripts/10_r_import_export_data_plots.R"
)

make_lesson(
    session_number = 11,
    instructor_script_control_file = ".bin/control_scripts/11_sql_select_from_where.sql"
)



# make_lesson(
#     session_number = 12,
#     instructor_script_control_file = ".bin/control_scripts/12_sql_count_group_by_join.sql"
# )


source('.bin/additional_scripts.R')
transfer_assignments(i = 1:11)
transfer_slides(i = 1:11)
make_student_dir()





