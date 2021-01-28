# ds-work
Rstudio singularity environment

# Building the environment

## Build into an image
```
$ sudo singularity build ds-work.sif Singularity
# run
$ ./ds-work.sif
```

## Build into a sandbox
```
sudo singularity build --sandbox ds-work/ Singularity

# run (add sudo if you want to install packages or experiment with the image)
$ singularity shell --writable ds-work/
```
