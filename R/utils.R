
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


# conditional pkgs --------------------------------------------------------

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

# cat  --------------------------------------------------------------------


cat_ratio <- function(x) {
  cat(
    paste0(
      "Fetched ", x$count, "/", x$total_count,
      " (limit = ", x$limit, ", offset = ", x$offset, ")"),
    "\n")
}


cat_ratio_obs <- function(x) {
  cat(
    paste0(
      "Fetched ", NROW(x$observations), "/", x$total_observations,
      " (limit = ", x$limit, ", offset = ", x$offset, ")"),
    "\n")
}

# cleaning ----------------------------------------------------------------

clean_date <- function(x, idx = "Time") {
  x[["Time"]] <- as.Date(paste("01-", x[["Time"]], sep = ""), format = "%d-%b-%y")
  x
}

