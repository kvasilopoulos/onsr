# /hierarchies/{instance_id}/{dimension_name}

ons_hierarchies <- function(instance_id  = NULL, dimension_name = NULL, code_id = NULL) {
  req <- build_base_request(hierarchies = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw$items$links$self$id
}
