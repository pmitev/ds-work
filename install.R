if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
suppressWarnings(BiocManager::install())


pkgs_to_install <- c("remotes","tidyverse","tibble","RCurl",
"cowplot","SingleCellExperiment","scater","reticulate", "AnnotationHub",
"ensembldb", "rio","devtools","XLConnect","janitor",
"pheatmap","DESeq2","reshape")

## Start the actual installation:
ok <- BiocManager::install(pkgs_to_install, update=FALSE, ask=FALSE) %in% rownames(installed.packages())
if (!all(ok))
    stop("Failed to install:\n  ",
         paste(pkgs_to_install[!ok], collapse="  \n  "))

remotes::install_github("immunogenomics/harmony")

# Install Seurat v4
remotes::install_github("satijalab/seurat", ref = "release/4.0.0")
remotes::install_github("jlmelville/uwot")

suppressWarnings(BiocManager::install(update=TRUE, ask=FALSE))

## Install formats for rio

rio::install_formats()
