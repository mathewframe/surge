utils::globalVariables(c("series", "value", ".data", ":="))

#' Compute spreads on two series in a long data frame
#'
#' Takes a long data frame, pivots wider, computes a - b on matching dates, and pivots back to long format
#'
#' @param df A long dataframe with columns 'date', 'series', and 'value'.
#' @param a First series name.
#' @param b Second series name.
#' @param spread_name Name of output series.
#' @param date_col Name of date column (before function).
#' @param series_col Name of series column (before function).
#' @param value_col Name of value column (before function).
#' @return A long dataframe with spread computed.
#'
#' @export

spread <- function(df, date_col = date, series_col = series,
                   value_col = value, a, b, spread_name = "spread"){
  df %>%
    dplyr::select({{date_col}}, {{series_col}}, {{ value_col }}) %>%
    dplyr::rename(date = {{date_col}},
                  series = {{series_col}},
                  value = {{value_col}}) %>%
    tidyr::pivot_wider(names_from = "series", values_from = "value") %>%
    dplyr::mutate(
      "{spread_name}" := .data[[a]] - .data[[b]]
    ) %>%
    tidyr::pivot_longer(-date, names_to = "series", values_to = "value")
}
