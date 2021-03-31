clean_date <- function(x, idx = "Time") {
  x[["Time"]] <- as.Date(paste("01-", x[["Time"]], sep = ""), format = "%d-%b-%y")
  x
}
