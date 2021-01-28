BiocManager::install(version = "3.12", ask=FALSE, Ncpus=4)

pkgs_to_install <- c(
	"brms",
	"broom",
	"coda",
	"cowplot",
	"dagitty",
	"emmeans",
	"flextable",
	"ggdag",
	"ggdark",
	"ggrepel",
	"ggridges",
	"ggstance",
	"loo",
	"modelr",
	"mvtnorm",
	"officer",
	"openxlsx",
	"pacman",
	"patchwork",
	"rstan",
	"rvg",
	"tidybayes",
	"tidyverse",
	"tidyxl",
	"unpivotr",
	"viridis" )

## Start the actual installation:
ok <- BiocManager::install(pkgs_to_install, ask=FALSE, Ncpus=4) %in% rownames(installed.packages())
if (!all(ok))
    stop("Failed to install:\n  ",
         paste(pkgs_to_install[!ok], collapse="  \n  "))

remotes::install_github("rmcelreath/rethinking", ask=FALSE, Ncpus=4)

remotes::install_github("satijalab/seurat", ref = "release/4.0.0", ask=FALSE, Ncpus=4)
remotes::install_github("jlmelville/uwot", ask=FALSE, Ncpus=4)
devtools::install_github('satijalab/seurat-data', ask=FALSE, Ncpus=4)

BiocManager::install(update=TRUE, ask=FALSE)
