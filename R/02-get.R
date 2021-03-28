#' @importFrom readr read_csv
#'
#' @export
#' @examples
#' ons_dataset(id = "ageing-population-estimates", edition = "time-series", version = 1)
ons_get <- function(id = NULL, edition = NULL, version = NULL, ons_read = getOption("onsr.read")) {

  set_read_engine(ons_read)
  if(is.null(id)){
    stop("You must specify a `id`, see `ons_ids()`", call. = FALSE)
  }
  if(!is.null(version) & is.null(edition) | is.null(version) & !is.null(edition)) {
    stop("`edition` and `version` should be jointly specified.", call. = FALSE)
  }
  req <- build_request_latest(id, edition, version)
  res <- make_request(req)
  # return(res)
  raw <- process_response(res)
  # list(res, raw)
  # raw$downloads$csv$href
  read_csv_silent(raw$downloads$csv$href)
}

build_request_latest <- function(id, edition = NULL, version = NULL, ...) {
  if(is.null(edition) & is.null(version)) {
    req <- ons_latest_href(id)
    # TODO ons_latest_href returns all urls
  }else{
    req <- build_request(datasets = id, editions = edition, versions = version)
  }
  req
}

#' @rdname ons_datasets
ons_get_dims <- function(id = NULL, edition = NULL, version = NULL) {
  req <- build_request_latest(id, editions = edition, versions = version)
  req <- extend_request_dots(req, dimensions = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}

#' @rdname ons_datasets
ons_get_dim_opts <- function(id = NULL, edition = NULL, version = NULL, dimension = NULL) {
  req <- build_request_latest(id, editions = edition, versions = version)
  req <- extend_request_dots(req, dimensions = dimension, options = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}

#' @rdname ons_datasets
ons_get_meta <- function(id = NULL, edition = NULL, version = NULL) {
  req <- build_request_latest(id, editions = edition, versions = version)
  req <- extend_request_dots(req, metadata = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}

#' @rdname ons_datasets
ons_get_obs <- function(id = NULL, edition = NULL, version = NULL) {
  req <- build_request_latest(id, editions = edition, versions = version)
  req <- extend_request_dots(req, observations = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}
