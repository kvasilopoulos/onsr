

# taken from gh -----------------------------------------------------------

# has_no_names <- function (x) {
#   all(!has_name(x))
# }
#
#
# has_name <- function (x) {
#   nms <- names(x)
#   if (is.null(nms)) {
#     rep_len(FALSE, length(x))
#   }
#   else {
#     !(is.na(nms) | nms == "")
#   }
# }
#
# cleanse_names <- function (x) {
#   if (has_no_names(x)) {
#     names(x) <- NULL
#   }
#   x
# }
#
# drop_named_nulls <- function (x) {
#   if (has_no_names(x))
#     return(x)
#   named <- has_name(x)
#   null <- vapply(x, is.null, logical(1))
#   cleanse_names(x[!named | !null])
# }


`%||%` <- function (x, y) {
  if (is.null(x))
    y
  else x
}
