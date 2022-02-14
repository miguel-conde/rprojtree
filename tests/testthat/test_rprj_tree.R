
test_that("missing 'type' is detected", {
  json_probe <- '{"name": "global.R"}'
  expect_error(rprojtree:::check_node(rjson::fromJSON(json_probe)),
               "Missing 'type'..+Fields found: name")
})

test_that("'type' contains a valid value", {
  json_probe <- '{"type":"aaa", "name": "global.R"}'
  expect_error(rprojtree:::check_node(rjson::fromJSON(json_probe)),
               "'type' must be one in c\\('dir', 'file'\\)")
})

test_that("One of json_str or file is needed", {
  testthat::expect_error(make_prj_tree())
})

test_that("Only one of json_str or file is needed", {
  testthat::expect_error(make_prj_tree(json_str = "a", file = "b"))
})

test_that("no error is raised printing a well formatted template", {
  testthat::expect_error(print_template("basic_template"), regexp = NA)
})