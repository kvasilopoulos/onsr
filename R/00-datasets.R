#' ONS Datasets
#'
#' A grouping of data (editions) with shared dimensions, for example Sex,
#' Age and Geography, and all published history of this group of data.
#' The options in these dimensions can change over time leading to
#' separate editions. For example: Population Estimates for UK, England
#' and Wales, Scotland and Northern Ireland.
#'
#' @importFrom httr GET stop_for_status
#' @importFrom tibble tibble as_tibble
#' @export
#'
#' @return A tibble with the datasets.
#'
#' @examples
#' \donttest{
#' # Find all the information about the data
#' ons_datasets()
#'
#' # Just the ids
#' ons_ids()
#' }
ons_datasets <- function() {
  req <- build_base_request(datasets = EMPTY)
  res <- make_request(req, limit = 60)
  res %||% return(invisible(NULL))
  raw <- process_response(res)
  tbl <- as_tibble(raw$items)
  tbl$links <- as_tibble(tbl$links)
  tbl$qmi <- as_tibble(tbl$qmi)
  tbl
}

#' @export
#' @rdname ons_datasets
ons_ids <- function() {
  x <- ons_datasets()
  x$id
}

#' Description of the Dataset
#'
#' This function provides a description of the important information about a
#' dataset.
#'
#' @inheritParams ons_get
#'
#' @return A description of the requested dataset.
#' @export
#' @seealso `ons_meta()`
#' @examples
#' \donttest{
#' ons_desc("cpih01")
#' }
ons_desc <- function(id = NULL) {
  x <- ons_datasets()
  x %||% return(invisible(NULL))
  assert_valid_id(id, x)

  line <- x[which(x$id == id),]
  cat("Title:", line$title, "\n")
  cat("ID:", id, "\n")
  cat("Keywords:", line$keywords[[1]], "\n")
  cat("-----------\n")
  cat("Description:", line$description,"\n")
  cat("-----------\n")
  cat("Release Frequency:", line$release_frequency , "\n")
  cat("State:", line$state, "\n")
  cat("Next Release:", line$next_release, "\n")
  cat("-----------\n")
  cat("Latest Version:", line$links$latest_version$id, "\n")
  cat("Edition(s):", ons_editions(id), "\n")
}

ons_editions <- function(id = NULL) {
  req <- build_base_request(datasets = id, editions = EMPTY)
  res <- make_request(req)
  res %||% return(invisible(NULL))
  raw <- process_response(res)
  raw$items$edition
}

#' Latest info on ONS Datasets
#'
#' This functions are used to access the latest `href`, `version` and `edition`
#' of a dataset.
#'
#' @inheritParams ons_get
#'
#' @return An atomic character vector with the latest info.
#' @export
#' @name ons_latest
#' @examples
#' \donttest{
#' ons_latest_href("cpih01")
#' ons_latest_version("cpih01")
#' ons_latest_edition("cpih01")
#' }

#' @rdname ons_latest
#' @export
ons_latest_href <- function(id = NULL) {
  x <- ons_datasets()
  x %||% return(invisible(NULL))
  assert_valid_id(id, x)
  id_num <- id_number(id, x)
  x$links$latest_version$href[id_num]
}

#' @export
#' @rdname ons_latest
ons_latest_version <- function(id = NULL) {
  href <- ons_latest_href(id)
  href %||% return(invisible(NULL))
  gsub(".*versions/(.+)", "\\1", href)
}

#' @export
#' @rdname ons_latest
ons_latest_edition <- function(id = NULL) {
  href <- ons_latest_href(id)
  href %||% return(invisible(NULL))
  gsub(".*editions/(.+)/versions.*", "\\1", href)
}

# helpers -----------------------------------------------------------------


id_number <- function(id = NULL, ons_ds = ons_datasets()) {
  which(ons_ds$id == id)
}

