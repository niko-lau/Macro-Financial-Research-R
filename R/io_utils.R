suppressPackageStartupMessages({
  library(readr)
  library(here)
})

#' Resolve a path inside the project root.
proj_path <- function(...) {
  here::here(...)
}

#' Read a CSV file with clear error warning.
read_csv_safe <- function(path) {
  if (!file.exists(path)) {
    stop("File not found: ", path, call. = FALSE)
  }
  readr::read_csv(path, show_col_types = FALSE)
}


#' Safely write a CSV file, creating directories if needed.
write_csv_safe <- function(data, path) {
  dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)
  readr::write_csv(data, path)
  invisible(path)
}


#' Source every .R file inside the project's R/ directory.
source_project_helpers <- function() {
  helper_files <- list.files(proj_path("R"), pattern = "\\.R$", full.names = TRUE)
  for (f in helper_files) {
    source(f)
  }
}


#' Check if the FRED API key is configured.
require_fred_key <- function() {
  key <- Sys.getenv("FRED_API_KEY")
  if (identical(key, "")) {
    stop("FRED_API_KEY is not set. Please configure your .Renviron file.")
  }
}


#' Write raw snapshot of FRED data.
write_raw_snapshot <- function(data, path) {
  write_csv_safe(data, path)
}






