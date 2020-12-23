


`%||%` <- function (x, y) {
  if (is.null(x))
    y
  else x
}

read_csv_silent <- function(...) {
  suppressMessages({
    readr::read_csv(...)
  })
}
