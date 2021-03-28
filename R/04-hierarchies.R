# /hierarchies/{instance_id}/{dimension_name}

ons_hierarchies <- function(instance_id) {
  req <- build_request(`hierarchies` = "cpih01", dimension_name = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw$items$links$self$id
}

ons_hierarchies2 <- function(instance_id, code_id) {
  req <- build_request(`hierarchies` = "cpih01", dimension_name = EMPTY, `dd-mm` = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw$items$links$self$id
}
