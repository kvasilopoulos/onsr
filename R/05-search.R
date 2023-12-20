# /dimension-search/datasets/{id}/editions/{edition}/versions/{version}/dimensions/{name}

#' Search for a Dataset
#'
#' @inheritParams ons_get
#'
#' @param name
#'
#'`[character]`. The name of dimension to perform the query. Available dimensions for
#'a specific id at `ons_dim()`.
#'
#' @param query
#'
#'`[character]`. The query.
#'
#' @return A data.frame.
#'
#' @export
#' @examples
#' \donttest{
#' ons_dim("cpih01")
#' ons_search("cpih01", name = "aggregate", query = "cpih1dim1A0")
#' }
ons_search <- function(id, edition = NULL, version = NULL, name = NULL, query = NULL) {
  assert_valid_id(id)
  edition <- edition %||% ons_latest_edition(id)
  version <- version %||% ons_latest_version(id)
  if (is.null(edition) || is.null(version)) {
    stop("You must specify an `edition` and `version`.", call. = FALSE)
  }

  base <- build_base_request(
    `dimension-search` = EMPTY, datasets = id, editions = edition,
    versions = version, dimensions = name)
  req <- paste0(base, "?q=", query)
  res <- make_request(req)
  res %||% return(invisible(NULL))
  raw <- process_response(res)
  raw$items
}
