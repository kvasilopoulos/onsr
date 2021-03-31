# /dimension-search/datasets/{id}/editions/{edition}/versions/{version}/dimensions/{name}

#' @examples
#' ons_search("cpih01", name = "aggregate", query = "cpih1dim1A0")
ons_search <- function(id, edition = NULL, version = NULL, name = NULL, query = NULL) {
  edition <- edition %||% ons_latest_edition(id)
  version <- version %||% ons_latest_version(id)

  base <- build_base_request(
    `dimension-search` = EMPTY, datasets = id, editions = edition,
    versions = version, dimensions = name)
  req <- paste0(base, "?q=", query)
  res <- make_request(req)
  raw <- process_response(res)
  raw$items
}
