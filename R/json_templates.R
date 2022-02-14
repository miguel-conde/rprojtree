str_available_templates <- c("basic_template")

basic_template <- paste0('{
"R": {
        "type": "dir", "name": "R",
        "global_R": {"type": "file", "name": "global.R",
		             "content": "DIR_DATA <- here::here(\'data\')\\n\\nDIR_RAW_DATA <- file.path(DIR_DATA, \'raw\')\\nDIR_CLEAN_DATA <- file.path(DIR_DATA, \'clean\')\\n\\nDIR_OUTPUTS <- here::here(\'outputs\')\\n\\nDIR_OUTPUTS_REPORTS <- file.path(DIR_OUTPUTS, \'reports\')\\nDIR_OUTPUTS_FILES <- file.path(DIR_OUTPUTS, \'files\')"
								 },
        "src": {"type": "dir", "name": "src"},
        "scripts": {"type": "dir", "name": "scripts"}
     },
"docs": {
          "type": "dir", "name": "docs"
        },
"data": {
          "type": "dir", "name": "data",
          "raw": {"type": "dir", "name": "datalake"},
          "clean": {"type": "dir", "name": "datawarehouse"}
        },
"outputs": {
            "type": "dir", "name": "outputs",
            "reports": {"type": "dir", "name": "reports"},
            "files": {"type": "dir", "name": "files"}
           }
}')
