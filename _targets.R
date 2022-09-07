library(targets)
library(tarchetypes)

# Set target options
tar_option_set(
  packages = c("SMPD4", 'clValid', 'tidyverse', 'ggrepel', 
               'cluster', 'survival', 'survminer', 'quarto',
               'knitr', 'FactoMineR', 'factoextra', 'gt', 'withr'), 
  format = "rds" 
)

# source files in /R
tar_source()


# Pipelinme
list(
  tar_target(subjects, prep_subjects_data()),
  
  # MCA
  tar_target(mca_data_prelim, prep_mca_data(data = subjects, 
                                    keep_cols = c(21:53, 57:60, 73, 77, 80, 86:152))),
  tar_target(mca_prelim,  MCA(mca_data_prelim, graph = FALSE)),
  tar_target(mca_data, prep_mca_data(data = slice(subjects, -c(17, 18)), 
                                     keep_cols = c(21:53, 57:60, 73, 77, 80, 86:152))),
  tar_target(mca,  MCA(mca_data, graph = FALSE)),
  
  ## cluster analysis 
  tar_target(cluster_data, prep_cluster_data(mca, cols = c('dim_1', 'dim_2', 'dim_3', 'dim_4'))),
  tar_target(cluster_select, clValid(cluster_data,
                                     nClust = 2:5, 
                                     clMethods = c("agnes", "kmeans", "som"), 
                                     method = "average", 
                                     validation = "stability")),
  tar_target(clustering, withr::with_seed(seed = 1234, kmeans(cluster_data, centers = 5, nstart = 10))),
  tar_target(cluster_assignments, clustering$cluster),
  
  ## Survival Analysis
  tar_target(survival_data, prep_survival_data(data = subjects,
                                               variant_data = SMPD4::CADD)),
  tar_target(kapm_baseline, survfit(Surv(survival_time, deceased) ~ 1, data = survival_data)),
  tar_target(kapm, survfit(Surv(survival_time, deceased) ~ variant, data = survival_data)),
  tar_target(logrank, survdiff(Surv(survival_time, deceased) ~ variant, data = survival_data)),
  tar_target(cox_ph, coxph(Surv(survival_time, deceased) ~ variant, data = survival_data)),

  # Render Report
  tar_quarto(report, path = "test/paper.qmd")
)



