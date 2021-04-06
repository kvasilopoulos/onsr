#' Download data from ONS
#'
#' This functions is used to find information about data published by the ONS.
#' `Datasets` are published in unique `versions`, which are categorized by `edition`.
#' Available datasets are given  an `id`. All available `id` can be viewed with `ons_ids()`.
#'
#' @param id
#'
#' `[character]` 	Id that represents a dataset.
#'
#' @param edition
#'
#' `[character]` 	A subset of the dataset representing a specific time period.
#' For some datasets this edition can contain all time periods (all historical data).
#' The latest version of this is displayed by default.
#'
#' @param version
#'
#' `[character]` 	A specific instance of the edition at a point in time. New
#' versions can be published as a result of corrections, revisions or new data
#' becoming available.
#'
#' @param ons_read
#'
#' `[character]`. Reading backend, one of `readr`, `data.table` or `vroom`.
#'
#' @param ...
#'
#' Further arguments passed on the reading functions.
#'
#'
#'
#' @importFrom readr read_csv
#' @return A tibble with the dataset in tidy format.
#' @export
#' @examples
#' \donttest{
#' ons_get(id = "cpih01")
#'
#' # Same dataset but older version
#' ons_get(id = "cpih01", version = "5")
#'}
ons_get <- function(id = NULL, edition = NULL, version = NULL, ons_read = getOption("onsr.read"), ...) {
  req <- build_request(id, edition, version)
  res <- make_request(req)
  raw <- process_response(res)
  read_csv_silent(raw$downloads$csv$href, ons_read, ...)
}

#' @rdname ons_get
#' @export
#' @examples
#' \donttest{
#' # Take only specific observations
#' ons_get_obs("cpih01", geography = "K02000001", aggregate = "cpih1dim1A0", time = "Oct-11")
#'
#' # Or can use a wildcard for the time
#' ons_get_obs("cpih01", geography = "K02000001", aggregate = "cpih1dim1A0", time = "*")
#' }
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

  avail_dims <- ons_dim(id)
  stopifnot(nms %in% avail_dims)

  plen <- length(params)
  param_chunks <- vector("character", plen)
  for (i in 1:plen) {
    pm <- params[[i]][1]
    param_chunks[i] <- paste(nms[i], pm, sep = "=")
  }
  paste(param_chunks, collapse = "&")
}




#' Access dataset's additional information
#'
#' Data in each version is broken down by `dimensions`, and a unique
#' combination of dimension `options` in a version can be used to retrieve
#' `observation` level data.
#'
#' @inheritParams ons_get
#'
#' @param dimension
#'
#' `[character]`
#'
#' @param limit
#'
#' `[numeric(1): NULL]` Number of records to return. By default is `NULL`, which
#' means that the defaults of the ONS API are used. You can set it to a number
#' to request more (or less) records, and also to `Inf` to request all records.
#'
#' @param offset
#'
#' `[numeric(1): NULL]` The position in the dataset of a particular record.
#' By specifying `offset` , you retrieve a subset of records starting with
#' the `offset` value. Offset normally works with length , which determines
#' how many records to retrieve starting from the `offset`.
#'
#' @return A character vector.
#' @name ons_extra
#' @export
#' @examples
#' ons_dim(id = "cpih01")
#'
#' ons_dim_opts(id = "cpih01", dimension = "time")
#'
#' ons_meta(id = "cpih01")
#'
ons_dim <- function(id = NULL, edition = NULL, version = NULL) {
  req <- build_request(id, edition, version)
  req <- extend_request_dots(req, dimensions = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw$items$name
}

#' @rdname ons_extra
#' @export
ons_dim_opts <- function(id = NULL, edition = NULL, version = NULL, dimension = NULL, limit = NULL, offset = NULL) {
  req <- build_request(id, edition, version)
  req <- extend_request_dots(req, dimensions = dimension, options = EMPTY)
  res <- make_request(req, offset = offset, limit = limit)
  raw <- process_response(res)
  cat_ratio(raw)
  raw$items$option
}

#' @rdname ons_extra
#' @export
ons_meta <- function(id = NULL, edition = NULL, version = NULL) {
  req <- build_request(id, edition, version)
  req <- extend_request_dots(req, metadata = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}



