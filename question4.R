library(tidyverse)
library(ggplot2)
library(rstanarm)

set.seed(42)

# 20 buildings

n <- 20
data <- tibble(
  BuildingName = paste("Building", 1:n),
  year = sample(1950:2024, n, replace = TRUE),
  floor = sample(1:100, n, replace = TRUE))
print(data)

plot1 <- ggplot(data, aes(x = year, y = floor)) +
  geom_point() +  
  geom_smooth(method = "lm", se = FALSE, color = "blue") + 
  labs(title = "Number of Floors vs. Year of Construction",
       x = "Year of Construction",
       y = "Number of Floors") +
  theme_minimal()

print(plot1)


model <- stan_glm(floor ~ year, data = data, family = gaussian(), chains = 4, iter = 2000)

print(summary(model))

ggsave("Cloud/project/plot.png", plot1)