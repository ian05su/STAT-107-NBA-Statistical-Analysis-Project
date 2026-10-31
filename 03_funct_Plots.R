
position_names  <- c("PG", "SG", "SF", "PF", "C")
position_colors <- c("#2a78d6", "#eb6834", "#1baf7a", "#eda100", "#e87ba4")
position_shapes <- c(16, 17, 15, 18, 1)



# Purpose: Summary statistics of one variable for each position.
# Input: values - a numeric vector (e.g. points per game), pos - the position factor, same length as values
# Output: a data frame with one row per position and the columns n, mean, median, sd, min, max (rounded to 1 decimal)
summary_by_position <- function(values, pos) {
  n_pos <- length(position_names)
  n      <- rep(0, n_pos)
  avg    <- rep(0, n_pos)
  med    <- rep(0, n_pos)
  st_dev <- rep(0, n_pos)
  low    <- rep(0, n_pos)
  high   <- rep(0, n_pos)
  
  for (i in 1:n_pos) {
    group     <- values[pos == position_names[i]]
    n[i]      <- length(group)
    avg[i]    <- mean(group)
    med[i]    <- median(group)
    st_dev[i] <- sd(group)
    low[i]    <- min(group)
    high[i]   <- max(group)
  }
  
  result <- data.frame(position = position_names, n = n,
                       mean = round(avg, 1), median = round(med, 1),
                       sd = round(st_dev, 1), min = round(low, 1),
                       max = round(high, 1))
  return(result)
}


# Purpose: Histogram of one variable for all players, with a dashed line at the median and a dotted line at the mean.
# Input:   values - a numeric vector
#          title  - the plot title
#          xlab   - the x-axis label (include units)
# Output:  none (draws a plot)
plot_hist <- function(values, title, xlab) {
  hist(values, breaks = 30, main = title, xlab = xlab,
       ylab = "Number of players", col = "#2a78d6", border = "white")
  abline(v = median(values), lty = 2, lwd = 2)
  abline(v = mean(values), lty = 3, lwd = 2)
  legend("topright", legend = c("Median", "Mean"), lty = c(2, 3), lwd = 2)
}


# Purpose: One histogram per position, side by side, all on the same x-axis and bins so the positions can be compared directly.
# Input:   values - a numeric vector (e.g. points per game)
#          pos    - the position factor, same length as values
#          xlab   - the x-axis label (include units)
# Output:  none (draws a 2 x 3 grid of plots)
plot_hist_by_position <- function(values, pos, xlab) {
  bins <- seq(0, max(values) + 2, by = 2)   # same 2-unit bins for every group
  par(mfrow = c(2, 3))
  for (i in 1:length(position_names)) {
    group <- values[pos == position_names[i]]
    hist(group, breaks = bins, main = position_names[i], xlab = xlab,
         ylab = "Number of players", col = position_colors[i],
         border = "white")
    abline(v = median(group), lty = 2, lwd = 2)
  }
  par(mfrow = c(1, 1))                      # back to one plot per figure
}

# Purpose: Boxplot of one variable by position, with a white diamond at the mean of each position.
# Input:   values - a numeric vector
#          pos    - the position factor, same length as values
#          title  - the plot title
#          ylab   - the y-axis label (include units)
# Output:  none (draws a plot)
plot_box_by_position <- function(values, pos, title, ylab) {
  boxplot(values ~ pos, main = title, xlab = "Position", ylab = ylab,
          col = position_colors)
  for (i in 1:length(position_names)) {
    group_mean <- mean(values[pos == position_names[i]])
    points(i, group_mean, pch = 23, bg = "white", cex = 1.3)
  }
}

# Purpose: Scatterplot of y against x, with each position in its own color and shape, plus a straight fitted line for each position. If the lines lie on top of each other, position adds little once x is known.
# Input:   x, y  - numeric vectors of the same length
#          pos   - the position factor, same length as x and y
#          title - the plot title xlab, ylab - the axis labels (include units)
# Output:  none (draws a plot)
plot_scatter_by_position <- function(x, y, pos, title, xlab, ylab) {
  # Empty plot first (type = "n"), then add each position's points.
  plot(x, y, type = "n", main = title, xlab = xlab, ylab = ylab)
  for (i in 1:length(position_names)) {
    in_group <- pos == position_names[i]
    points(x[in_group], y[in_group], col = position_colors[i],
           pch = position_shapes[i], cex = 0.8)
    abline(lm(y[in_group] ~ x[in_group]), col = position_colors[i], lwd = 2)
  }
  legend("topleft", legend = position_names, col = position_colors,
         pch = position_shapes, lwd = 2)
}

