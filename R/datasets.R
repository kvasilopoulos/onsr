#' @importFrom httr GET stop_for_status
#' @importFrom httr GET
#' @export
#' @examples
#'
#' ons_dataset(id = "ageing-population-estimates", edition = "time-series", version = 1)
#'
#' ons_dataset_dims(id = "cpih01", edition = "time-series", version = 3)
#'
#'
#' ons_dataset_dims(id = "cpih01", edition = "time-series", version = 3)
#' ons_dataset_dim_opts(id = "cpih01", edition = "time-series", version = 3, dimension = "geography")
#'
#'
#'
ons_datasets <- function() {
  req <- build_request(datasets = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  as_tibble(raw$items)
}

#
# "dataset": {
#   "id": "cpih01",
#   "edition": "time-series",
#   "version": 6
# },
# "dimensions": [
#   {
#     "name": "geography",
#     "options": [
#       "K02000001"
#     ]
#   }
# ]

ons_ids <- function() {
  x <- ons_datasets()
  x$id
}

ons_latest_href <- function(id = NULL) {
  x <- ons_datasets()
  href <- x$links$latest_version$href
  if(!is.null(id)) {
    id_set <- gsub(".*datasets/(.+)/editions/.*", "\\1", href)
    id_match <- which(id_set %in% id)
    if(length(id_match) != 1) {
      stop("wrong `id` see `ons_ids()`.", call. = FALSE)
    }
    href <- href[id_match]
  }
  href
}


#' @rdname ons_datasets
#' @export
#' @examples
#' ons_dataset(id = "ageing-population-estimates", edition = "time-series", version = 1)
ons_dataset <- function(id = NULL, edition = NULL, version = NULL) {

  if(is.null(edition) & is.null(version)) {
    req <- ons_latest_href(id)
  }else{
    req <- build_request(datasets = id, editions = edition, versions = version)
  }
  res <- make_request(req)
  raw <- process_response(res)
  readr::read_csv(raw$downloads$csv$href)
}

#' @rdname ons_datasets
ons_dataset_dims <- function(id = NULL, edition = NULL, version = NULL) {
  req <- build_request(datasets = id, editions = edition, versions = version, dimensions = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}

#' @rdname ons_datasets
ons_dataset_dim_opts <- function(id = NULL, edition = NULL, version = NULL, dimension = NULL) {
  req <- build_request(datasets = id, editions = edition, versions = version, dimensions = dimension, options = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}

#' @rdname ons_datasets
ons_dataset_meta <- function(id = NULL, edition = NULL, version = NULL) {
  req <- build_request(datasets = id, editions = edition, versions = version, metadata = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}

#' @rdname ons_datasets
ons_dataset_obs <- function(id = NULL, edition = NULL, version = NULL) {
  req <- build_request(datasets = id, editions = edition, versions = version, observations = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}
