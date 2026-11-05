# Requirements:
# trial_summary from read_data.R


library(ggplot2)
library(dplyr)
library(patchwork)

# Prereq: run read_data before this to get the trial_summary data frame

# Calculate means for each Visibility x Configuration combination
interaction_data <- trial_summary %>%
  dplyr::group_by(visibility, Config_Number) %>%
  dplyr::summarise(
    mean_speed = mean(Mean_Velocity, na.rm = TRUE),
    mean_MAAA = mean(MAAA, na.rm = TRUE),
    mean_resets = mean(count_reset, na.rm = TRUE),
    mean_total_steering = mean(Total_Steering, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  dplyr::mutate( # visibility as factor to show what's being modeled
    visibility = factor(
      visibility,
      levels = c(25, 30, 40, 55, 150),
      labels = c("25", "30", "40", "55", "Full")
    ),
    Config_Number = factor(Config_Number)
  )


# Mean speed
speed_interaction <- ggplot(
  interaction_data,
  aes(
    x = visibility,
    y = mean_speed,
    group = Config_Number,
    color = Config_Number
  )
) +
  geom_line() +
  geom_point() +
  labs(
    title = "Mean Speed",
    x = "Visibility",
    y = "Mean Speed (m/s)",
    color = "Configuration"
  ) 

# MAAA
MAAA_interaction <- ggplot(
  interaction_data,
  aes(
    x = visibility,
    y = mean_MAAA,
    group = Config_Number,
    color = Config_Number
  )
) +
  geom_line() +
  geom_point() +
  labs(
    title = "Mean Absolute Angular Acceleration",
    x = "Visibility",
    y = "MAAA (deg/s²)",
    color = "Configuration"
  ) 

# Resets
resets_interaction <- ggplot(
  interaction_data,
  aes(
    x = visibility,
    y = mean_resets,
    group = Config_Number,
    color = Config_Number
  )
) +
  geom_line() +
  geom_point() +
  labs(
    title = "Mean Resets",
    x = "Visibility",
    y = "Mean Number of Resets",
    color = "Configuration"
  ) 


# Total steering
steering_interaction <- ggplot(
  interaction_data,
  aes(
    x = visibility,
    y = mean_total_steering,
    group = Config_Number,
    color = Config_Number
  )
) +
  geom_line() +
  geom_point() +
  labs(
    title = "Mean Total Steering",
    x = "Visibility",
    y = "Total Steering (deg)",
    color = "Configuration"
  ) 

# Patch them together
speed_interaction +
  MAAA_interaction +
  resets_interaction +
  steering_interaction +
  plot_annotation(title = "Interaction plots") +
  plot_layout(guides = 'collect') 

