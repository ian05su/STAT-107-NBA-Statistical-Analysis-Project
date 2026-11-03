# STAT 107 - NBA Statistical Analysis Project
# Section 2.3: Required R Packages

# List of required packages
required_packages <- c(
  "rmarkdown",
  "knitr"
)

# Installs (if missing) and loads the packages used in the project.
if (!require("knitr")) {
  install.packages("knitr", repos = "https://cloud.r-project.org")
}
library(knitr)

if (!require("rmarkdown")) {
  install.packages("rmarkdown", repos = "https://cloud.r-project.org")
}
library(rmarkdown)