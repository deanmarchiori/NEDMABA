



clust <- mca_data |> 
  select_if(\(x) length(unique(x)) == 2) 

rownames(clust) <- subjects$id

dm <- dist(clust, method = "binary")

hc <- hclust(dm)
plot(hc)
cl <- cutree(hc, k=3)
cl

subjects$cluster <- cl

subjects |> 
  select(id, cluster, survival_time) |> View()
  group_by(cluster) |> 
  summarise(mean_st = mean(survival_time))
