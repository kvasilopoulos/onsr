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

#' @rdname ons_browse
ons_browse_qmi <- function(id = NULL) {
  ons_ds <- ons_datasets()
  id_num <- id_number(id, ons_ds)
  view_url(ons_ds$qmi$href[id_num])
}


view_url <- function(url, open = interactive()) {
  if (open) {
    utils::browseURL(url)
  }
  invisible(url)
}
