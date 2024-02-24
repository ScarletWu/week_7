library(tidyverse)
library(broom)
library(testthat)
library(ggplot2)

set.seed(42)
# 20 buildings
n <- 20
data <- tibble(
  BuildingName = paste("Building", 1:n),
  year = sample(1950:2024, n, replace = TRUE),
  floor = sample(1:100, n, replace = TRUE))


p <- ggplot(data, aes(x = year, y = floor)) +
  geom_point() +  
  geom_smooth(method = "lm", se = FALSE, color = "blue") + 
  labs(title = "Number of Floors vs. Year of Construction",
       x = "Year of Construction",
       y = "Number of Floors") +
  theme_minimal()

print(p)