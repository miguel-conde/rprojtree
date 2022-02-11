

#' check_prj
#'
#' Print access to important places in the project
#'
#' @return
#' @export
#'
#' @examples
check_prj <- function() {

  cat(sprintf("DIR TEMPLATES: %s\n", DIR_JSON_TEMPLATES))
  cat(sprintf("BASIC TEMPLATE: %s\n", TEMP_BASIC_1))
  cat(readLines(con = file(TEMP_BASIC_1, "r", blocking = FALSE)))

}
