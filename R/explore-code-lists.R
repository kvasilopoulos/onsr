# browseURL("https://developer.ons.gov.uk/code-list/")


ons_codelists <- function() {
  req <- build_request(`code-lists` = NULL)
  raw <- make_request("https://api.beta.ons.gov.uk/v1/code-lists")
  res <- process_response(raw)
  res$items$links$self$id
}
