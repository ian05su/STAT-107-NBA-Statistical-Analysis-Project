# STAT 107 - NBA Statistical Analysis Project
# Section 2.3: Required R Packages

# List of required packages
required_packages <- c(
  "dplyr",
  "ggplot2",
  "tidyr",
  "readr",
  "rmarkdown",
  "knitr"
)

# Install packages if they are missing
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}

# Load all required packages
invisible(lapply(required_packages, library, character.only = TRUE))