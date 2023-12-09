
`%||%` <- function (x, y) {
  if (is.null(x))
    y
  else x
}

read_csv_silent <- function(x, type = getOption("onsr.read"), ...) {

  type <- match.arg(type, c("readr", "vroom", "data.table"))
  out <- tryCatch({
    suppressMessages({
      if(type == "vroom") {
        vroom::vroom(x, ...)
      } else if (type == "data.table"){
        need_pkg("data.table")
        data.table::fread(x, ...)
      } else if (type == "readr"){
        need_pkg("readr")
        readr::read_csv(x, ...)
      }
    })
    },
    error  = function(e) e
  )
  out
}


# conditional pkgs --------------------------------------------------------

has_pkg <- function(pkg) {
  pkg %in% loadedNamespaces()
}

is_installed <- function(pkg) {
  requireNamespace(pkg, quietly = TRUE)
  # system.file(package = pkg) != ""
}

need_pkg <- function(pkg) {
  if (!is_installed(pkg)) {
    stop("Please install ", pkg, " package", call. = FALSE)
  }
}

# cat  --------------------------------------------------------------------


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

# cleaning ----------------------------------------------------------------

clean_date <- function(x, idx = "Time") {
  x[["Time"]] <- as.Date(paste("01-", x[["Time"]], sep = ""), format = "%d-%b-%y")
  x
}

# pass check --------------------------------------------------------------

globalVariables(c("dataset_size"))


# defensive ---------------------------------------------------------------


restrict_size <- function(gt, type = c("Gb$", "Mb$")) {
  type <- match.arg(type)
  size <- dataset_size$Size
  idx <- grep(type, size)
  candidates <- dataset_size$Id[idx]
  num <- as.numeric(gsub("(?=[GMK]b).+", "\\1", size, perl = TRUE))
  bool <- num[idx] > gt
  candidates[bool]
}

ask_yesno <- function(...) {
  cat(paste0(..., collapse = ""))
  ans <- utils::menu(c("Yes", "No"))
  ifelse(ans == 1, TRUE, FALSE)
}

assert_valid_id <- function(id = NULL, ons_ds = NULL) {

  if(is.null(ons_ds)) {
    ids <- ons_ids()
    ids %||% return(invisible(NULL))
  }else{
    ids <- ons_ds$id
  }
  if(length(id) > 1L) {
    stop("trying to access multiple files", call. = FALSE)
  }
  if(is.null(id)){
    stop("You must specify a `id`, see `ons_ids()`", call. = FALSE)
  }
  if(!id %in% ids) {
    stop("Invalid `id` see `ons_ids()`.", call. = FALSE)
  }
}

assert_filesize_id <- function(id, ons_ds = NULL, force = TRUE) {
  if(is.null(ons_ds)) {
    ids <- ons_ids()
    ids %||% return(invisible(NULL))
  }else{
    ids <- ons_ds$id
  }
  large_ids <- restrict_size(1, "Gb$")
  id_size <- dataset_size$Size[which(dataset_size$Id == id)]
  if(id %in% ids[large_ids]) {
    if (interactive()) {
      ans <- ask_yesno(
        paste0( "File size is very large (", id_size, ") and may cause errors.",
                " Do you want to proceed?"))
    }else{
      if(force) {
        return(NULL)
      }else{
        ans <- FALSE
        stop("File size is very large, exiting. Use `force=TRUE` to download")
      }
    }
    if(!ans) {
      stop("user choose to exit", call. = FALSE)
    }
  }
  medium_ids <- restrict_size(200, "Mb$")
  if(id %in% ids[medium_ids]) {
    message(paste0( "File size is large (", id_size, ")."))
  }
}

assert_get_id <- function(id, force = FALSE) {
  ons_ds <- ons_datasets()
  ons_ds %||% return(invisible(NULL))
  assert_valid_id(id, ons_ds)
  assert_filesize_id(id, ons_ds, force = force)
}
