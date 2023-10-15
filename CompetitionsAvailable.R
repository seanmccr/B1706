# B1706 | Dissertation Database Assessment | 14.10.23

library(devtools)
library(tidyverse)
library(R.utils)
library(StatsBombR)
library(tibble)

# Use this Function to see what data sets are free to use
competitions()

# This loads in all the Free Competitions data available and assigns
# this to a tibble named 'Comp'
Comp <- competitions

# This creates a variable which filters the free data to a particular set, Mens EURO 2020
MEC_id <- Comp %>%
  filter(competition_gender=="male",
         season_name==2020,
         competition_international==TRUE)
print(MEC_id)

# Use this to list all the free matches within the Subset (Mens EURO 2020)
Matches <- (FreeMatches(MEC_id))

# Use this to load all the free match data into our Subset (Mens EURO 2020)
ECData <- free_allevents(Matches)

# Use this to clean the 'ECData' subframe, and changes the dataframe to a tibble
ECData <- as_tibble(allclean(ECData))


# Our dataframe contains lists; you cannot save lists as csv, so we will delete the list data columns (they are all location data, which we still have as individual x and y coordinates)
list_variables <- ECData %>%
  select_if(is.list)
list_variables <- c(names(list_variables))

# Code for our updated ECData Subset with all variables structured as lists removed
ECData <- subset(ECData, select = !names(ECData) %in% list_variables)

write.csv(ECData, "/Users/seanmccrone/Desktop/MASTERS DEGREE/Course Material/B1701/Week 3/R Studio Tutorial Work/ECData.csv", row.names=FALSE)

