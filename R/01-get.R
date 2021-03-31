#'
#' Get data from
#'
#' @importFrom readr read_csv
#'
#' @param id
#'
#' `[character]`
#'
#' @param edition
#'
#' `[character]`
#'
#' @param version
#'
#' `[version]`
#'
#' @param ons_read
#'
#' `[ons_read]`
#'
#' @param ...
#'
#' Further arguments passed on the reading functions.
#'
#'
#' @export
#' @examples
#' ons_get(id = "cpih01", limit = 500)
#'
#' # Same dataset but older version
#' ons_get(id = "cpih01", version = "5")
#'
ons_get <- function(id = NULL, edition = NULL, version = NULL, ons_read = getOption("onsr.read"), ...) {
  req <- build_request(id, edition, version)
  res <- make_request(req)
  raw <- process_response(res)
  read_csv_silent(raw$downloads$csv$href, ons_read, ...)
}



#' Extra functionality
#'
#' @name ons_extra
#' @examples
#' ons_get_dim(id = "cpih01")
#'
#' ons_get_dim_opts(id = "cpih01", dimension = "time", limit = 400)
#'
#' ons_get_meta(id = "cpih01")
#'
#' ons_get(id = "cpih01", edition = "time-series", version = 3)
#' ons_get(id = "cpih01", edition = "time-series", version = 3, dimension = "geography")
#'
ons_get_dim <- function(id = NULL, edition = NULL, version = NULL, limit = 20, offset = 0) {
  req <- build_request(id, edition, version)
  req <- extend_request_dots(req, dimensions = EMPTY)
  res <- make_request(req, limit = limit, offset = offset)
  raw <- process_response(res)
  raw$items$name
}

#' @rdname ons_extra
ons_get_dim_opts <- function(id = NULL, edition = NULL, version = NULL, dimension = NULL, limit = 20, offset = 0) {
  req <- build_request(id, edition, version)
  req <- extend_request_dots(req, dimensions = dimension, options = EMPTY)
  res <- make_request(req, limit = limit, offset = offset)
  raw <- process_response(res)
  cat_ratio(raw)
  raw$items$option
}

#' @rdname ons_extra
ons_get_meta <- function(id = NULL, edition = NULL, version = NULL) {
  req <- build_request(id, edition, version)
  req <- extend_request_dots(req, metadata = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}



#' @rdname ons_get
#' @examples
#'
#' # Take only specific observations
#' ons_get_obs("cpih01", geography = "K02000001", aggregate = "cpih1dim1A0", time = "Oct-11")
#'
#' # Or can use a wildcard for the time
#' ons_get_obs("cpih01", geography = "K02000001", aggregate = "cpih1dim1A0", time = "*")
ons_get_obs <- function(id = NULL, edition = NULL, version = NULL, ...) {
  base <- build_request(id, edition, version)
  obs <- build_request_obs(id, ...)
  req <- paste0(base, "/observations?", obs)
  res <- make_request(req)
  raw <- process_response(res)
  cat_ratio_obs(raw)
  as_tibble(raw$observations)
}

build_request_obs <- function(id, ...) {
  params <- list(...)
  nms <- names(params)

  avail_dims <- ons_get_dim(id)
  stopifnot(nms %in% avail_dims)

  plen <- length(params)
  param_chunks <- vector("character", plen)
  for (i in 1:plen) {
    pm <- params[[i]][1]
    param_chunks[i] <- paste(nms[i], pm, sep = "=")
  }
  paste(param_chunks, collapse = "&")
}



