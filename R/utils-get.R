endpoint <- "https://api.beta.ons.gov.uk/v1"

EMPTY <- ""

set_endpoint <- function(query) {
  paste(endpoint, query, sep = "/")
}
# Build Request -----------------------------------------------------------


build_request <- function(id, edition = NULL, version = NULL) {
  edition <- edition %||% ons_latest_edition(id)
  version <- version %||% ons_latest_version(id)
  build_base_request(datasets = id, editions = edition, versions = version)
}

build_base_request <- function(...) {
  query <- build_request_dots(...)
  set_endpoint(query)
}

build_request_dots <- function(...) {
  params <- list(...)
  plen <- length(params)
  param_chunks <- vector("character", plen)
  for (i in 1:plen) {
    pm <- params[[i]][1]
    if(is.null(pm)) {
      param_chunks[i] <-  ""
    }else if(pm == EMPTY){
      param_chunks[i] <- names(params)[i]
    }else{
      param_chunks[i] <-  paste(names(params)[i], pm, sep = "/")
    }
  }
  is_empty <- param_chunks == EMPTY
  paste(param_chunks[!is_empty], collapse = "/")
}

extend_request_dots <- function(pre, ...) {
  append <- build_request_dots(...)
  paste(pre, append, sep = "/")
}

# Make Request ------------------------------------------------------------

USER_AGENT = "onsr (https://github.com/kvasilopoulos/onsr)"

#' @importFrom httr GET RETRY write_disk timeout
try_VERB <- function(x, limit, offset, VERB = "GET", ...) {
  tryCatch(
    RETRY(VERB, url = x, timeout(10), quiet = TRUE,
          query = list(limit = limit, offset = offset), ...),
    error = function(err) conditionMessage(err),
    warning = function(warn) conditionMessage(warn)
  )
}

is_response <- function(x) {
  class(x) == "response"
}


#' @importFrom httr GET RETRY write_disk timeout
make_request <- function(query, limit = NULL, offset = NULL, ...) {

  if (!curl::has_internet()) {
    message("No internet connection.")
    return(invisible(NULL))
  }
  resp <- try_VERB(query, limit = limit, offset = offset, ...)
  if (!is_response(resp)) {
    message(resp)
    return(invisible(NULL))
  }
  if (httr::http_error(resp)) { # network is down = message (not an error anymore)
    httr::message_for_status(resp)
    return(invisible(NULL))
  }
  resp
}

# Response ----------------------------------------------------------------


#' @importFrom httr content
#' @importFrom jsonlite fromJSON
process_response <- function(res) {
  ct <- content(res, as = "text", encoding = "UTF-8")
  fromJSON(ct, simplifyVector = TRUE)
}

