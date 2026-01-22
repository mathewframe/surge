#' Historical Alberta Energy Market Data
#'
#' A dataset containing historical hourly pool prices and internal load (demand)
#' for Alberta. Used to calculate risk probabilities.
#'
#' @format A data frame with 2 variables:
#' \describe{
#'   \item{price}{The actual hourly pool price in CAD/MWh}
#'   \item{load}{The Alberta Internal Load (AIL) in MW}
#' }
#' @source \url{http://ets.aeso.ca/}
"market_data"
