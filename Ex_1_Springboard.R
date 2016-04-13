
setwd("C:/Users/Horn Molly/Desktop/Springboard")
library(dplyr)
library(tidyr)

refine <- read.csv('refine.csv')

## Create lower case
refine$company <- tolower(refine$company)


## Standardize spellings
for (c in 1:length(refine$company)){
  if (substring(refine$company[c], 1, 1) == "p"){
    refine$company[c] <- "philips"
  } else if (substring(refine$company[c], 1, 1) == "f") {
    refine$company[c] <- "philips"
  } else if (substring(refine$company[c], 1, 1) == "a") {
    refine$company[c] <- "akzo"
  } else if (substring(refine$company[c], 1, 1) == "u") {
    refine$company[c] <- "unilever"
  }
}


## Create product_code and product_number columns
refine_sep <- separate(data = refine, col = Product.code...number, into = c("product_code", "product_number"), sep = "-")


## Create product_category column
refine_sep$product_cat <- 0
for (c in 1:length(refine_sep$product_cat)){
  if (substring(refine_sep$product_code[c], 1, 1) == "p"){
    refine_sep$product_cat[c] <- "Smartphone"
  } else if (substring(refine_sep$product_code[c], 1, 1) == "v") {
    refine_sep$product_cat[c] <- "TV"
  } else if (substring(refine_sep$product_code[c], 1, 1) == "x") {
    refine_sep$product_cat[c] <- "Laptop"
  } else if (substring(refine_sep$product_code[c], 1, 1) == "q") {
    refine_sep$product_cat[c] <- "Tablet"
  }
}


## Concatenate into geocoding
refine_sep$full_address <- 0
refine_sep$full_address <- paste(refine_sep$address, refine_sep$city, refine_sep$country, sep = ", ")


## Add binary columns for company
refine_sep$company_philips <- 0
refine_sep$company_azko <- 0
refine_sep$company_van_houten <- 0
refine_sep$company_unilever <- 0

for (c in 1:length(refine_sep$product_cat)){
  if (refine_sep$company[c] == "philips"){
    refine_sep$company_philips[c] <- 1
  } else if (refine_sep$company[c] == "akzo"){
    refine_sep$company_azko[c] <- 1
  } else if (refine_sep$company[c] == "van houten"){
    refine_sep$company_van_houten[c] <- 1
  } else if (refine_sep$company[c] == "unilever"){
    refine_sep$company_unilever[c] <- 1
  }
}


## Add binary columns for each product type
refine_sep$product_smartphone <- 0
refine_sep$product_tv <- 0
refine_sep$product_laptop <- 0
refine_sep$product_tablet <- 0

for (c in 1:length(refine_sep$product_cat)){
  if (refine_sep$product_cat[c] == "Smartphone"){
    refine_sep$product_smartphone[c] <- 1
  } else if (refine_sep$product_cat[c] == "TV"){
    refine_sep$product_tv[c] <- 1
  } else if (refine_sep$product_cat[c] == "Laptop"){
    refine_sep$product_laptop[c] <- 1
  } else if (refine_sep$product_cat[c] == "Tablet"){
    refine_sep$product_tablet[c] <- 1
  }
}

write.csv(refine_sep, file = "refine_clean.csv")