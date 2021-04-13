
#' Explore codes and lists
#'
#' Used to get details about codes and code lists stored by ONS. Codes are used
#' to provide a common definition when presenting statistics with related categories.
#' Codes are gathered in code lists, which may change over time to include new or
#' different codes. The meaning of a code should not change over time, but new codes
#' may be created where new meaning is required.
#'
#' @inheritParams ons_get
#' @param code_id
#'
#' `[character]`. The id of a codelist.
#'
#' @return A list or character vector.
#'
#' @export
#' @examples
#' \donttest{
#' ons_codelists()
#' ons_codelist(code_id = "quarter")
#'
#' #editions
#' ons_codelist_editions(code_id = "quarter")
#'ons_codelist_edition(code_id = "quarter", edition = "one-off")
#'}
#'
ons_codelists <- function() {
  req <- build_base_request(`code-lists` = EMPTY)
  res <- make_request(req, limit = 80)
  res %||% return(invisible(NULL))
  raw <- process_response(res)
  raw$items$links$self$id
}

assert_valid_codeid <- function(id) {
  if(length(id) > 1L) {
    stop("trying to access multiple ids", call. = FALSE)
  }
  if(is.null(id)){
    stop("You must specify a `code_id`, see `ons_codelists()`", call. = FALSE)
  }
  ids <- ons_codelists()
  if(!id %in% ids) {
    stop("Invalid `id` see `ons_codelists()`.", call. = FALSE)
  }
}

#' @rdname ons_codelists
#' @export
ons_codelist <- function(code_id = NULL) {
  assert_valid_codeid(code_id)
  req <- build_base_request(`code-lists` = code_id)
  res <- make_request(req)
  res %||% return(invisible(NULL))
  raw <- process_response(res)
  raw
}

#' @rdname ons_codelists
#' @export
ons_codelist_editions <- function(code_id = NULL) {
  assert_valid_codeid(code_id)
  req <- build_base_request(`code-lists` = code_id, editions = EMPTY)
  res <- make_request(req)
  res %||% return(invisible(NULL))
  raw <- process_response(res)
  raw$items
}

assert_valid_edition <- function(code_id, edition) {
  if(is.null(edition)){
    stop("You must specify an `edition`, see `ons_codelist_editions()`", call. = FALSE)
  }
  editions <- ons_codelist_editions(code_id)$edition
  if(!edition %in% editions) {
    stop("invalid `edition`, see ons_codelist_editions()`.", call. = FALSE)
  }
}

#' @rdname ons_codelists
#' @export
ons_codelist_edition <- function(code_id = NULL, edition = NULL) {
  assert_valid_codeid(code_id)
  assert_valid_edition(code_id, edition)
  req <- build_base_request(`code-lists` = code_id, editions = edition)
  res <- make_request(req)
  res %||% return(invisible(NULL))
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
#' @inheritParams ons_codelists
#' @inheritParams ons_get
#'
#' @param code
#'
#' `[character]` The ID of the code within a code list.
#'
#' @return A list or character vector.
#'
#' @export
#' @examples
#'
#' \donttest{
#' #codes
#' ons_codes(code_id = "quarter", edition = "one-off")
#' ons_code(code_id = "quarter", edition = "one-off", code = "q2")
#'
#' ons_code_dataset(code_id = "quarter", edition = "one-off", code = "q2")
#'}
ons_codes <- function(code_id = NULL, edition = NULL) {
  assert_valid_codeid(code_id)
  assert_valid_edition(code_id, edition)
  req <- build_base_request(`code-lists` = code_id,  editions = edition, codes = EMPTY)
  res <- make_request(req)
  res %||% return(invisible(NULL))
  raw <- process_response(res)
  raw$items
}

assert_valid_code <- function(code_id, edition, code) {
  if(is.null(code)){
    stop("You must specify a `code`, see `ons_codes()`", call. = FALSE)
  }
  codes <- ons_codes(code_id, edition)$code
  if(!code %in% codes) {
    stop("invalid `code`, see `ons_codes()`.", call. = FALSE)
  }
}

#' @rdname ons_codes
#' @export
ons_code <- function(code_id = NULL, edition = NULL, code = NULL) {
  assert_valid_codeid(code_id)
  assert_valid_edition(code_id, edition)
  assert_valid_code(code_id, edition, code)
  req <- build_base_request(`code-lists` = code_id,  editions = edition, codes = code)
  res <- make_request(req)
  res %||% return(invisible(NULL))
  raw <- process_response(res)
  raw
}

#' @rdname ons_codes
#' @export
ons_code_dataset <- function(code_id = NULL, edition = NULL, code = NULL) {
  assert_valid_codeid(code_id)
  assert_valid_edition(code_id, edition)
  assert_valid_code(code_id, edition, code)
  req <- build_base_request(`code-lists` = code_id, editions = edition, codes = code, datasets = EMPTY)
  res <- make_request(req)
  res %||% return(invisible(NULL))
  raw <- process_response(res)
  raw$items
}


