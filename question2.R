library(tidyverse)
library(broom)
library(testthat)

set.seed(42)
# 20 buildings
n <- 20
data <- tibble(
  BuildingName = paste("Building", 1:n),
  year = sample(1950:2024, n, replace = TRUE),
  floor = sample(1:100, n, replace = TRUE))

# 1. Test the expected number of observations
test_that("Dataset has 20 observations", {
  expect_equal(nrow(data), 20)
})


# 2. Test if Year of Construction range

test_that("Year of Construction is within the expected range", {
  expect_true(all(data$year >= 1950 & data$year <= 2024))
})

# 3. Test if NumberOfFloors falls within the expected range

test_that("Number of floors is within the expected range", {
  expect_true(all(data$floor >= 1 & data$floor <= 100))
})

# 4. Test if the dataset has no missing values

test_that("Dataset has no missing values", {
  expect_true(sum(is.na(data)) == 0)
})

# 5. Test if BuildingName is unique for each building

test_that("Building names are unique", {
  expect_equal(length(unique(data$BuildingName)), nrow(data))
})

# 6. Test that the linear model fits without errors
model <- lm(floor ~ year, data = data)

test_that("Linear model fits without errors", {
  expect_silent(model <- lm(floor ~ year, data = data))
})

# 7. Test if the model's coefficients are not NA

test_that("Model coefficients are not NA", {
  expect_false(any(is.na(coef(model))))
})

# 8. Test if the model has an intercept and slope term

test_that("Model has intercept and slope", {
  expect_true(all(c("(Intercept)", "year") %in% names(coef(model))))
})

# 9. Test the prediction on known input

test_that("Predictions are generated correctly for known input", {
  known_year <- 2000
  known_prediction <- predict(model, newdata = data.frame(year = known_year))
  expect_type(known_prediction, "numeric")
})



# 10. Test if the R-squared value is a numeric value

test_that("R-squared value is numeric", {
  expect_type(summary(model)$r.squared, "numeric")
})