dat <- read.csv("Data_Course_Rasmussen/Data/BioLog_Plate_Data.csv")
view(dat)
tidy_data <- dat %>%
  pivot_longer(cols = starts_with("Hr_"), 
               names_to = "Time", 
               values_to = "Absorbance") %>%
  mutate(Time = as.numeric(str_extract(Time, "\\d+")))

tidy_data <- tidy_data %>%
  mutate(SampleType = case_when(
    str_detect(Sample.ID, regex("Clear_Creek", ignore_case = TRUE)) ~ "Clear_Creek",
    str_detect(Sample.ID, regex("Soil_1", ignore_case = TRUE)) ~ "Soil_1",
    str_detect(Sample.ID, regex("Soil_2", ignore_case = TRUE)) ~ "Soil_2",
    str_detect(Sample.ID, regex("Waste_Water", ignore_case = TRUE)) ~ "Waste_Water",
    TRUE ~ "Other"
  ))

filtered_data <- tidy_data %>%
  filter(SampleType %in% c("Clear_Creek", "Soil_1", "Soil_2", "Waste_Water"))

mean_data <- filtered_data %>%
  group_by(Time, SampleType, Dilution) %>%
  summarize(MeanAbsorbance = mean(Absorbance, na.rm = TRUE))

plot <- ggplot(mean_data, aes(x = Time, y = MeanAbsorbance, color = SampleType)) +
  geom_line() +
  facet_grid(. ~ Dilution, scales = "free_y", labeller = labeller(Dilution = c(`0.001` = "0.001", `0.01` = "0.01", `0.1` = "0.1"))) +
  labs(title = "Mean Absorbance Values for Itaconic Acid",
       x = "Time (hours)",
       y = "Mean Absorbance",
       color = "Sample Type") +
  theme_minimal() +
  theme(
    axis.title.y = element_text(vjust = 1),
    axis.text.y = element_text(vjust = 1),
    axis.ticks.y = element_line(),
    axis.line.y = element_line(),
    strip.background = element_blank(),
    strip.text.x = element_text(size = 12, face = "bold"),
    panel.spacing = unit(0.5, "lines"),
    strip.placement = "outside"
  ) +
  scale_y_continuous(limits = c(0, 2.5)) +
  transition_reveal(Time)

anim_save("itaconic_acid_animation.gif", plot)

print(plot)
