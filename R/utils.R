
`%||%` <- function (x, y) {
  if (is.null(x))
    y
  else x
}

read_csv_silent <- function(x, type = getOption("onsr.read"), ...) {

  type <- match.arg(type, c("readr", "vroom", "data.table"))
  suppressMessages({
    if(type == "vroom") {
      out <- vroom::vroom(x, ...)
    } else if (type == "data.table"){
      need_pkg("data.table")
      out <- data.table::fread(x, ...)
    } else if (type == "readr"){
      need_pkg("readr")
      out <- readr::read_csv(x, ...)
    }
  })
  out
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

