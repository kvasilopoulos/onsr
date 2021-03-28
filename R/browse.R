#' Quickly browse to ONS's developer webpage
#'
#' This function take you to the ONS's developer webpage and
#' return the URL invisibly.
#'
#' @export
#' @examples
#' ons_browse()
ons_browse <- function() {
  view_url("https://developer.ons.gov.uk/")
}

view_url <- function(url, open = interactive()) {
  if (open) {
    utils::browseURL(url)
  }
  invisible(url)
}
