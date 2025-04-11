install.packages('modelr')
library(modelr)
install.packages('easystats')
library(easystats)
install.packages('broom')
library(broom)
install.packages("fitdistrplus")
library(fitdistrplus)
library(tidyverse)


#1) Load the data
data("/Data/mushroom_growth.csv")

#2) Plots

colnames(mushroom_growth)


ggplot(mushroom_growth, aes(x = Light, y = GrowthRate)) +
  geom_point() +
  labs(title = "Scatter Plot of Growth Rate vs Light",
       x = "Light",
       y = "Growth Rate")


ggplot(mushroom_growth, aes(x = factor(Temperature), y = GrowthRate)) +
  geom_boxplot() +
  labs(title = "Box Plot of Growth Rate by Temperature",
       x = "Temperature",
       y = "Growth Rate")


ggplot(mushroom_growth, aes(x = factor(Species))) +
  geom_bar() +
  labs(title = "Bar Plot of Species",
       x = "Species",
       y = "Count")


ggplot(mushroom_growth, aes(x = Light, y = GrowthRate, color = Temperature)) +
  geom_point() +
  theme_minimal() +
  labs(title = "Customized Scatter Plot",
       x = "Light",
       y = "Growth Rate")

#3)defines at least 4 models that explain the dependent variable “GrowthRate”

model1 <- lm(GrowthRate ~ Light, data = mushroom_growth)
summary(model1)

model2 <- lm(GrowthRate ~ Light + Temperature, data = mushroom_growth)
summary(model2)

model3 <- lm(GrowthRate ~ Light + Temperature + Humidity, data = mushroom_growth)
summary(model3)


model4 <- lm(GrowthRate ~ Light + Temperature + Humidity + Nitrogen, data = mushroom_growth)
summary(model4)


model5 <- lm(GrowthRate ~ Light + Temperature + Humidity + Nitrogen + Species, data = mushroom_growth)
summary(model5)


par(mfrow = c(2, 2))
plot(model1)
plot(model2)
plot(model3)
plot(model4)
plot(model5)

#4 calculates the mean sq. error of each model


pred1 <- predict(model1, mushroom_growth)
mse1 <- mean((mushroom_growth$GrowthRate - pred1)^2)
mse1


pred2 <- predict(model2, mushroom_growth)
mse2 <- mean((mushroom_growth$GrowthRate - pred2)^2)
mse2


pred3 <- predict(model3, mushroom_growth)
mse3 <- mean((mushroom_growth$GrowthRate - pred3)^2)
mse3


pred4 <- predict(model4, mushroom_growth)
mse4 <- mean((mushroom_growth$GrowthRate - pred4)^2)
mse4


pred5 <- predict(model5, mushroom_growth)
mse5 <- mean((mushroom_growth$GrowthRate - pred5)^2)
mse5



cat("MSE for Model 1 (Light):", mse1, "\n")
cat("MSE for Model 2 (Light + Temperature):", mse2, "\n")
cat("MSE for Model 3 (Light + Temperature + Humidity):", mse3, "\n")
cat("MSE for Model 4 (Light + Temperature + Humidity + Nitrogen):", mse4, "\n")
cat("MSE for Model 5 (All Predictors):", mse5, "\n")

#5 selects the best model you tried
#model 5 is the lowest, but I will use model 4 to avoid all predictions

#6 adds predictions based on new hypothetical values for the independent variables used in your model
str(mushroom_growth)


mushroom_growth$Humidity <- factor(mushroom_growth$Humidity)

model4 <- lm(GrowthRate ~ Light + Temperature + Humidity + Nitrogen, data = mushroom_growth)

levels(mushroom_growth$Humidity)



new_data <- data.frame(
  Light = c(0, 10, 20),
  Temperature = c(15, 25, 35),
  Humidity = factor(c("High", "High", "Low"), levels = levels(mushroom_growth$Humidity)),
  Nitrogen = c(5, 10, 15)
)


predictions <- predict(model4, new_data)

results <- cbind(new_data, Predicted_GrowthRate = predictions)
print(results)


#7 plots these predictions alongside the real data

mushroom_growth$Source <- "Real Data"
new_data$GrowthRate <- predictions
new_data$Source <- "Prediction"

new_data$Species <- "Placeholder"
new_data <- new_data[, colnames(mushroom_growth)]


combined_data <- rbind(
  mushroom_growth,
  new_data)


ggplot(combined_data, aes(x = Light, y = GrowthRate, color = Source)) +
  geom_point(data = subset(combined_data, Source == "Real Data"), size = 2) +
  geom_point(data = subset(combined_data, Source == "Prediction"), size = 4, shape = 17) +
  labs(title = "Growth Rate vs Light: Real Data and Predictions",
       x = "Light",
       y = "Growth Rate") +
  theme_minimal()





