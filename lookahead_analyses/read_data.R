# Run this file before any other analyses to parse the data
#
# trial_summary: each row is the summarized data for that trial
#
# visibility_summary: each row is the summarized data for a participant in 
#                     each visibility condition
#
# clean_data: full experimental data for each timestamp, containing only
#             successful trials. necessary for plotting code
#             NOTE: not on github. CSV needs to be downloaded separately
#             (link in the README)
#
# obstacle_df: data frame with all obstacles in each configuration. necessary
#              for plotting code

library(dplyr)
library(tidyr)

# Summaries
trial_summary <- read.csv("lookahead_data/trial_summary.csv")
visibility_summary <- read.csv("lookahead_data/visibility_summary.csv")

# Full (experimental) data
clean_data <- read.csv("lookahead_data/clean_data.csv")

# Obstacle data
obstacle_data <- read.csv("lookahead_data/lookahead_obstacles.csv", header = TRUE)
trial_buffer <- 25

obstacle_df <- obstacle_data %>%
  dplyr::filter(!grepl("Config", X_Pos)) %>%
  dplyr::mutate(
    X_Pos = as.numeric(X_Pos),
    Z_Pos = as.numeric(Z_Pos) + trial_buffer
  )

configurations_list <- split(obstacle_df, obstacle_df$Configuration)
