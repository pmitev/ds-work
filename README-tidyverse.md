# Running singularity Rstudio server with tidyverse from https://github.com/rocker-org/rocker-versioned2
Documentation: https://hub.docker.com/r/rocker/tidyverse
``` bash
# Pull the image locally
singularity pull --name tidyverse.simg docker://rocker/tidyverse:latest

# Make local var to map to the container's /var
mkdir -p var
singularity exec -B $(pwd):/home/rstudio -B var:/var tidyverse.simg rserver
```


