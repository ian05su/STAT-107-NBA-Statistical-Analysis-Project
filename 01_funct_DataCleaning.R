
# Purpose: Reads the raw player stats
# Input: path - location of the data set
# Output: a data frame with one row per player per team
load_raw_data <- function(path) {
  read.csv(path, fileEncoding = "UTF-8-BOM")
  return(data)
}


# Purpose: count the missing values (NA) in each column
# Input: df - Data frame
# Output: vector with the amount of missing values with columns that have atleast one missing value
count_missing <- function(df) {
  n_missing <- apply(df, MARGIN = 2, FUN = function(column) sum(is.na(column)))
  return(n_missing[n_missing > 0])
}


# Purpose: Keeps one row per player. Any player that got traded will have more rows (2TM/3TM) and will be listed first. Any duplicated row will be removed
# Input: df - raw data frame with unique player ID
# Output: data frame with only one row per player
remove_duplicate_players <- function(df) {
  is_repeat <- duplicated(df$Player.additional)
  return(df[!is_repeat, ])
}

# Purpose: Find which players were traded and listed at different positions on different teams.
# Input: df - data frame before removing the duplicates
# Output: data frame with the players name and every position he was listed at
find_position_changes <- function(df) {
  traded_id <- unique(df$Player.additional[duplication(df$Player.additional)])
  
  name_change <- c()
  position_change <- c()
  
  for (id in traded_id) {
    player_rows <- df[df$Player.additional == id, ]
    positions <- unique(player_rows$Pos)
    if (length(positions) > 1) {
      name_change <- c(name_change, players_row$Player[1])
      position_change <- c(position_change, paste(positions, collapse = "/"))
    }
  }
  return(data.frame(player = name_change, positions = position_change))
}


