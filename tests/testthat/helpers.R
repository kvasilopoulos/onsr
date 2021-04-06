
skip_if_interactive <- function() {
  testthat::skip_if(interactive())
}

skip_if_http_error <- function() {
  remote_file <- "https://api.beta.ons.gov.uk/v1"
  skip_if(httr::http_error(remote_file))
}
