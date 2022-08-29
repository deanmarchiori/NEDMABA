prep_survival_data <- function(data, variant_data){
  data |> 
    inner_join(variant_data, by = c("study", "family")) |> 
    mutate(deceased = as.numeric(deceased)) |> 
    group_by(id) |> 
    mutate(ind = row_number()) |> 
    pivot_wider(id_cols = c(id, variant_type.x, survival_time, deceased), names_from = ind, values_from = variant_type.y) |> 
    unite(`1`, `2`, col = variant, na.rm = T, sep = "+") |> 
    mutate(variant_2 = ifelse(str_detect(variant, "missense"), "missense", "other"))
    
}

