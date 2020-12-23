endpoint <- "https://api.beta.ons.gov.uk/v1"

EMPTY <- ""

#' @examples
#'
#' build_request(editions = 4, versions = 3)
#' build_request(editions = 4, versions = EMPTY) #does not handle ok
#' build_request(editions = 4, versions = NULL)
build_request <- function(...) {
  params <- list(...)
  plen <- length(params)
  param_chunks <- vector("character", plen)
  for (i in 1:plen) {
    pm <- params[[i]][1]
    if(is.null(pm)) {
      param_chunks[i] <-  ""
    }else if(pm == EMPTY){
      param_chunks[i] <- names(params)[i]
    }else{
      param_chunks[i] <-  paste(names(params)[i],  pm, sep = "/")
    }
  }
  query <- paste(param_chunks, collapse = "/")
  set_endpoint(query)
}

set_endpoint <- function(query) {
  paste(endpoint, query, sep = "/")
}


#' @importFrom httr GET
make_request <- function(query) {
  res <- GET(query)
  httr::stop_for_status(res)
}

#' @importFrom httr content
#' @importFrom jsonlite fromJSON
process_response <- function(res) {
  content(res, as = "text", encoding = "UTF-8") %>%
    fromJSON(simplifyVector = TRUE)
}


library(httr)
library(jsonlite)






# beta --------------------------------------------------------------------


# GET(paste0(endpoint_beta, "/datasets")) %>%
#   content( as = "text", encoding = "UTF-8") %>%
#   jsonlite::fromJSON( flatten = TRUE) %>%
#   .$items %>%
#   as_tibble() %>%
#   rename_all(list(~gsub("\\.", ":", .)))
#
# GET(paste0(endpoint_beta, "/code-lists")) %>%
#   content( as = "text", encoding = "UTF-8") %>%
#   jsonlite::fromJSON( flatten = TRUE) %>%
#   .$items %>%
#   as_tibble()
#
# GET(paste0(endpoint_beta, "/code-lists/adult-sex")) %>%
#   content( as = "text", encoding = "UTF-8") %>%
#   jsonlite::fromJSON( flatten = FALSE) %>% str()
#   as_tibble()


