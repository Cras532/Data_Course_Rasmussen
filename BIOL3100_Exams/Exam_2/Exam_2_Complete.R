
# 1) Read in the unicef data (10 pts) 2. Get it into tidy format (10 pts) 3. Plot each country’s U5MR over time (20 points)
data <- read.csv("Data_Course_Rasmussen/BIOL3100_Exams/Exam_2/unicef-u5mr.csv")

install.packages("skimr")
library(skimr)

skim(data)

#2)  clean it up
data_tidy <- data %>%
  pivot_longer(cols = starts_with("U5MR"), names_to = "Year", values_to = "U5MR") %>%
  mutate(Year = as.numeric(str_replace(Year, "U5MR.", ""))) %>%
  filter(!is.na(U5MR))  # Filter out rows with missing U5MR values


#3) Plot each country's U5MR over time
ggplot(data_tidy, aes(x = Year, y = U5MR, group = CountryName)) +
  geom_line(color = "black") +
  facet_wrap(~ Continent, scales = "free_y") +
  theme_minimal() +
  scale_y_continuous(breaks = seq(0, 400, 100)) +
  scale_x_continuous(breaks = c(1960, 1980, 2000)) +
  labs(title = "Under-5 Mortality Rate Over Time by Continent",
       x = "Year",
       y = "U5MR (deaths per 1000 live births)")

#4) Save the plot as LASTNAME_Plot_1.png
ggsave("RASMUSSEN_Plot_1.png")

#5) Create another plot that shows the mean U5MR for all the countries within a given continent at each year (20 pts)

# get the mean
mean_u5mr <- data_tidy %>%
  group_by(Continent, Year) %>%
  summarize(mean_U5MR = mean(U5MR, na.rm = TRUE))

# plot the mean
ggplot(mean_u5mr, aes(x = Year, y = mean_U5MR, color = Continent)) +
  geom_line(size = 1.5) + #adjusted the lines to be a bit more bold to match exam
  theme_minimal() +
  scale_y_continuous(breaks = seq(0, 400, 100)) +
  scale_x_continuous(breaks = c(1960, 1980, 2000)) +
  labs(title = "Mean Under-5 Mortality Rate Over Time by Continent",
       x = "Year",
       y = "Mean U5MR (deaths per 1000 live births)",
       color = "Continent")

# 6) Save that plot as LASTNAME_Plot_2.png (5 pts) 
ggsave("RASMUSSEN_Plot_2.png")


# 7) Create three models of U5MR (20 pts)
# mod1: Account for only Year
mod1 <- lm(U5MR ~ Year, data = data_tidy)

# mod2: Account for Year and Continent
mod2 <- lm(U5MR ~ Year + Continent, data = data_tidy)

# mod3: Account for Year, Continent, and their interaction term
mod3 <- lm(U5MR ~ Year * Continent, data = data_tidy)

# Print the summary
summary(mod1)
summary(mod2)
summary(mod3)


# 8) Compare the three models with respect to their performance

# Compare the three mods
comparison <- tibble(
  Model = c("mod1", "mod2", "mod3"),
  AIC = c(AIC(mod1), AIC(mod2), AIC(mod3)),
  BIC = c(BIC(mod1), BIC(mod2), BIC(mod3)),
  R_squared = c(summary(mod1)$r.squared, summary(mod2)$r.squared, summary(mod3)$r.squared),
  Adjusted_R_squared = c(summary(mod1)$adj.r.squared, summary(mod2)$adj.r.squared, summary(mod3)$adj.r.squared)
)
print(comparison)

# based on the models I created, lowest AIC and BIC values and the highest R-squared and adjusted R-squared values would be the best
# mod3 is the best model!

# 9) Plot the 3 models’ predictions like so: (10 pts)
# new data fram for predictions
predictions <- data_tidy %>%
  select(Year, Continent) %>%
  distinct() %>%
  arrange(Continent, Year)

# Add predictions from each mod
predictions <- predictions %>%
  mutate(mod1 = predict(mod1, newdata = predictions),
         mod2 = predict(mod2, newdata = predictions),
         mod3 = predict(mod3, newdata = predictions))

# Plot my predictions
plot1 <- ggplot(predictions, aes(x = Year, y = mod1, color = Continent)) +
  geom_line(size = 1.5) +
  theme_minimal() +
  theme(legend.position = "none") +  # Remove legend
  labs(title = "Model 1",
       x = NULL,
       y = NULL,
       color = NULL) +
  scale_y_continuous(limits = c(0, 300))

plot2 <- ggplot(predictions, aes(x = Year, y = mod2, color = Continent)) +
  geom_line(size = 1.5) +
  theme_minimal() +
  theme(legend.position = "none") +  # Remove legend
  labs(title = "Model 2",
       x = NULL,
       y = NULL,
       color = NULL) +
  scale_y_continuous(limits = c(0, 300))

plot3 <- ggplot(predictions, aes(x = Year, y = mod3, color = Continent)) +
  geom_line(size = 1.5) +
  theme_minimal() +
  labs(title = "Model 3",
       x = NULL,
       y = NULL,
       color = "Continent") +
  scale_y_continuous(limits = c(0, 300))

# new package to arrange my plots
install.packages("gridExtra")
library(gridExtra)

grid.arrange(plot1, plot2, plot3, ncol = 3, left = "Predicted U5MR", bottom = "Year")

# save image
ggsave("RASMUSSEN_Plot_3.png")

# 10) my attempt at: Using your preferred model, predict what the U5MR would be for Ecuador 
# in the year 2020. The real value for Ecuador for 2020 was 13 under-5 deaths per 1000 live
# births. How far off was your model prediction???

data_tidy <- data %>%
  pivot_longer(cols = starts_with("U5MR"), names_to = "Year", values_to = "U5MR") %>%
  mutate(Year = as.numeric(str_replace(Year, "U5MR.", ""))) %>%
  filter(!is.na(U5MR))  # Filter out rows with missing U5MR values

# Filter the data for Ecuador
ecuador_data <- data_tidy %>% filter(CountryName == "Ecuador")


# Log-transform the U5MR values - because they were inverse
ecuador_data <- ecuador_data %>%
  mutate(log_U5MR = log(U5MR))


# Fit a linear model using log-transformed U5MR values
model <- lm(log_U5MR ~ Year, data = ecuador_data)


# Predict U5MR for Ecuador in the year 2020
year_2020 <- data.frame(Year = 2020)
predicted_log_u5mr_2020 <- predict(model, newdata = year_2020)


# Transform back to original format
predicted_u5mr_2020 <- exp(predicted_log_u5mr_2020)

# Print 
predicted_u5mr_2020

#16.61356 was my answer!




