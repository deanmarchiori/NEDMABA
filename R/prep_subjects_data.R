prep_subjects_data <- function() {
  comb <- dplyr::bind_rows(
   SMPD4::bijarnia_mahay_2022,
    SMPD4::ji_2022,
    SMPD4::magini_2019,
    SMPD4::monies_2019,
    SMPD4::ravenscroft_2020
  ) |>
    dplyr::mutate(
      skeletal_changes_scoliosis = ifelse(skeletal_changes_scoliosis == "yes", 1, 0),
      skeletal_changes_scoliosis = tidyr::replace_na(skeletal_changes_scoliosis, 0),
      hip_luxation = ifelse(hip_luxation == "yes", 1, 0),
      hip_luxation = tidyr::replace_na(hip_luxation, 0)
    )
  
}