
#' available_templates
#'
#' @return A character list with the names of the built-in tepmlates available 
#' in the package
#' 
#' @details 
#' These are the structures defined by the currently available builtin templates:
#' 
#'    \itemize{
#'      \item \bold{\code{basic_template}}
#'         \itemize{
#'            \item \code{data/}
#'               \itemize{
#'                  \item \code{clean/}
#'                  \item \code{raw/}
#'                  }
#'            \item \code{docs/}
#'            \item \code{outputs/}
#'               \itemize{
#'                  \item \code{files/}
#'                  \item \code{reports/}
#'                  }
#'            \item \code{R/}
#'               \itemize{
#'                  \item \code{global.R}
#'                  \item \code{scripts/}
#'                  \item \code{src/}
#'                  }
#'         }
#'         \item \bold{\code{py_template}}
#'         \itemize{
#'           \item \code{data/}
#'           \itemize{
#'             \item \code{clean/}
#'             \item \code{raw/}
#'           }
#'           \item \code{docs/}
#'           \item \code{outputs/}
#'           \itemize{
#'             \item \code{files/}
#'             \item \code{reports/}
#'           }
#'           \item \code{PYTHON/}
#'           \itemize{
#'             \item \code{setup.py}
#'             \item \code{notebooks/}
#'             \item \code{projpkj/}
#'             \itemize{
#'               \item \code{__init__.py}
#'             }
#'             \item \code{scripts/}
#'             \item \code{tests/}
#'           }
#'         }
#'      \item \bold{\code{py_r_template}}: a combination of \code{basic_template} and \code{py_template}
#' }
#' 
#' @encoding UTF-8
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
#' print the files structure described by a builtin template or by a .json file 
#'
#' @param template_name name of the builtin template or the .json file to use
#'
#' @export
#' 
#' @encoding UTF-8
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
#' Verify node integrity while navigating the structure tree
#'
#' @param x \\code{list}, the node to check
#'
#' @return if the node is ok, the node; else, an error is raised.
#' 
#' @keywords internal
#' @encoding UTF-8
#'
#' @examples
#' rprojtree:::check_node(rjson::fromJSON('{"type":"file", "name": "global.R"}'))
#' 
check_node <- function(x) {
  
  error_on <-  FALSE
  error_str <- ""
  
  if (is.null(x$type)) {
    error_on <- TRUE
    error_str <- paste(error_str, "Missing 'type'.\n")
  } else {
    if (!x$type %in% c("dir", "file")) {
      error_on <- TRUE
      error_str <- paste(error_str, "'type' must be one in c('dir', 'file').\n")
    }
  }
  
  if (is.null(x$name)) {
    error_on <- TRUE
    error_str <- paste(error_str, "Missing 'name'.\n")
  } 
  
  if (error_on == TRUE) {
    error_str <- paste(error_str, "Fields found:", paste(names(x), collapse = ", "), "\n")
    stop(error_str)
  }
  
  return(x)
}

#' make_prj_tree
#' 
#' Create a files structure from a builtin template or from a personalised
#' template provided as .json file
#'
#' @param json_str string with the name of the builtin template to use
#' @param file string for the name of the .json file describing a personalised 
#' files structure to use as template
#' @param path string containing which directory to use as root of the files 
#' structure to create
#' @param verbose logical, show or not info while creating th e files structure
#'
#' @export
#' 
#' @encoding UTF-8
#' 
#' @details 
#' 
#' \itemize{
#' \item Only one of \code{json_str} or \code{file} must be supplied. 
#' \item An error is raised if any node in the .json structure is found malformed
#' }
#' 
#' JSON format: 
#' \itemize{
#' \item All the nodes must have a \code{type} and a \code{name}. Allowed 
#' types are \code{dir}, for directories, and \code{file} for files. 
#' \item All the directory nodes can contain any number of subnodes for subdirectories
#' \item The file nodes can include a \code{content} field for the text the file should
#' contain.
#' }
#' 
#' @seealso \code{\link[rprojtree:print_template]{rprojtree::print_template}}, \code{\link[rprojtree:available_templates]{rprojtree::available_templates}}
#' 
#' 
#' @import dplyr
#' @importFrom magrittr %>%
#' 
#' @examples
#' \dontrun{
#' root_path = "..."
#' make_prj_tree(json_str = "basic_template", path = root_path)
#' 
#' my_template <- ".../sample_template.json"
#' make_prj_tree(file = my_template, path = root_path)
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
  else warning(paste("Directory", path, "already exists - nothing done"))
  
  navigate <- function(json_list, path) {
    
    json_list %>% lapply(function(x, path) {
      
      x <- check_node(x)
      
      if (x$type == "file") {
        file_full_name <- file.path(path, x$name)
        if (verbose == TRUE) cat(sprintf("Writing file %s\n", file_full_name))
        if (!file.exists(file_full_name)) {
          file.create(file_full_name)
          if ("content" %in% names(x)) writeLines(x$content, file_full_name)
        } else {
          warning(paste("File", file_full_name, "already exists - nothing done"))
        }
      } else {
        if (x$type == "dir") {
          dir_full_name <- file.path(path, x$name)
          if (verbose == TRUE) cat(sprintf("Creating dir %s\n", dir_full_name))
          if (!dir.exists(dir_full_name)) dir.create(dir_full_name)
          else warning(paste("Directory", dir_full_name, "already exists - nothing done"))
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
  
}
