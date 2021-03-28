# browseURL("https://developer.ons.gov.uk/code-list/")


#' Explore codes and lists
#'
#' Used to get details about codes and code lists stored by ONS. Codes are used
#' to provide a common definition when presenting statistics with related categories.
#' Codes are gathered in code lists, which may change over time to include new or
#' different codes. The meaning of a code should not change over time, but new codes
#' may be created where new meaning is required.
#'
#'
#' @examples
#'
#' ons_codelists()
#' ons_codelist(id = "quarter")
#'
#' #editions
#' ons_codelist2(id = "quarter", edition = EMPTY)
#' ons_codelist2(id = "quarter", edition = "one-off")
#'
#' #codes
#' ons_codelist3(id = "quarter", edition = "one-off", code = EMPTY)
#' ons_codelist3(id = "quarter", edition = "one-off", code = "q2")
#'
#' ons_codelist4(id = "quarter", edition = "one-off", code = "q2")
#'
ons_codelists <- function() {
  req <- build_request(`code-lists` = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw$items$links$self$id
}

#' @rdname ons_codelists
ons_codelist <- function(id = NULL, edition = NULL, code = NULL) {
  req <- build_request(`code-lists` = id)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}

#' @rdname ons_codelists
ons_codelist2 <- function(id = NULL, edition = NULL, code = NULL) {
  req <- build_request(`code-lists` = id, editions = edition)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}

#' @rdname ons_codelists
ons_codelist3 <- function(id = NULL, edition = NULL, code = NULL) {
  req <- build_request(`code-lists` = id,  editions = edition, codes = code)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}

#' @rdname ons_codelists
ons_codelist4 <- function(id = NULL, edition = NULL, code = NULL) {
  req <- build_request(`code-lists` = id, editions = edition, codes = code, datasets = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}


