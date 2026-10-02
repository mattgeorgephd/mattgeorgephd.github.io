---
layout: post
title: Useful R code
subtitle: Useful R code chunks for easy pasting
tags: tutorials
comments: true
---

#### (1) Set/jump to working dir:
```
# Grab the WD from the file location and set it
library(rstudioapi)
home <- getActiveDocumentContext()$path
setwd(dirname(home)); getwd(); setwd('..')
home <- getwd(); getwd()
```

#### (2) set my_theme:
```
# Set my_theme for use with ggplot2
my_theme <- theme(line              = element_line(size=1.5),
                  rect              = element_rect(size=1.5),
                  text              = element_text(size=14,color="black"),
                  panel.background  = element_blank(),
                  panel.grid.major  = element_blank(),
                  panel.grid.minor  = element_blank(),
                  axis.text.x       = element_text(size=16,color="black"),
                  axis.text.y       = element_text(size=16,color="black"),
                  axis.title.x      = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)),
                  axis.title.y      = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
                  axis.ticks.x      = element_line(color="black"),
                  axis.ticks.y      = element_line(color="black"),
                  # axis.line       = element_line(color = "black", size = 0.1),
                  panel.border      = element_rect(color = "black", fill=NA, size=1.5),
                  legend.key        = element_blank()) # removes background of legend bullets
```

#### (3) Easy package loading:
```
# Add all required libraries that are installed with install.packages() here
list.of.packages <- c("tidyverse", "lubridate")
# Add all libraries that are installed using BiocManager here
bioconductor.packages <- c("DESeq2", "WGCNA")

# Install BiocManager if needed
if(!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")

# Get names of all required packages that aren't installed
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[, "Package"])]
new.bioc.packages <- bioconductor.packages[!(bioconductor.packages %in% installed.packages()[, "Package"])]
# Install all new packages
if(length(new.packages)) install.packages(new.packages)
if(length(new.bioc.packages)) BiocManager::install(new.bioc.packages)

# Load all required libraries
all.packages <- c(list.of.packages, bioconductor.packages)
lapply(all.packages, FUN = function(X) {
  do.call("require", list(X))
})
```
