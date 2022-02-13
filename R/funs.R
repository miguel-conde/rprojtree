

#' check_prj
#'
#' Print access to important places in the project
#'
#' @return
#' 
#' @import dplyr
#' @importFrom magrittr %>%
#'
#' @examples 
#' rprojtree:::check_prj()
#' 
check_prj <- function() {

  basic_template %>% rjson::fromJSON()
  

}

#' available_templates
#'
#' @return
#' @export
#'
#' @examples
#' available_templates()
#' 
available_templates <- function() {
  return(str_available_templates)
}

#' print_template
#'
#' @param template_name asdfasdfasd
#'
#' @return
#' @export
#'
#' @examples
#' print_template("basic_template")
#' 
print_template <- function(template_name) {
  template_name <- match.arg(template_name, str_available_templates)
  
  enquo_template <- sym(template_name)
  
  jsonlite::prettify(eval(enquo_template))
}

#' check_node
#'
#' @param x asdfadsfdsa
#'
#' @return
#'
#' @examples
#' rprojtree:::check_node(rjson::fromJSON('{"type":"file", "name": "global.R"}'))
#' 
check_node <- function(x) {
  
  print_on = FALSE
  
  if (is.null(x$type)) {
    print_on <- TRUE
    warning("Missing 'type'")
  } else {
    if (!x$type %in% c("dir", "file")) {
      print_on <- TRUE
      warning("'type' must be one in c('dir', file')")
    }
  }
  
  if (is.null(x$name)) {
    print_on <- TRUE
    warning("Missing 'name'")
  } 
  
  # if (print_on == TRUE) print(names(x))
}

#' make_prj_tree
#'
#' @param json_str asdfasdfasdf
#' @param file asdfasdf
#' @param path asdfasdf
#' @param verbose afsdgasdf
#'
#' @return
#' @export
#' 
#' @details 
#' 
#' @import dplyr
#' @importFrom magrittr %>%
#' 
#' @examples
#' \dontrun{
#' make_prj_tree(json_str = "basic_template", path = "c:/Users/migue/Documents/tmp/rprj_tst/")
#' 
#' make_prj_tree(file = "C:/Users/migue/OneDrive/Documentos/rprj_tree_tst.json", path = "c:/Users/migue/Documents/tmp/rprj_tst/")
#' }
#' 
make_prj_tree <- function(json_str, file, path = ".", verbose = FALSE) {
  
  if (missing(json_str)) {
    if (missing(file)) 
      stop("Either json_str or file must be supplied to make_prj_tree")
    json_txt <- paste(readLines(file, warn = FALSE), collapse = "")
  }
  else {
    if (missing(file) == FALSE) {
      stop("Only one of json_str or file must be supplied to make_prj_tree")
    }
    json_txt <- eval(sym(match.arg(json_str, available_templates())))
  }
  
  if (!dir.exists(path)) dir.create(path)
  
  navigate <- function(json_list, path) {
    
    json_list %>% lapply(function(x, path) {
      
      check_node(x)
      
      if (x$type == "file") {
        file_full_name <- file.path(path, x$name)
        if (verbose == TRUE) cat(sprintf("Writing file %s\n", file_full_name))
        if (!file.exists(file_full_name)) file.create(file_full_name)
        if ("content" %in% names(x)) writeLines(x$content, file_full_name)
      } else {
        if (x$type == "dir") {
          dir_full_name <- file.path(path, x$name)
          if (verbose == TRUE) cat(sprintf("Creating dir %s\n", dir_full_name))
          if (!dir.exists(dir_full_name)) dir.create(dir_full_name)
        }
      }
      
      rest_of_tree_names <- names(x)[! names(x) %in% c("type", "name", "content")]
      
      if (length(rest_of_tree_names) > 0) {
        
        rest_of_tree <- x[rest_of_tree_names]
        navigate(rest_of_tree, file.path(path, x$name))
        
      }
    }, path) %>% 
      invisible()
  }
  
  navigate(json_list = rjson::fromJSON(json_txt), path = path)
  
  # return(0)
  
}
