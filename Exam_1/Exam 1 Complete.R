install.packages("tidyverse")
library(tidyverse)
df <- read_csv(cleaned_covid_data)
getwd()
df <- read.csv("cleaned_covid_data.csv")
#2 Subset the data to show states that begin with "A"
A_states <- df %>% filter(grepl("^A", Province_State))
#3 Create a plot showing Deaths over time with a separate facet for each state
# Convert Last_Update to Date format
A_states <- A_states %>% mutate(Last_Update = as.Date(Last_Update, format = "%Y-%m-%d"))
# Create the plot
ggplot(A_states, aes(x = Last_Update, y = Deaths, group = Province_State)) +
  geom_point() +
  geom_smooth(method = "loess", se = FALSE) +
  facet_wrap(~ Province_State, scales = "free") +
  labs(title = "COVID-19 Deaths Over Time in States Starting with 'A'",
       x = "Date",
       y = "Number of Deaths") +
  theme_minimal()
#4 
state_max_fatality_rate <- df %>%
  group_by(Province_State) %>%
  summarize(Maximum_Fatality_Ratio = max(Case_Fatality_Ratio, na.rm = TRUE)) %>%
  arrange(desc(Maximum_Fatality_Ratio)) %>%
  view()
#5 **V.**
#**Use that new data frame from task IV to create another plot. 
Maximum_Fatality_Ratio
state_max_fatality_rate <- state_max_fatality_rate %>%
  mutate(Province_State = factor(Province_State, levels = Province_State))
ggplot(state_max_fatality_rate, aes(x = Province_State, y = Maximum_Fatality_Ratio)) +
  geom_bar(stat = "identity") +
  labs(title = "Maximum COVID-19 Case Fatality Ratio by State",
       x = "State",
       y = "Maximum Fatality Ratio") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


#6 **VI.** (BONUS 10 pts)
#**Using the FULL data set, plot cumulative deaths for the entire US over time**
  
install.packages("dplyr")
library(dplyr)

cumulative_deaths <- df %>%
  group_by(Last_Update) %>%
  summarize(Cumulative_Deaths = sum(Deaths, na.rm = TRUE))

install.packages("ggplot2")
library(ggplot2)
library(tidyverse)

df <- df %>% mutate(Last_Update = as.Date(Last_Update, format = "%Y-%m-%d"))

daily_deaths <- df %>%
  group_by(Last_Update) %>%
  summarize(Daily_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  arrange(Last_Update)

daily_deaths <- daily_deaths %>%
  mutate(Cumulative_Deaths = cumsum(Daily_Deaths))
  
ggplot(daily_deaths, aes(x = Last_Update, y = Cumulative_Deaths)) +
  geom_line() +
  labs(title = "Cumulative COVID-19 Deaths in the US Over Time",
       x = "Date",
       y = "Cumulative Deaths") +
  theme_minimal()



