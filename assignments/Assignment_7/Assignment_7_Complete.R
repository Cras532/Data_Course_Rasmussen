
Utah_Religions_by_County <- read.csv(Data_Course_Rasmussen/assignments/Assignment_7/Utah_Religions_by_County.csv)


dat <- Utah_Religions_by_County

colnames(dat)

#tidy up my data for the applicable information that follows
dat <- dat %>%
  rename(
    county = County,
    population = Pop_2010,
    non_religious = `Non-Religious`) %>%
  pivot_longer(cols = c("Assemblies of God", "Episcopal Church", "Pentecostal Church of God", "Greek Orthodox", 
             "LDS", "Southern Baptist Convention", "United Methodist Church", "Buddhism-Mahayana", 
             "Catholic", "Evangelical", "Muslim", "Non Denominational", "Orthodox"),
    names_to = "religion",
    values_to = "adherents") %>%
  mutate(proportion_religious = adherents / population,
    proportion_non_religious = non_religious / population)

str(dat)

# Plot population vs. proportion of religious adherents
ggplot(dat, aes(x = population, y = proportion_religious, color = religion)) +
  geom_point() +
  labs(title = "Population vs. Proportion of Religious Adherents by County",
       x = "Population",
       y = "Proportion of Religious Adherents")

# Plot proportion of specific religion vs. proportion of non-religious people
ggplot(dat, aes(x = proportion_religious, y = proportion_non_religious, color = religion)) +
  geom_point() +
  labs(title = "Proportion of Specific Religion vs. Proportion of Non-Religious People by County",
       x = "Proportion of Religious Adherents",
       y = "Proportion of Non-Religious People")

# Correlation between population and proportion of religious adherents
correlation_population_religious <- dat %>%
  group_by(religion) %>%
  summarize(correlation = cor(population, proportion_religious, use = "complete.obs"))

# Correlation between proportion of specific religion and proportion of non-religious people
correlation_religious_non_religious <- dat %>%
  group_by(religion) %>%
  summarize(correlation = cor(proportion_religious, proportion_non_religious, use = "complete.obs"))

# combining the 2 against each other for fun
comparison <- correlation_population_religious %>%
  rename(correlation_population = correlation) %>%
  inner_join(correlation_religious_non_religious %>%
               rename(correlation_non_religious = correlation), by = "religion")

# Visual of the comparison
ggplot(comparison, aes(x = correlation_population, y = correlation_non_religious, label = religion)) +
  geom_point() +
  geom_text(vjust = -0.5, hjust = 0.5) +
  labs(title = "Comparison of Correlation Indices",
       x = "Correlation with Population",
       y = "Correlation with Non-Religious Proportion")
