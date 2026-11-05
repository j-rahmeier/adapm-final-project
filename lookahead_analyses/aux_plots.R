library(ggplot2)
library(ggforce)

#Drone position
drone_x <- 0
drone_z <- 15

# df for vis conditions around the drone
radius_df <- data.frame(
  x0 = drone_x,
  z0 = drone_z,
  r = c(25, 30, 40, 55, 150)
)

ggplot() +
  # obstacle configuration
  geom_circle(
    data = configurations_list[[1]],
    aes(x0 = Z_Pos, y0 = X_Pos, r = 1),
    fill = "brown",
    alpha = 0.8
  ) +
  
  # start gate at z = 150
  geom_segment(
    aes(y = -5, yend = 5, x = 150, xend = 150),
    linewidth = 1
  ) +
  
  # end gate at z = 0
  geom_segment(
    aes(y = -5, yend = 5, x = 0, xend = 0),
    linewidth = 1
  ) +
  
  # drone dot at z = 25
  geom_point(
    aes(y = drone_x, x = drone_z),
    size = 3
  ) +
  geom_circle(
    data = radius_df,
    aes(y0 = x0, x0 = z0, r = r, color = factor(r), fill = factor(r)),
    #fill = NA,
    #linetype = "dashed",
    alpha = 0.2,
    linewidth = 0.8,
    key_glyph = "path" # to change the way the labels show
  ) +
  # X-coordinates are mapped to the vertical axis.
  geom_hline(yintercept = c(-30, 30), linetype = "dashed", linewidth = 0.5) +
  coord_fixed(
    ratio = 1,
    ylim = c(-35, 35),
    xlim = c(-5, 160),
    expand = FALSE
  ) +
  labs(
    y = "X-coord",
    x = "Z-coord",
    color = "Visibility condition"
  ) +
  scale_color_discrete(
  name = "Visibility",
  labels = c("25 m", "30 m", "40 m", "55 m", "Full"),
  palette = c("#6b2d2d", "#b93f3f", "#d76b3c", "#d69f3d", "#bfb65b")
  ) +
  scale_fill_discrete(
  name = "Visibility",
  labels = c("25 m", "30 m", "40 m", "55 m", "Full"),
  palette = c("#6b2d2d", "#b93f3f", "#d76b3c", "#d69f3d", "#bfb65b")
  ) +
  theme_bw() +
  theme(
    legend.position = "inside",
    legend.position.inside = c(0.98, 0.02),
    legend.justification = c(1, 0),
    legend.title = element_text(size = 11),
    legend.text = element_text(size = 10),
    legend.key.size = grid::unit(0.45, "cm"),
    legend.margin = margin(4, 4, 4, 4),
    legend.background = element_rect(
      fill = "white", colour = "grey70", linewidth = 0.3
    )
  )
