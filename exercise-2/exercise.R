# Exercise 2: Data Frame Practice with `dplyr`.
# Use a different appraoch to accomplish the same tasks as exercise-1

# Install devtools package: allows installations from GitHub
install.packages('devtools')

# Install "fueleconomy" package from GitHub
devtools::install_github("hadley/fueleconomy")

# Require/library the fueleconomy package
require('fueleconomy')

# Install (if you haven't already) and load the `dplyr`package
install.packages('dplyr')
require('dplyr')

# You should have have access to the `vehicles` data.frame
View(vehicles)

# Create a data.frame of vehicles from 1997
vehicles.1997 <- filter(vehicles, year == 1997)

# Use the `unique` function to verify that there is only 1 value in the `year` column of your new data.frame
only.one.year <- length(unique(vehicles.1997$year)) == 1

# Create a data.frame of 2-Wheel Drive vehicles that get more than 20 miles/gallon in the city
vehicles.2wd <- filter(vehicles, drive == '2-Wheel Drive' & cty > 20)

# Of those vehicles, what is the vehicle ID of the vehicle with the worst hwy mpg?
worst.hwy <- arrange(vehicles.2wd, hwy)$id[1]

# Write a function that takes a `year` and a `make` as parameters, and returns 
# The vehicle that gets the most hwy miles/gallon of vehicles of that make in that year
MostHwyMPG <- function(my.year, my.make) {
  return (arrange(filter(vehicles, year == my.year & make == my.make), desc(hwy))$model[1])
}

# What was the most efficient honda model of 1995?
efficient.1995.honda <- MostHwyMPG(1995, 'Honda')
