library(targets)
library(tarchetypes)

# Set target options
tar_option_set(
  packages = c("SMPD4", 'tidyverse', 'ggrepel', 'corrplot', 'cluster', 'survival', 'survminer', 'quarto', 'knitr', 'FactoMineR', 'factoextra'), 
  format = "rds" 
)

# source files in /R
tar_source()


# Pipelinme
list(
  tar_target(subjects, prep_subjects_data(), cue = tar_cue(mode = "always")),
  
  # PCA
  tar_target(mca_data, prep_mca_data(data = subjects, 
                                    keep_cols = c(21:53, 57:60, 73, 77, 80, 86:152))),
  tar_target(mca,  MCA(mca_data, graph = FALSE)),

  # Clustering
  tar_target(cluster_data, prep_cluster_data(data = subjects, 
                                             keep_cols = c(21:53, 57:60, 73, 77, 80, 86:152))),
  tar_target(clusters, hclust(dist(cluster_data, method = "binary"))),
  tar_target(cluster_assign, cutree(clusters, k=3)),
  tar_target(subjects_clustered, bind_cols(subjects, cluster = cluster_assign)),
  
  # # Survival Analysis
  tar_target(survival_data, prep_survival_data(data = subjects_clustered,
                                               clusters = cluster_assign,
                                               vars = c("id", "cluster"))),
  tar_target(kapm_baseline, survfit(Surv(survival_time, deceased) ~ 1, data = survival_data)),
  tar_target(kapm, survfit(Surv(survival_time, deceased) ~ cluster, data = survival_data)),
  tar_target(cox_ph, coxph(Surv(survival_time, deceased) ~ cluster, data = survival_data)),

  # # Render Report
  tar_quarto(report, path = "paper_draft.qmd")
)
