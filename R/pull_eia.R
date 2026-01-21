#' Pulls data from the EIA API as a tibble
#'
#' Fetches data from the EIA API v2.
#' Constructs the request and query parameters, and parses JSON into a tibble.
#' Stops on API errors.
#'
#' @param api_key Your EIA API key
#' @param route API endpoint route
#' @param facets Name of data columns to fetch
#' @param data name of value column to return, "value" is default
#' @return A tibble with API data
#'
#' @examples
#' \dontrun{
#' Need a valid API key to run this
#' key <- "api_key"
#' petroleum_stocks <- pull_eia(
#'   api_key = key,
#'   route = "petroleum/stoc/wstk/data/",
#'   facets = list(series = c("WTESTUS1", "WTTSTUS1")))
#'}
#' @export

pull_eia <- function(api_key, route, data = "value", facets = NULL) {
  base_url <- sprintf("https://api.eia.gov/v2/%s?api_key=%s&data[]=%s", route, api_key, data)

  facet_string <- ""
  if (!is.null(facets)) {
    facet_parts <- c()
    for (name in names(facets)) {
      for (val in facets[[name]]) {
        part <- sprintf("&facets[%s][]=%s", name, val)
        facet_parts <- c(facet_parts, part)
      }
    }
    facet_string <- paste(facet_parts, collapse = "")
  }

  final_url <- sprintf("%s%s", base_url, facet_string)

  resp <- httr::GET(final_url)
  httr::stop_for_status(resp)

  raw <- httr::content(resp, "text", encoding = "UTF-8")
  content <- jsonlite::fromJSON(raw)
  api_data <- content[["response"]][["data"]]

  if (length(api_data) > 0) {
    tibble::as_tibble(api_data)
  }
  else {
    message("No data from EIA API")
    tibble::tibble()
  }
}
