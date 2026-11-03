# STAT 107 – NBA Statistical Analysis Project

**Team:** Jashwant, Ian, Aryenn

## Project question

In the 2024–25 NBA season, does a player's listed position (PG, SG, SF, PF, C)
predict scoring (points per game), and does any difference remain after
accounting for playing time?

## Data

- **Source:** Basketball-Reference, *2024-25 NBA Player Stats: Per Game*,
  <https://www.basketball-reference.com/leagues/NBA_2025_per_game.html>
  (downloaded [DATE] as CSV).
- **File:** `data/nba_2024_25.csv`. 735 rows × 32 columns, one row per
  player per team. Players traded during the season have a season-total row
  (`2TM`/`3TM`) plus one row per team.
- **After cleaning:** 569 players. **Used in the analysis:** 456 players
  with at least 20 games played.

## Files

Files are numbered in the order they run.

| File | Role |
|---|---|
| `README.md` | This guide: file descriptions and how to reproduce the results |
| `STAT107-NBA-Analysis.Rproj` | RStudio project. Open this first so all file paths work |
| `data/nba_2024_25.csv` | Raw data from Basketball-Reference |
| `00_requirements.R` | Installs (if missing) and loads the packages used: `knitr`, `rmarkdown` |
| `01_funct_DataCleaning.R` | Functions for loading the CSV, counting missing values, removing duplicate rows, and finding position changes |
| `02_funct_DataProcessing.R` | Functions for the minimum-games filter, means by position, and per-36-minute rates |
| `03_funct_Plots.R` | Functions for summary tables, histograms, boxplots, and scatterplots by position |
| `11_DataCleaning.Rmd` | Cleans the raw data: missing values, duplicates, variable selection, formatting. Saves `12_DataSaving.RData` |
| `12_DataSaving.RData` | Cleaned data (`nba_clean`, 569 players). Created by `11_DataCleaning.Rmd` |
| `21_DataProcessing.Rmd` | Applies the 20-game inclusion rule and adds points per 36 minutes. Saves `22_DataSaving.RData` |
| `22_DataSaving.RData` | Processed data (`nba_model`, 456 players). Created by `21_DataProcessing.Rmd` |
| `31_DataVisualization.Rmd` | Summary tables and plots, each with an interpretation |
| `FinalReport.Rmd` | The project report (R Markdown source) |
| `FinalReport.pdf` | The knitted report |

## How to reproduce the results

1. Install R (version 4.3 or later) and RStudio.
2. Clone or download this repository.
3. Open `STAT107-NBA-Analysis.Rproj` in RStudio. This sets the working
   directory to the project folder, so no file paths need to be changed.
4. Run `00_requirements.R` to install and load the required packages.
5. Knit the files **in this order** (each one uses the output of the one
   before it):
   1. `11_DataCleaning.Rmd` → creates `12_DataSaving.RData`
   2. `21_DataProcessing.Rmd` → creates `22_DataSaving.RData`
   3. `31_DataVisualization.Rmd`
   4. `FinalReport.Rmd` → creates `FinalReport.pdf`

**Note:** knitting to PDF requires LaTeX. If it fails, run this once in the
R console, then knit again:

```r
install.packages("tinytex")
tinytex::install_tinytex()
```

## Expected results

If everything ran correctly, you should see:

- `11_DataCleaning.Rmd`: 735 rows reduced to 569 players, with 0 duplicates.
- `21_DataProcessing.Rmd`: 456 players kept, 113 removed.
- `31_DataVisualization.Rmd`: mean points per game of 10.9 for point guards
  and 9.3 for centers, and a correlation of 0.88 between minutes and points
  per game.
