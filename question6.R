set.seed(42)

n_samples <- 1000

# Assuming there are 2 genders andw 3 races
gender <- sample(0:1, n_samples, replace = TRUE)
race <- sample(0:2, n_samples, replace = TRUE)


noise <- sample(0:1, n_samples, replace = TRUE)
vote_preference <- (gender + race + noise) %% 2

data <- data.frame(gender, race, vote_preference)


write.csv(data, "simulated_vote_preference.csv", row.names = FALSE)
