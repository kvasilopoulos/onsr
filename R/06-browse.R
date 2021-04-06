#' Quickly browse to ONS' developer webpage
#'
#' This function take you to the ONS' developer webpage and
#' return the URL invisibly.
#'
#' @export
#' @examples
#' \donttest{
#' ons_browse()
#' }
ons_browse <- function() {
  view_url("https://developer.ons.gov.uk/")
}

#' Quickly browse to dataset's Quality and Methodology Information (QMI)
#'
#' This function take you to the QMI and return the URL invisibly.
#'
#' @inheritParams ons_get
#' @export
#' @examples
#' \donttest{
#' ons_browse_qmi("cpih01")
#' }
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
