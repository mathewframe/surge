#' Check Price Risk
#'
#' Tells you the probability of high prices (> $100) for a given load level.
#'
#' @param current_load Numeric. The expected demand in MW (e.g., 10000).
#' @export
check_risk <- function(current_load) {


  aeso_data <- surge::market_data # gets the data from the package

  # filter for days that looked like (current load)
  similar_days <- aeso_data[aeso_data$load > (current_load - 500) & aeso_data$load < (current_load + 500), ]

  # count how many of those days had expensive prices (>$100)
  high_price_count <- sum(similar_days$price > 100)
  total_days <- nrow(similar_days)

  # calculate risk percentage
  risk_percent <- round((high_price_count / total_days) * 100, 0)

  return(paste0("At ", current_load, " MW load, historical risk of high prices is: ", risk_percent, "%"))
}
