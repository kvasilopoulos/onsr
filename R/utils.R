
`%||%` <- function (x, y) {
  if (is.null(x))
    y
  else x
}

read_csv_silent <- function(..., type = getOption("onsr.read")) {

  type <- match.arg(type, c("vroom", "data.table", "readr"))
  suppressMessages({
    if(type == "vroom") {
      out <- vroom::vroom(...)
    } else if (type == "data.table"){
      need_pkg("data.table")
      out <- data.table::fread(...)
    } else if (type == "readr"){
      need_pkg("readr")
      out <- readr::read_csv(...)
    }
  })
  out
}

set_read_engine <- function(ons_read = NULL) {
  ons_read <- match.arg(ons_read, c("vroom", "data.table", "readr"))
  options(onsr.read = ons_read)
}

has_pkg <- function(pkg) {
  pkg %in% loadedNamespaces()
}

is_installed <- function(pkg) {
  requireNamespace(pkg, quietly = TRUE)
  # system.file(package = pkg) != ""
}

need_pkg <- function(pkg) {
  if (!is_installed(pkg)) {
    stop("Please install ", pkg, " package", call. = FALSE)
  }
}

