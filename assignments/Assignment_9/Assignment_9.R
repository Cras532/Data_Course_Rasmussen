
data <- read.csv("./Data/GradSchool_Admissions.csv")



str(data)
summary(data)

library(ggplot2)
library(dplyr)
library(caret)
library(knitr)
library(tidyr)
library(circlize)


data <- na.omit(data)

summary(data)
names(data)
list.files("./Data")

ggplot(data, aes(x = gre, y = gpa, color = factor(admit))) +
  geom_point() +
  labs(title = "GRE vs GPA by Admission Status")



set.seed(123)
trainIndex <- createDataPartition(data$admit, p = 0.8, list = FALSE, times = 1)

trainData <- data[trainIndex, ]
testData <- data[-trainIndex, ]


model <- glm(admit ~ gre + gpa + rank, data = trainData, family = binomial)

summary(model)


predictions <- predict(model, testData, type = "response")
predicted_classes <- ifelse(predictions > 0.5, 1, 0)


confusionMatrix(factor(predicted_classes), factor(testData$admit))

#Add predicted probabilities to the test data
testData$predicted_prob <- predictions

#Plot the predicted probabilities
ggplot(testData, aes(x = predicted_prob)) +
  geom_histogram(binwidth = 0.05) +
  labs(title = "Predicted Admission Probabilities",
       x = "Predicted Probability",
       y = "Frequency") +
  theme_minimal()


# Set seed for reproducibility
set.seed(123)

# Split the data into training and testing sets
trainIndex <- createDataPartition(data$admit, p = 0.8, list = FALSE, times = 1)
trainData <- data[trainIndex, ]
testData <- data[-trainIndex, ]

# Build different models
model1 <- glm(admit ~ gre + gpa, data = trainData, family = binomial)
model2 <- glm(admit ~ gre + gpa + rank, data = trainData, family = binomial)
model3 <- glm(admit ~ gre + gpa + rank + gre:gpa, data = trainData, family = binomial)

# Get model summaries
summary(model1)
summary(model2)
summary(model3)

# Make predictions on the test data
predictions1 <- predict(model1, testData, type = "response")
predictions2 <- predict(model2, testData, type = "response")
predictions3 <- predict(model3, testData, type = "response")

# Calculate performance metrics
performance_metrics <- function(model, predictions, testData) {
  predicted_classes <- ifelse(predictions > 0.5, 1, 0)
  cm <- confusionMatrix(factor(predicted_classes), factor(testData$admit))
  aic <- AIC(model)
  bic <- BIC(model)
  r2 <- 1 - (model$deviance / model$null.deviance)
  rmse <- sqrt(mean((predicted_classes - testData$admit)^2))
  sigma <- sqrt(sum((predicted_classes - testData$admit)^2) / length(testData$admit))
  performance_score <- cm$overall['Accuracy'] * 100
  
  return(c(AIC = aic, BIC = bic, R2 = r2, RMSE = rmse, Sigma = sigma, Performance_Score = performance_score))
}

metrics1 <- performance_metrics(model1, predictions1, testData)
metrics2 <- performance_metrics(model2, predictions2, testData)
metrics3 <- performance_metrics(model3, predictions3, testData)

# Create a comparison table
comparison <- data.frame(
  Name = c("mod1", "mod2", "mod3"),
  Model = c("glm", "glm", "glm"),
  AIC = c(metrics1['AIC'], metrics2['AIC'], metrics3['AIC']),
  BIC = c(metrics1['BIC'], metrics2['BIC'], metrics3['BIC']),
  R2 = c(metrics1['R2'], metrics2['R2'], metrics3['R2']),
  RMSE = c(metrics1['RMSE'], metrics2['RMSE'], metrics3['RMSE']),
  Sigma = c(metrics1['Sigma'], metrics2['Sigma'], metrics3['Sigma']),
  Performance_Score = c(metrics1['Performance_Score'], metrics2['Performance_Score'], metrics3['Performance_Score'])
)

print(comparison)


comparison_long <- comparison %>%
  pivot_longer(cols = c(AIC, BIC, R2, RMSE, Sigma, Performance_Score),
               names_to = "Metric",
               values_to = "Value")


# Transform the comparison table to long format
comparison_long <- comparison %>%
  pivot_longer(cols = c(AIC, BIC, R2, RMSE, Sigma, Performance_Score),
               names_to = "Metric",
               values_to = "Value") %>%
  drop_na() %>%
  group_by(Metric) %>%
  mutate(Value = (Value - min(Value)) / (max(Value) - min(Value))) %>%
  ungroup() %>%
  mutate(Metric = factor(Metric, levels = unique(Metric)))

print(comparison_long)





        