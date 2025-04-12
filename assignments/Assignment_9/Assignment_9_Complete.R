

#start here!

data <- read.csv("GradSchool_Admissions.csv")
library(tidyverse)
library(dplyr)
library(ggplot2)
library(tidyr)
library(performance)
library(plotly)
library(reshape2)
library(magrittr)
library(vegan)

# Display the column names
colnames(data)
#summary
summary(data)

# Relationships

model_gre_admit <- glm(admit ~ gre, data = data, family = binomial)
summary(model_gre_admit)


model_gpa_admit <- glm(admit ~ gpa, data = data, family = binomial)
summary(model_gpa_admit)


model_rank_admit <- glm(admit ~ rank, data = data, family = binomial)
summary(model_rank_admit)

#plotting GRE vs GPA and correlation test

plot(data$gre, data$gpa)
cor(data$gre, data$gpa)
cor.test(data$gre, data$gpa)

#Data frame for plotting

plot_data <- data.frame(
  gre = data$gre,
  gpa = data$gpa,
  rank = data$rank,
  admit = data$admit,
  pred_gre = predict(model_gre_admit, type = "response"),
  pred_gpa = predict(model_gpa_admit, type = "response"),
  pred_rank = predict(model_rank_admit, type = "response"))

#plotting the predicted probabilites

ggplot(plot_data, aes(x = gre, y = pred_gre)) +
  geom_line(color = "blue") +
  geom_point(aes(y = admit), alpha = 0.3) +
  labs(title = "Admission Probability vs GRE Score", x = "GRE Score", y = "Admission Probability") +
  theme_minimal()


ggplot(plot_data, aes(x = gpa, y = pred_gpa)) +
  geom_line(color = "green") +
  geom_point(aes(y = admit), alpha = 0.3) +
  labs(title = "Admission Probability vs GPA Score", x = "GPA Score", y = "Admission Probability") +
  theme_minimal()


ggplot(plot_data, aes(x = rank, y = pred_rank)) +
  geom_line(color = "red") +
  geom_point(aes(y = admit), alpha = 0.3) +
  labs(title = "Admission Probability vs Rank", x = "Rank", y = "Admission Probability") +
  theme_minimal()


# combined

plot_data_long <- plot_data %>%
  pivot_longer(cols = c(gre, gpa, rank), names_to = "variable", values_to = "value") %>%
  pivot_longer(cols = starts_with("pred_"), names_to = "model", values_to = "predicted")


ggplot(plot_data_long, aes(x = value, y = predicted)) +
  geom_line() +
  geom_point(aes(y = admit), alpha = 0.3) +
  facet_wrap(~ model, scales = "free_x", labeller = labeller(model = c(pred_gre = "GRE Score", pred_gpa = "GPA Score", pred_rank = "Rank"))) +
  labs(title = "Admission Probability vs GRE, GPA, and Rank", x = "Score/Rank", y = "Admission Probability") +
  theme_minimal()


ggplot(plot_data_long, aes(x = value, y = predicted)) +
  geom_smooth(method = "glm", method.args = list(family = "binomial"), se = FALSE) +
  facet_wrap(~ model, scales = "free_x", labeller = labeller(model = c(pred_gre = "GRE Score", pred_gpa = "GPA Score", pred_rank = "Rank"))) +
  labs(title = "Admission Probability vs GRE, GPA, and Rank", x = "Score/Rank", y = "Admission Probability") +
  theme_minimal()

#models with varying complexities


model_gre_gpa_admit <- glm(admit ~ gre + gpa, data = data, family = binomial)
summary(model_gre_gpa_admit)


model_full_admit <- glm(admit ~ gre + gpa + rank, data = data, family = binomial)
summary(model_full_admit)

#compare performance

AIC(model_gre_gpa_admit, model_full_admit)

comp <- compare_performance(model_gre_gpa_admit, model_full_admit) %>%
  plot()
print(comp)

#predictions vs observed
#add predictions
data$predicted_prob <- predict(model_full_admit, type = "response")


ggplot(data, aes(x = predicted_prob, fill = factor(admit))) +
  geom_density(alpha = 0.5) +
  labs(title = "Predicted Probability by Admission Outcome",
       x = "Predicted Probability",
       fill = "Admitted") +
  theme_minimal()
# This really didn't show what I was looking for so I went back to the drawing board

model_interact <- glm(admit ~ gre * gpa + rank, data = data, family = binomial)
summary(model_interact)
compare_performance(model_full_admit, model_interact)

gre_vals <- seq(min(data$gre), max(data$gre), length.out = 100)
gpa_vals <- seq(min(data$gpa), max(data$gpa), length.out = 100)
rank_levels <- unique(data$rank)

prediction_grid <- expand.grid(gre = gre_vals,
                               gpa = gpa_vals,
                               rank = rank_levels)

prediction_grid$predicted_prob <- predict(model_interact, newdata = prediction_grid, type = "response")

ggplot(prediction_grid, aes(x = gre, y = gpa, fill = predicted_prob)) +
  geom_tile() +
  facet_wrap(~ rank) +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(title = "Predicted Admission Probability (GRE * GPA Interaction)",
       x = "GRE Score", y = "GPA", fill = "Admission Probability") +
  theme_minimal()


prediction_grid_rank1 <- prediction_grid[prediction_grid$rank == 1, ]

z_matrix <- acast(prediction_grid_rank1, gpa ~ gre, value.var = "predicted_prob")

plotly::plot_ly(
  x = gre_vals,
  y = gpa_vals,
  z = z_matrix
) %>%
  plotly::add_surface(colorscale = "Blues") %>%
  plotly::layout(
    title = list(text = "Predicted Admission Probability (GRE * GPA Interaction, Rank 1)"),
    scene = list(
      xaxis = list(title = "GRE"),
      yaxis = list(title = "GPA"),
      zaxis = list(title = "Admission Probability")
    )
  )

#predictor vs test data

#train the data
set.seed(123)
train_indices <- sample(1:nrow(data), size = 0.7 * nrow(data))
train_data <- data[train_indices, ]
test_data <- data[-train_indices, ]
# interaction model
model_interact <- glm(admit ~ gre * gpa + rank, data = train_data, family = binomial)
# add probabilites and make them binary
test_data$predicted_prob <- predict(model_interact, newdata = test_data, type = "response")
# convert to lables and a threshold
test_data$predicted_class <- ifelse(test_data$predicted_prob >= 0.5, 1, 0)
# confusion matrix
table(Predicted = test_data$predicted_class, Actual = test_data$admit)
# finally accuracy
mean(test_data$predicted_class == test_data$admit)


# Bonus - Dimensional Reduction (NMDS)

data_numeric <- data %>%
  select(gre, gpa, rank)

# NMDS using Bray-Curtis dissimilarity (common for mixed data)
nmds_result <- metaMDS(data_numeric, distance = "euclidean", k = 2, trymax = 100)

# Check stress (how good the fit is)
nmds_result$stress

# Extract NMDS scores (coordinates in 2D space)
nmds_points <- as.data.frame(nmds_result$points)
nmds_points$admit <- as.factor(data$admit)

ggplot(nmds_points, aes(x = MDS1, y = MDS2, color = admit)) +
  geom_point(size = 3, alpha = 0.7) +
  labs(title = "NMDS of Grad School Admissions",
       x = "NMDS Dimension 1", y = "NMDS Dimension 2",
       color = "Admission Status") +
  theme_minimal()
