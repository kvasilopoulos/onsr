.onLoad <- function(libname, pkgname) {
  op <- options()

  op.onsr <- list(
    onsr.read = "readr"
  )
  toset <- !(names(op.onsr) %in% names(op))
  if (any(toset)) options(op.onsr[toset])

  invisible(NULL)
}
