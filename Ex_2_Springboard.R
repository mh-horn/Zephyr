### Data Wrangling Exercise 2

## 0: Load the data in RStudio
titanic <- read.csv("titanic_original.csv", stringsAsFactors = FALSE)

## 1: Port of Embarcation
# Replace blank values in embarked with "S"

titanic$embarked[titanic$embarked==""] <- "S"

## 2: Age
# Replace missing values in Age with mean of age column

m_age <- mean(titanic$age, na.rm = TRUE)
titanic$age[is.na(titanic$age)] <- m_age

# Other options to handle age...
# - max or min: will skew data
# - 0: will skew data (also unrealistic, as would misrepresent, as no one has age = 0)
# - NA / null: unrealistic, as would misrepresent
# - remove data totally: passangers with blank age make up ~20% of total passengers; this is a lot of people to exclude

## 3: Lifeboat
# Fill blanks in "lifeboat" with dummy value ("None")

titanic$boat[titanic$boat==""] <- "None"

## 4: Cabin
# Hypothesis: if the cabin number is missing, passenger was likely in lower class, 
# Lower class passengers would have lower probability of survival

titanic$has_cabin_number <- 0
titanic$has_cabin_number[titanic$cabin == ""] <- 1

# 6: Submit the project
write.csv(titanic, "C:/Users/Horn Molly/Documents/GitHub/Zephyr/titanic_clean.csv")