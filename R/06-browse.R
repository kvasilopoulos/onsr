#' Quickly browse to ONS' developer webpage
#'
#' This function take you to the ONS' developer webpage.
#'
#' @export
#' @return An atomic character vector with the url of the webpage
#' @examples
#' \donttest{
#' ons_browse()
#' }
ons_browse <- function() {
  view_url("https://developer.ons.gov.uk/")
}

#' Quickly browse to dataset's Quality and Methodology Information (QMI)
#'
#' This function take you to the QMI.
#'
#' @inheritParams ons_get
#' @export
#' @return An atomic character vector url with of the webpage
#' @examples
#' \donttest{
#' ons_browse_qmi("cpih01")
#' }
ons_browse_qmi <- function(id = NULL) {
  ons_ds <- ons_datasets()
  assert_valid_id(id, ons_ds)
  id_num <- id_number(id, ons_ds)
  view_url(ons_ds$qmi$href[id_num])
}


view_url <- function(url, open = interactive()) {
  if (open) {
    utils::browseURL(url)
  }
  invisible(url)
}
