
#' Explore codes and lists
#'
#' Used to get details about codes and code lists stored by ONS. Codes are used
#' to provide a common definition when presenting statistics with related categories.
#' Codes are gathered in code lists, which may change over time to include new or
#' different codes. The meaning of a code should not change over time, but new codes
#' may be created where new meaning is required.
#'
#' @inheritParams ons_get
#' @export
#' @examples
#' \donttest{
#' ons_codelists()
#' ons_codelist(id = "quarter")
#'
#' #editions
#' ons_codelist_editions(id = "quarter")
#'ons_codelist_edition(id = "quarter", edition = "one-off")
#'}
#'
ons_codelists <- function() {
  req <- build_base_request(`code-lists` = EMPTY)
  res <- make_request(req, limit = 80)
  raw <- process_response(res)
  raw$items$links$self$id
}

#' @rdname ons_codelists
#' @export
ons_codelist <- function(id = NULL) {
  req <- build_base_request(`code-lists` = id)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}

#' @rdname ons_codelists
#' @export
ons_codelist_editions <- function(id = NULL) {
  req <- build_base_request(`code-lists` = id, editions = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}

#' @rdname ons_codelists
#' @export
ons_codelist_edition <- function(id = NULL, edition = NULL) {
  req <- build_base_request(`code-lists` = id, editions = edition)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}


#' Explore codes and lists
#'
#' Used to get details about codes and code lists stored by ONS. Codes are used
#' to provide a common definition when presenting statistics with related categories.
#' Codes are gathered in code lists, which may change over time to include new or
#' different codes. The meaning of a code should not change over time, but new codes
#' may be created where new meaning is required.
#'
#' @param code
#'
#' `[character]` The ID of the code within a code list.
#'
#' @inheritParams ons_get
#' @export
#' @examples
#'
#' \donttest{
#' #codes
#' ons_codes(id = "quarter", edition = "one-off")
#' ons_code(id = "quarter", edition = "one-off", code = "q2")
#'
#' ons_code_dataset(id = "quarter", edition = "one-off", code = "q2")
#'}
ons_codes <- function(id = NULL, edition = NULL) {
  req <- build_base_request(`code-lists` = id,  editions = edition, codes = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}

#' @rdname ons_codes
#' @export
ons_code <- function(id = NULL, edition = NULL, code = NULL) {
  req <- build_base_request(`code-lists` = id,  editions = edition, codes = code)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}

#' @rdname ons_codes
#' @export
ons_code_dataset <- function(id = NULL, edition = NULL, code = NULL) {
  req <- build_base_request(`code-lists` = id, editions = edition, codes = code, datasets = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw
}


