str_available_templates <- c("basic_template")

# global_R_content <- "DIR_DATA <- here::here('data')\\n\\n
#                      DIR_DL_DATA <- file.path(DIR_DATA, 'datalake')\\n
#                      DIR_DW_DATA <- file.path(DIR_DATA, 'datawarehouse')\\n\\n
#                      DIR_OUTPUTS <- here::here('outputs')\\n\\n
#                      DIR_OUTPUTS_REPORTS <- file.path(DIR_OUTPUTS, 'reports')\\n
#                      DIR_OUTPUTS_FILES <- file.path(DIR_OUTPUTS, 'files')"

basic_template_ini <- '{
"R": {
        "type": "dir", "name": "R",
        "global_R": {"type": "file", "name": "global.R"},
        "src": {"type": "dir", "name": "src"},
        "scripts": {"type": "dir", "name": "scripts"}
     },
"docs": {
          "type": "dir", "name": "docs"
        },
"data": {
          "type": "dir", "name": "data",
          "datalake": {"type": "dir", "name": "datalake"},
          "datawarehouse": {"type": "dir", "name": "datawarehouse"}
        },
"outputs": {
            "type": "dir", "name": "outputs",
            "reports": {"type": "dir", "name": "reports"},
            "files": {"type": "dir", "name": "files"}
           }
}'

basic_template <- paste0('{
"R": {
        "type": "dir", "name": "R",
        "global_R": {"type": "file", "name": "global.R",
		             "content": "DIR_DATA <- here::here(\'data\')\\n\\nDIR_DL_DATA <- file.path(DIR_DATA, \'datalake\')\\nDIR_DW_DATA <- file.path(DIR_DATA, \'datawarehouse\')\\n\\nDIR_OUTPUTS <- here::here(\'outputs\')\\n\\nDIR_OUTPUTS_REPORTS <- file.path(DIR_OUTPUTS, \'reports\')\\nDIR_OUTPUTS_FILES <- file.path(DIR_OUTPUTS, \'files\')"
								 },
        "src": {"type": "dir", "name": "src"},
        "scripts": {"type": "dir", "name": "scripts"}
     },
"docs": {
          "type": "dir", "name": "docs"
        },
"data": {
          "type": "dir", "name": "data",
          "datalake": {"type": "dir", "name": "datalake"},
          "datawarehouse": {"type": "dir", "name": "datawarehouse"}
        },
"outputs": {
            "type": "dir", "name": "outputs",
            "reports": {"type": "dir", "name": "reports"},
            "files": {"type": "dir", "name": "files"}
           }
}')
