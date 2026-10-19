#' Prepare World Bank mortality data
#'
#' Reads a World Bank mortality CSV file, reshapes the data from wide
#' to long format, standardizes country codes, and keeps observations
#' from 2000 to 2019.
#'
#' @param file Path to the World Bank mortality CSV file.
#' @param outcome_name Character string giving the name of the mortality
#'   outcome variable in the returned data.
#'
#' @return A data frame with columns `iso`, `year`, and the specified
#'   mortality outcome variable.
#'
#' @export
prepare_mortality <- function(file, outcome_name) {

  dat <- readr::read_csv(
    file,
    show_col_types = FALSE
  ) |>
    janitor::clean_names()

  # World Bank files often use country_code.
  # Rename it to iso for easier merging later.
  if ("country_code" %in% names(dat)) {
    dat <- dat |>
      dplyr::rename(iso = country_code)
  }

  dat_long <- dat |>
    tidyr::pivot_longer(
      cols = tidyselect::matches("^x?[0-9]{4}$"),
      names_to = "year",
      values_to = outcome_name
    ) |>
    dplyr::mutate(
      year = as.integer(stringr::str_extract(year, "[0-9]{4}")),
      iso = toupper(iso)
    ) |>
    dplyr::filter(
      year >= 2000,
      year <= 2019
    ) |>
    dplyr::select(
      iso,
      year,
      tidyselect::all_of(outcome_name)
    )

  return(dat_long)
}
