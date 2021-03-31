#' ONS Datasets
#'
#' Used to find information about data published by the ONS.
#'
#' @importFrom httr GET stop_for_status
#' @importFrom tibble tibble as_tibble
#' @export
#' @examples
#'
#' # Find all the information about the data
#' ons_datasets()
#'
#' # Just the ids
#' ons_ids()
#'
#' # Look more about a specific id
#' ons_lookout("cpih01")
ons_datasets <- function() {
  req <- build_base_request(datasets = EMPTY)
  res <- make_request(req, limit = 50)
  raw <- process_response(res)
  # cat_ratio(raw)
  tbl <- as_tibble(raw$items)
  tbl$links <- as_tibble(tbl$links)
  tbl$qmi <- as_tibble(tbl$qmi)
  tbl
}

cat_ratio <- function(x) {
  cat(
    paste0(
      "Fetched ", x$count, "/", x$total_count,
      " (limit = ", x$limit, ", offset = ", x$offset, ")"),
    "\n")
}


cat_ratio_obs <- function(x) {
  cat(
    paste0(
      "Fetched ", NROW(x$observations), "/", x$total_observations,
      " (limit = ", x$limit, ", offset = ", x$offset, ")"),
    "\n")
}


#' @export
#' @rdname ons_datasets
ons_ids <- function() {
  x <- ons_datasets()
  x$id
}

#' @export
#' @rdname ons_datasets
ons_lookout <- function(id = NULL, desc = FALSE) {
  x <- ons_datasets()
  line <- x[which(x$id == id),]
  cat("Title:", line$title, "\n")
  cat("ID:", id, "\n")
  cat("Keywords:", line$keywords[[1]], "\n")
  cat("-----------\n")
  if(isTRUE(desc)) {
    cat("Description:", line$description,"\n")
    cat("-----------\n")
  }
  cat("Release Frequency:", line$release_frequency , "\n")
  cat("State:", line$state, "\n")
  cat("Next Release:", line$next_release, "\n")
  cat("-----------\n")
  cat("Latest Version:", line$links$latest_version$id, "\n")
  cat("Edition(s):", ons_editions(id), "\n")
}

ons_editions <- function(id = NULL) {
  req <- build_base_request(datasets = id, editions = EMPTY)
  res <- make_request(req)
  raw <- process_response(res)
  raw$items$edition
}

#' ONS latest info on Datasets
#'
#' Used to find information about data published by the ONS.
#'
#' @export
#' @name ons_latest
#' @examples
#'
#' ons_latest_href("cpih01")
#' ons_latest_version("cpih01")
#' ons_latest_edition("cpih01")

#' @rdname ons_latest
#' @export
ons_latest_href <- function(id = NULL) {
  x <- ons_datasets()
  assert_valid_id(id, x)
  id_num <- id_number(id, x)
  x$links$latest_version$href[id_num]
}

#' @export
#' @rdname ons_latest
ons_latest_version <- function(id = NULL) {
  href <- ons_latest_href(id)
  gsub(".*versions/(.+)", "\\1", href)
}

#' @export
#' @rdname ons_latest
ons_latest_edition <- function(id = NULL) {
  href <- ons_latest_href(id)
  gsub(".*editions/(.+)/versions.*", "\\1", href)
}

# helpers -----------------------------------------------------------------



id_number <- function(id = NULL, ons_ds = ons_datasets()) {
  which(ons_ds$id == id)
}

