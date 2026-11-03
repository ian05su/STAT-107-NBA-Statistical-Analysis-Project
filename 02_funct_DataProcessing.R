
# Purpose: Keep the players who played at least "min_games" and print how many players were kept/removed
# Input: df - data frame with a games column
# Output: filtered data frame
filter_min_games <- function(df, min_games) {
  kept <- df[df$games >= min_games, ]
  print(paste("Players Kept: ", nrow(kept)))
  print(paste("Players removed", nrow(df) - nrow(kept)))
  return(kept)
}


# Purpose: Average of one variable for each position
# Input: values - number vector like points per game (ppg) 
#        pos - position factor will have the length of values
# Output: vector with one mean per position
mean_by_position <- function(values, pos) {
  positions <- levels(pos)
  means <- rep(0, length(positions))
  for (i in 1:length(positions)) {
    means[i] <- mean(values[pos == positions[i]])
  }
  names(means) <- positions
  return(round(means, 1))
}


# Purpose: Convert per-game statistics into per 38 minutes. Compares players who play different minutes
# Input: stat_per_game - points per game, minutes - minutes per game
# Output: statistic per 38 minutes
per36 <- function(stat_per_game, minutes) {
  return(stat_per_game / minutes * 36)
}

