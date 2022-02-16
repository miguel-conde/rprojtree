
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rprojtree

<!-- badges: start -->
<!-- badges: end -->

The goal of rprojtree is to make it easy to structure data science
projects in a convenient way.

rprojtree contains templates (in the current version, only one:
“basic_template”) of ready-to-use project structures. But it also allows
you to use custom templates by supplying them as .json files.

In this way rprojtree makes it easy to create appropriate structures but
does so in an agnostic way, without imposing a particular structure
model.

## Installation

You can install the development version of rprojtree from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("miguel-conde/rprojtree")
```

## Example

This is a basic example which shows you how to create the structure of
directories and files for your project:

``` r
library(rprojtree)
```

You can find out which templates are available in the package using:

``` r
available_templates()
#> [1] "basic_template" "py_template"    "py_r_template"
```

Currently there are 3 templates (basic_template, py_template,
py_r\_template). These templates have .json format. You can view them
using:

``` r
print_template("basic_template")
#> {
#>     "R": {
#>         "type": "dir",
#>         "name": "R",
#>         "global_R": {
#>             "type": "file",
#>             "name": "global.R",
#>             "content": "DIR_DATA <- here::here('data')\n\nDIR_RAW_DATA <- file.path(DIR_DATA, 'raw')\nDIR_CLEAN_DATA <- file.path(DIR_DATA, 'clean')\n\nDIR_OUTPUTS <- here::here('outputs')\n\nDIR_OUTPUTS_REPORTS <- file.path(DIR_OUTPUTS, 'reports')\nDIR_OUTPUTS_FILES <- file.path(DIR_OUTPUTS, 'files')"
#>         },
#>         "src": {
#>             "type": "dir",
#>             "name": "src"
#>         },
#>         "scripts": {
#>             "type": "dir",
#>             "name": "scripts"
#>         }
#>     },
#>     "docs": {
#>         "type": "dir",
#>         "name": "docs"
#>     },
#>     "data": {
#>         "type": "dir",
#>         "name": "data",
#>         "raw": {
#>             "type": "dir",
#>             "name": "raw"
#>         },
#>         "clean": {
#>             "type": "dir",
#>             "name": "clean"
#>         }
#>     },
#>     "outputs": {
#>         "type": "dir",
#>         "name": "outputs",
#>         "reports": {
#>             "type": "dir",
#>             "name": "reports"
#>         },
#>         "files": {
#>             "type": "dir",
#>             "name": "files"
#>         }
#>     }
#> }
#> 
```

The “basic_template” template creates this basic structure:

    <root_path>/data/
    <root_path>/data/clean/
    <root_path>/data/raw/
    <root_path>/docs/
    <root_path>/outputs/
    <root_path>/outputs/files/
    <root_path>/outputs/reports/
    <root_path>/R
    <root_path>/R/global.R
    <root_path>/R/src/
    <root_path>/R/scripts/

It is possible to indicate the text with which a file should be created.
In the case of “basic template” the file
`<root_path>/R/global.Rglobal.R` will contain:

    DIR_DATA <- here::here('data')

    DIR_RAW_DATA <- file.path(DIR_DATA, 'raw')
    DIR_CLEAN_DATA <- file.path(DIR_DATA, 'clean')

    DIR_OUTPUTS <- here::here('outputs')

    DIR_OUTPUTS_REPORTS <- file.path(DIR_OUTPUTS, 'reports')
    DIR_OUTPUTS_FILES <- file.path(DIR_OUTPUTS, 'files')

To finally create the project structure you can choose any of the built
in templates:

``` r
root_path = "..." # Indicate the root directory of the structure

# Use a builtin template
make_prj_tree(json_str = "basic_template", path = root_path)
```

Or provide your own in a .json file:

``` r
# Use your own .json file
my_template <- ".../sample_template.json" 
make_prj_tree(file = my_template, path = root_path)
```
