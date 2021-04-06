# x <- httr::POST("https://www.ons.gov.uk/datasets/regional-gdp-by-year/editions/time-series/versions/3/filter")
# gsub( ".*filters/(.+)/dimension","\\1", x$url)
#
# httr::POST("https://api.beta.ons.gov.uk/v1/datasets/regional-gdp-by-year/editions/time-series/versions/3/filters-outputs/153f8e9c-8b7a-4dec-a876-84a90a0babb9")
#
# httr::GET("https://api.beta.ons.gov.uk/v1/filters/153f8e9c-8b7a-4dec-a876-84a90a0babb9")
# httr::GET("https://api.beta.ons.gov.uk/v1/filters/153f8e9c-8b7a-4dec-a876-84a90a0babb9/dimensions")
# httr::GET("https://api.beta.ons.gov.uk/v1/filters/153f8e9c-8b7a-4dec-a876-84a90a0babb9/dimensions/geography")
# httr::GET("https://api.beta.ons.gov.uk/v1/filters/153f8e9c-8b7a-4dec-a876-84a90a0babb9/dimensions/geography/options")
# httr::GET("https://api.beta.ons.gov.uk/v1/filters/153f8e9c-8b7a-4dec-a876-84a90a0babb9/dimensions/geography/options")


#' httr::POST("https://api.beta.ons.gov.uk/v1/datasets/filters")
#' httr::POST("https://api.beta.ons.gov.uk/v1/filters/153f8e9c-8b7a-4dec-a876-84a90a0babb9")
#'
#' httr::POST("https://api.beta.ons.gov.uk/v1/filters?submitted=true")
#'
#' endpoint_filter <- "https://www.ons.gov.uk/datasets"
#'
#' build_base_filter_request <- function(...) {
#'   query <- build_request_dots(...)
#'   paste0(endpoint, query)
#' }
#'
#' build_filter_request <- function(id, edition = NULL, version = NULL) {
#'   assert_valid_id(id)
#'   edition <- edition %||% ons_latest_edition(id)
#'   version <- version %||% ons_latest_version(id)
#'   build_base_filter_request(id, editions = edition, versions = version, filter = EMPTY)
#' }
#'
#' ons_filter_id <- function(id, edition = NULL, version = NULL) {
#'   req <- build_filter_request(id, edition, version)
#'   res <- make_request(req, VERB = "POST")
#'   gsub( ".*filters/(.+)/dimension","\\1", x$url)
#' }
