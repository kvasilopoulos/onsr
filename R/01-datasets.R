#' ONS Datasets
#'
#' Used to find information about data published by the ONS.
#'
#' @importFrom httr GET stop_for_status
#' @importFrom tibble tibble as_tibble
#' @export
#' @examples
#'
#' ons_dataset(id = "ageing-population-estimates", edition = "time-series", version = 1)
#' ons_dataset(id = "ageing-population-estimates")
#'
#' ons_dataset_dims(id = "cpih01", edition = "time-series", version = 3)
#'
#'
#' ons_dataset_dims(id = "cpih01", edition = "time-series", version = 3)
#' ons_dataset_dim_opts(id = "cpih01", edition = "time-series", version = 3, dimension = "geography")
#'
ons_datasets <- function() {
  req <- build_request(datasets = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  as_tibble(raw$items)
}

#' @rdname ons_datasets
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
      stop("invalid `id` see `ons_ids()`.", call. = FALSE)
    }
    href <- href[id_match]
  }
  href
}


