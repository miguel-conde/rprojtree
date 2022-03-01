str_available_templates <- c("basic_template", "py_template", "py_r_template")

basic_template <- '{
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
          "raw": {"type": "dir", "name": "raw"},
          "clean": {"type": "dir", "name": "clean"}
        },
"outputs": {
            "type": "dir", "name": "outputs",
            "reports": {"type": "dir", "name": "reports"},
            "files": {"type": "dir", "name": "files"}
           }
}'

py_template <- '
{
    "PYTHON": {
        "type": "dir",
        "name": "PYTHON",
        "notebooks" : {
            "type": "dir",
            "name": "notebooks"
        },
        "scripts": {
            "type": "dir",
            "name": "scripts"
        },
        "tests": {
            "type": "dir",
            "name": "tests"
        },
        "project module": {
            "type": "dir",
            "name": "prjpkg",
            "__init__.py": {
              "type": "file",
              "name": "__init__.py"
            }
        },
        "setup": {
            "type": "file",
            "name": "setup.py",
            "content": "from setuptools import setup, find_packages\\n\\nsetup(name=\'projpkg\', version=\'0.1\')"
        }
    },
    "docs": {
        "type": "dir",
        "name": "docs"
    },
    "data": {
        "type": "dir",
        "name": "data",
        "raw": {
            "type": "dir",
            "name": "raw"
        },
        "clean": {
            "type": "dir",
            "name": "clean"
        }
    },
    "outputs": {
        "type": "dir",
        "name": "outputs",
        "reports": {
            "type": "dir",
            "name": "reports"
        },
        "files": {
            "type": "dir",
            "name": "files"
        }
    }
}
'

py_r_template <- '
{
    "R": {
        "type": "dir",
        "name": "R",
        "global_R": {
            "type": "file",
            "name": "global.R",
            "content": "DIR_DATA <- here::here(\'data\')\\n\\nDIR_RAW_DATA <- file.path(DIR_DATA, \'raw\')\\nDIR_CLEAN_DATA <- file.path(DIR_DATA, \'clean\')\\n\\nDIR_OUTPUTS <- here::here(\'outputs\')\\n\\nDIR_OUTPUTS_REPORTS <- file.path(DIR_OUTPUTS, \'reports\')\\nDIR_OUTPUTS_FILES <- file.path(DIR_OUTPUTS, \'files\')"
        },
        "src": {
            "type": "dir",
            "name": "src"
        },
        "scripts": {
            "type": "dir",
            "name": "scripts"
        }
    },
    "PYTHON": {
        "type": "dir",
        "name": "PYTHON",
        "notebooks" : {
            "type": "dir",
            "name": "notebooks"
        },
        "scripts": {
            "type": "dir",
            "name": "scripts"
        },
        "tests": {
            "type": "dir",
            "name": "tests"
        },
        "project module": {
            "type": "dir",
            "name": "prjpkg",
            "__init__.py": {
              "type": "file",
              "name": "__init__.py"
            }
        },
        "setup": {
            "type": "file",
            "name": "setup.py",
            "content": "from setuptools import setup, find_packages\\n\\nsetup(name=\'projpkg\', version=\'0.1\')"
        }
    },
    "docs": {
        "type": "dir",
        "name": "docs"
    },
    "data": {
        "type": "dir",
        "name": "data",
        "raw": {
            "type": "dir",
            "name": "raw"
        },
        "clean": {
            "type": "dir",
            "name": "clean"
        }
    },
    "outputs": {
        "type": "dir",
        "name": "outputs",
        "reports": {
            "type": "dir",
            "name": "reports"
        },
        "files": {
            "type": "dir",
            "name": "files"
        }
    }
}
'