
skip_if_interactive <- function() {
  testthat::skip_if(interactive())
}

skip_if_http_error <- function() {
  remote_file <- "https://api.beta.ons.gov.uk/v1/datasets"
  get_remote_file <- GET(remote_file)
  skip_if(httr::http_error(get_remote_file))
}

expect_null_or_error <- function(x) {
  if (is.null(x)) {
    expect_null(x)
  } else {
    expect_error(x)
  }
}
