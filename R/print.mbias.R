#' Print association corrected for M bias
#'
#' Print association corrected for M bias.
#'
#' @param x An object of class 'mbias'.
#' @param ... Other unused arguments.
#'
#' @return Print the observed and adjusted measures of association.
#'
#' @export
print.mbias <- function(x, ...) {
    cat("Correction for selection bias:",
        "\n----------------------------------------",
        "\nOR observed between the exposure and the outcome:",
        x$bias_parms[5],
        "\n             Maximum bias from conditioning on M:",
        x$mbias_parms[3],
        "\n                 OR corrected for selection bias:",
        x$adj_measures,
        "\n")
    invisible(NULL)
}
