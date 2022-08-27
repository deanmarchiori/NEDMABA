prep_cluster_data <-  function(data,
                               keep_cols) {
  clust <- data |>
    dplyr::select(all_of(keep_cols))  |> 
    select_if(function(x) (length(unique(x)) == 2 & min(table(x))>1)) |> 
    dplyr::mutate(across(everything(), as.factor)) 
  
  rownames(clust) <- data$id
  
  return(clust)
  }