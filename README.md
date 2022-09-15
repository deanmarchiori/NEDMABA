# Meta-Analysis of Clinical Phenotype and Patient Survival in Neurodevelopmental Disorder with Microcephaly, Arthrogryposis, and Structural Brain Anomalies Due to Bi-allelic Loss of Function Variants in SMPD

## Abstract

A recently described, rare genetic condition known as Neurodevelopmental Disorder with Microcephaly, Arthrogryposis, and Structural Brain Anomalies (NEDMABA) has been identified in children with bi-allelic loss-of-function variants in *SMPD4*. The progression of this condition is not well understood with the limited case reports described so far exhibiting a severe and clinically diverse phenotype. A gap exists in the understanding of associations present in the heterogenous features of the clinical phenotype, and the expected survival probabilities of affected individuals. This is driven in part to the paucity of analysis-ready data on reported cases. This analysis aims to collate and standardise available case reports into a common dataset, to analyse and identify meaningful clusters in the clinical phenotype, and to quantify the survival probability for children with NEDMABA. To overcome the challenge of multidimensional data on very few subjects, we employ Multiple Correspondence Analysis (MCA) as a dimension reduction technique, which is then subject to cluster analysis and interpretation. To account for censoring in the data, Kaplan-Meier estimation is formulated to calculate patient survival time. The analysis correctly detected the classic phenotype for this condition, as well as a new distinct feature-cluster relating to findings of vocal cord paralysis, feeding dysfunction and respiratory failure. The survival probability for those affected was found to decline sharply in early infancy with median survival of 150 days, but with some surviving as long as 12.5 years. This wide range of outcomes is provisionally associated with different variant types however this conclusion could not be validated based on very low sample sizes. An `R` package called `SMPD4` was developed to publish standardised analysis-ready datasets used in this study. This analysis represents the first of its kind to help describe associations and trajectories of individuals with this newly reported condition, despite challenges with sparse and inconsistent data. This analysis can provide clinicians and genetic counsellors with better information to aide in decision making and support for families with this rare condition.

## Download full paper

[paper.pdf](/paper/formatted/NEDMABA-marchiori_2022.pdf)

## Reproducibility

To reproduce this paper, clone the repository and run:

    targets::tar_make()

The required packages are listed in `_targets_packages.R`
