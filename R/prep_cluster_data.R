prep_cluster_data <- function(data, cols){
  
  vars <- data$var$coord |> 
    as_tibble(rownames = 'var') |> 
    filter(str_detect(var, "_1")) |> 
    janitor::clean_names() |> 
    select(var, all_of(cols)) |> 
    as.data.frame()
  
  rownames(vars) <- vars$var
  
  clust_dat <- vars[, -1]
  
  return(clust_dat)
  
}


