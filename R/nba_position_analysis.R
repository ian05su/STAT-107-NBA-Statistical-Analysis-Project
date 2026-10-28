# STAT 1-7 - NBA Statistical Analysis Project
# Title: Average Points Per Game by NBA Position (2024-2025)
# Research Question: Which basketball position scores the most points per game?

# 1. Load the dataset
nba_data <- read.csv("data/nba_2024_25.csv")

# 2. Remove duplicate player records
# combined-season statistics appear first for traded players.
nba_clean <- nba_data[!duplicated(nba_data$Player.additional), ]

# 3. Check the number of unique players
nrow(nba_clean)

# 4. Calculate average points per game by position
avg_pts <- aggregate(PTS ~ Pos, data = nba_clean, FUN = mean)

# 5. Display the results
print(avg_pts)

# 6. Create a bar chart
barplot(
  avg_pts$PTS,
  names.arg = avg_pts$Pos,
  main = "Average Points Per Game by NBA Position (2024-25)",
  xlab = "Player Position",
  ylab = "Average Points Per Game",
  col = "steelblue",
  ylim = c(0, 12)
)