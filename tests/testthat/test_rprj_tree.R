
test_that("missing 'type' is detected", {
  json_probe <- '{"name": "global.R"}'
  expect_warning(rprojtree:::check_node(rjson::fromJSON(json_probe)),
                 "Missing 'type'")
})

# test_that("'type' contains a valid value", {
#   json_probe <- '{"type":"aaa", "name": "global.R"}'
#   expect_warning(rprojtree:::check_node(rjson::fromJSON(json_probe)),
#                  "'type' must be one in c('dir', file')")
# })

test_that("One of json_str or file is needed", {
  testthat::expect_error(make_prj_tree())
})

test_that("Only one of json_str or file is needed", {
  testthat::expect_error(make_prj_tree(json_str = "a", file = "b"))
})