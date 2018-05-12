file.types <- c('pdf', 'R', 'sql')
from <- 'assignments'
i <- 1:12
to <- 'sessions'



transfer_assignments <- function(from = 'assignments', to = 'sessions', 
    i = 1:12, file.types = c('pdf', 'R', 'sql'), ...){
    
    lapply(i, function(j){
        try({
            jp <- stringi::stri_pad_left(j, 2, '0')
            fls <- dir(from, paste0('[.](', paste(file.types, collapse = "|"), ')$'), full.names = TRUE)
            outs <- grep(paste0('_', jp, '[._]'), fls, value = TRUE)
            dir.create(file.path(to, jp, 'assignment'), FALSE)
            file.copy(outs, file.path(to, jp, 'assignment'), TRUE, TRUE)
        })
    })
    
}

transfer_slides <- function(from = 'slides', to = 'sessions', 
    i = 1:12, file.types = c('pptx'), ...){
    
    lapply(i, function(j){
        try({
            jp <- stringi::stri_pad_left(j, 2, '0')
            fls <- dir(from, paste0('[.](', paste(file.types, collapse = "|"), ')$'), full.names = TRUE)
            outs <- grep(paste0('/', jp, '_'), fls, value = TRUE)
            # dir.create(file.path(to, jp, 'assignment'), FALSE)
            file.copy(outs, file.path(to, jp), TRUE, TRUE)
        })
    })
    
}


make_student_dir <- function(loc = '.', 
    out = file.path(Sys.getenv("USERPROFILE"),"Desktop/Intro to Data Analysis"), ...){

    path <- gsub("\\s+", "_", out)
    if (path == Sys.getenv("R_HOME")) stop("path can not be `R_HOME`")
    if (file.exists(path)) {
        message(paste0("\"", path, "\" already exists:\nDo you want to overwrite?\n"))
        ans <- menu(c("Yes", "No"))
        if (ans == "2") {
            stop("project aborted")
        }
        else {
            unlink(path, recursive = TRUE, force = FALSE)
        }
    }

    suppressWarnings(invisible(dir.create(path, recursive = TRUE)))
    
    file.copy(
        dir('syllabus', 'syllabus\\.pdf$', full.names = TRUE),
        path
    )
    
    file.copy(
        'sessions',
        path, TRUE, TRUE
    )    
    
    file.copy(
        'readings',
        path, TRUE, TRUE
    )     
}
