prep_survival_data <- function(data, clusters, vars){
  data |> 
    mutate(cluster = as.factor(clusters)) |> 
    mutate(deceased = as.numeric(deceased)) |> 
    select(deceased, survival_time, all_of(vars))
    
  }