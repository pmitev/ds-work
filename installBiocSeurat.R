myNcpus <- as.integer(Sys.getenv("NCPU"))
if(is.na(myNcpus)) myNcpus <- 1

# Force minicoda to be INSIDE this Singularity container
install.packages("reticulate", ask=FALSE, Ncpus=myNcpus)
reticulate::install_miniconda("/opt/miniconda")
reticulate::use_condaenv("r-reticulate", required = TRUE)
reticulate::py_config()

# jupyter and other frequently required pythonic packages
# - we keep it all in one default environment r-reticulate
# - if later packages (e.g. tensorflow) are not happy with the latest
#   pythonic packages, they will downgrade
reticulate::conda_install(envname = 'r-reticulate', packages = c(
  "altair",
  "beautifulsoup4",
  "cloudpickle",  # can not resolve
  "cython",
  "dask",
  "gensim",
  "ipykernel",
  "jupyter",
  "jupyterlab",  # can not resolve
  "matplotlib",
  "nltk",
  "numpy",
  "opencv",
  "pandas",
  "pillow",
  "pyarrow",
  "requests",
  "scipy",
  "scikit-image",
  "scikit-learn",
  "scrapy",
  "seaborn",
  "slugify",
  "spacy",
  "sqlalchemy",
  "statsmodels",
  "xgboost"
), method="conda")

install.packages("BiocManager", ask=FALSE)
BiocManager::install(version = "3.12", ask=FALSE, Ncpus=myNcpus)

# FROM docker image vbarrerab/singlecell-base:R.4.0.3-BioC.3.11-ubuntu_20.04
pkgs_to_install <- c("remotes","tidyverse","tibble","RCurl",
"cowplot","SingleCellExperiment","scater","reticulate", "AnnotationHub",
"ensembldb", "rio","devtools","XLConnect","janitor",
"pheatmap","DESeq2","reshape")

pkgs_to_install <- union(pkgs_to_install, c(
	"abind",
        "ape",  # for Seurat
	"BiocStyle",
	"brms",
	"broom",
	"caret",
	"coda",
	"cowplot",
	"dagitty",
	"DMwR2",  # for Seurat
	"emmeans",
        "enrichR",  # for Seurat
	"flextable",
	"ggdag",
	"ggdark",
	"ggrepel",
	"ggridges",
	"ggstance",
        "glmGamPoi", # for Seurat
	"gridExtra",
        "irlba",  # for Seurat
	"learnr",
	"lime",
	"limma",  # for Seurat
	"loo",
	"kableExtra",
	"magick",
        "MAST",  # for Seurat
        "metap",  # for Seurat
        "mixtools",  # for Seurat
	"modelr",
	"mvtnorm",
        "multtest",  # for Seurat
	"officer",
	"openxlsx",
	"pacman",
	"patchwork",
	"plyr",
	"randomForest",
	"RefManageR",
        "Rfast2",  # for Seurat
	"rjson",
	"rstan",
        "rsvd",  # for Seurat
	"rvg",
	"tidybayes",
        "tidyjson",
	"tidyverse",
	"tidyxl",
	"unpivotr",
        "vembedr",  # for Seurat
	"viridis"
 ))


## Start the actual installation:
# Only install packages from CRAN or Bioconductor.
# For example, rstudio/reticulate will corrupt the package database if
# installed here. Let do it separately, one GitHub at a time!
ok <- BiocManager::install(pkgs_to_install, ask=FALSE, Ncpus=myNcpus)

# print(ok)
# oktf <- ok %in% rownames(installed.packages())
# if ( !all(oktf) )
#     stop("Failed to install:\n  ",
#          paste(pkgs_to_install[!oktf], collapse="  \n  "))


## install Keras/Tensorflow ##

# pip install intel-tensorflow  #=v2.4.1, NOT checking compatibility for all packages
reticulate::py_install( c("tensorflow",
                          "keras",
                          "tensorflow-datasets",
                          "tensorflow-probability"),
                        method = "conda", pip=TRUE)
install.packages("tensorflow", ask=FALSE)
#tensorflow::install_tensorflow(method = "conda")
library("tensorflow")
library("tfruns")


# Let Keras install tensorflow ... very compatible but slower
install.packages("keras", ask=FALSE)
keras::install_keras(method = "conda", tensorflow="2.4",
  extra_packages = c("tensorflow-hub", "tensorflow-datasets", "tensorflow-probability"))
# keras::install_keras(method = "conda")
library("keras")

install.packages("tfdatasets", ask=FALSE)
library("tfdatasets")

install.packages("tfhub", ask=FALSE)
tfhub::install_tfhub(method = "conda")
library("tfhub")

install.packages("tfprobability", ask=FALSE) # wants TF v2.4
library("tfprobability")
tfprobability::install_tfprobability(method = "conda")

# little speed gain on Intel CPU only, but we are loosing compatibility...
reticulate::py_install( c("intel-tensorflow",
                          "keras",
                          "tensorflow-datasets",
                          "tensorflow_probability"),
                        method = "conda", pip=TRUE)


BiocManager::install("rstudio/tfds", ask=FALSE, Ncpus=myNcpus)
library("tfds")
# tfds::install_tfds(method = "conda")

## double-check ##
#library(tensorflow)
#library(tfhub)
#library(tfds)
#library(tfprobability)
#library(tfdatasets)
#library(tfruns)
#library(keras)

#tf.dollar.constant("Hi Tensorflow") # piping kills .dollar. character!
#tf.dollar."__version__"

#tf$compat$v2$enable_v2_behavior()
#d <- tfd_binomial(total_count = 7, probs = 0.3)
#d %>% tfd_mean()
#d %>% tfd_variance()
#d %>% tfd_prob(2.3)

#mnist <- dataset_mnist()
#mnist <- tfds_load("mnist")
#module <- hub_load("https://tfhub.dev/google/tf2-preview/mobilenet_v2/feature_vector/2")


## install Serat to make sure it will upgrade/downgrade pythonics as it needs ##

rio::install_formats()

BiocManager::install("rmcelreath/rethinking", ask=FALSE, Ncpus=myNcpus)

BiocManager::install("immunogenomics/harmony", ask=FALSE, Ncpus=myNcpus)

# remotes::install_github("satijalab/seurat", ref = "release/4.0.0")
# remotes::install_github("jlmelville/uwot")
BiocManager::install("Seurat", ask=FALSE, Ncpus=myNcpus)

BiocManager::install('satijalab/seurat-data', ask=FALSE, Ncpus=myNcpus)

