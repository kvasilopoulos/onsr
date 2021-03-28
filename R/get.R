endpoint <- "https://api.beta.ons.gov.uk/v1"

EMPTY <- ""

set_endpoint <- function(query) {
  paste(endpoint, query, sep = "/")
}

#' @examples
#'
#' build_request(editions = 4, versions = 3)
#' build_request(editions = 4, versions = EMPTY) #does not handle ok
#' build_request(editions = 4, versions = NULL)
build_request <- function(...) {
  param_chunks <- build_request_dots(...)
  query <- paste(param_chunks, collapse = "/")
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
      param_chunks[i] <-  paste(names(params)[i],  pm, sep = "/")
    }
  }
  param_chunks
}

extend_request_dots <- function(pre, ...) {
  param_chunks <- build_request_dots(...)
  append <- paste(param_chunks, collapse = "/")
  paste(pre, append, sep = "/")
}


try_GET <- function(x, ...) {
  tryCatch(
    RETRY("GET", url = x, timeout(10),  quiet = TRUE,...),
    error = function(err) conditionMessage(err),
    warning = function(warn) conditionMessage(warn)
  )
}
is_response <- function(x) {
  class(x) == "response"
}

#' @importFrom httr GET RETRY write_disk timeout
make_request <- function(query) {

  if (!curl::has_internet()) {
    message("No internet connection.")
    return(invisible(NULL))
  }
  resp <- try_GET(query)
  return(resp)
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

#' @importFrom httr content
#' @importFrom jsonlite fromJSON
process_response <- function(res) {
  ct <- content(res, as = "text", encoding = "UTF-8")
  fromJSON(ct, simplifyVector = TRUE)
}

