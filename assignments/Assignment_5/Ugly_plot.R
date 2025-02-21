
library(ggplot2)
data <- mtcars
ugly_plot <- ggplot(data, aes(x = mpg, y = hp, color = as.factor(cyl))) +
  geom_point(size = 5) + # Oversized points
  scale_color_manual(values = c("red", "green", "blue")) + # Clashing colors for discrete variable
  labs(title = "Ugly Plot", x = "Miles Per Gallon (wrong scale)", y = "Horsepower (wrong scale)") +
  theme(
    plot.title = element_text(size = 5), # Tiny title font
    axis.title.x = element_text(size = 5), # Tiny x-axis label
    axis.title.y = element_text(size = 5), # Tiny y-axis label
    legend.position = "bottom", # Awkward legend position
    legend.title = element_text(size = 5), # Tiny legend title
    legend.text = element_text(size = 5) # Tiny legend text
  ) +
  facet_wrap(~gear, scales = "free") + # Inappropriate facets
  geom_smooth(method = "lm", se = FALSE) # Adding a meaningless geom
View(ugly_plot)
print(ugly_plot)

install.packages("ggimage")
library(ggimage)
data$image <- "Data_Course_Rasmussen/assignments/Assignment_5/Ugly.png"

ugly_plot <- ggplot(data, aes(x = mpg, y = hp, image = image)) +
  geom_image(size = 0.1) + # Adjust size as needed
  scale_color_manual(values = c("red", "green", "blue")) + # Clashing colors for discrete variable
  labs(title = "Ugly Plot", x = "Miles Per Gallon (wrong scale)", y = "Horsepower (wrong scale)") +
  theme(
    plot.title = element_text(size = 5), # Tiny title font
    axis.title.x = element_text(size = 5), # Tiny x-axis label
    axis.title.y = element_text(size = 5), # Tiny y-axis label
    legend.position = "bottom", # Awkward legend position
    legend.title = element_text(size = 5), # Tiny legend title
    legend.text = element_text(size = 5) # Tiny legend text
  ) +
  facet_wrap(~gear, scales = "free") + # Inappropriate facets
  geom_smooth(method = "lm", se = FALSE) # Adding a meaningless geom
print(ugly_plot)

install.packages("grid")
library(grid)
install.packages("png")
library(png)

background_image <- rasterGrob(readPNG("Data_Course_Rasmussen\assignments\Assignment_5\Background.png"), 
                               width = unit(1, "npc"), height = unit(1, "npc"))

ugly_plot <- ggplot(data, aes(x = mpg, y = hp, image = image)) +
  annotation_custom(background_image, -Inf, Inf, -Inf, Inf) + # Add background image
  geom_image(size = 0.05) + # Adjust size as needed
  scale_color_manual(values = c("red", "green", "blue")) + # Clashing colors for discrete variable
  labs(title = "Ugly Plot", x = "Miles Per Gallon (wrong scale)", y = "Horsepower (wrong scale)") +
  theme(
    plot.title = element_text(size = 5), # Tiny title font
    axis.title.x = element_text(size = 5), # Tiny x-axis label
    axis.title.y = element_text(size = 5), # Tiny y-axis label
    legend.position = "bottom", # Awkward legend position
    legend.title = element_text(size = 5), # Tiny legend title
    legend.text = element_text(size = 5) # Tiny legend text
  ) +
  facet_wrap(~gear, scales = "free") + # Inappropriate facets
  geom_smooth(method = "lm", se = FALSE) # Adding a meaningless geom
print(ugly_plot)

install.packages("gganimate")
library(gganimate)
library(ggplot2)
library(ggimage)
library(grid)
library(png)
library(gganimate)

ugly_plot <- ggplot(data, aes(x = mpg, y = hp, image = image)) +
  annotation_custom(background_image, -Inf, Inf, -Inf, Inf) + # Add background image
  geom_image(size = 0.05) + # Adjust size as needed
  scale_color_manual(values = c("red", "green", "blue")) + # Clashing colors for discrete variable
  labs(title = "Ugly Plot", x = "Miles Per Gallon (wrong scale)", y = "Horsepower (wrong scale)") +
  theme(
    plot.title = element_text(size = 5), # Tiny title font
    axis.title.x = element_text(size = 5), # Tiny x-axis label
    axis.title.y = element_text(size = 5), # Tiny y-axis label
    legend.position = "bottom", # Awkward legend position
    legend.title = element_text(size = 5), # Tiny legend title
    legend.text = element_text(size = 5) # Tiny legend text
  ) +
  facet_wrap(~gear, scales = "free") + # Inappropriate facets
  geom_smooth(method = "lm", se = FALSE) + # Adding a meaningless geom
  transition_states(gear, transition_length = 2, state_length = 1) + # Animate by gear
  enter_grow() + # Grow effect for entering points
  exit_fade() # Fade effect for exiting points

animate(ugly_plot, nframes = 100, fps = 10)
