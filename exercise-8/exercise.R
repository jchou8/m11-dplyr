# Exercise 8: Pulitzer Prizes

# Read in the data
pulitzer <- read.csv("data/pulitzer-circulation-data.csv", stringsAsFactors = FALSE)

# Install and load the needed libraries
# Be sure to comment out the install.packages function so it won't install it every time it runs
# Remeber you only need to install a package once
#install.packages(dplyr)
library(dplyr)

# View in the data set. Start to understand what the data columns contains
# Be sure to comment out the function so it won't view everytime you run the code.
#View(pulitzer)

# Use 'colnames' to print out the names of the columns
print(colnames(pulitzer))

# Use 'str' to print what types of values are contained in each column
# Did any value type surprise you? Why do you think they are that type?
print(str(pulitzer))
# Characters for daily circulation and percentage change were surprising and were probably a result of the , +, -, and % symbols in the .csv file

# Add a column in a dataframe called 'Pulitzer.Prize.Change` that contains the diffrence in changes
# in Pulitzer Prize Winners from 2004 to 2013 and Pultizer Prize Winners from 1990 to 2003.
pulitzer <- mutate(pulitzer, Pulitzer.Prize.Change = Pulitzer.Prize.Winners.and.Finalists..2004.2014 - Pulitzer.Prize.Winners.and.Finalists..1990.2003)

# What publication gained the most pulitzer prizes from 2004-2014?
# Be sure to use the pipe operator! 
most.prizes.2004.2014 <- pulitzer %>% filter(Pulitzer.Prize.Winners.and.Finalists..2004.2014 == max(Pulitzer.Prize.Winners.and.Finalists..2004.2014)) %>% 
                                      select(Newspaper) %>% 
                                      toString()

# Which publication with at least 5 Pulitzers won from 2004-2014 had the biggest decrease(negative) in Daily circulation numbers? 
# This publication should have Pulitzer prizes won a minimum of 5 Pulitzers, as well as the biggest decrease in circulation
#pulitzer <- pulitzer %>% mutate(Circulation.Change = as.numeric(gsub(",", "", Daily.Circulation..2013)) - as.numeric(gsub(",", "", Daily.Circulation..2004)))
pulitzer <- pulitzer %>% mutate(Circulation.Change = as.numeric(gsub("%|+", "", Change.in.Daily.Circulation..2004.2013)))
biggest.decrease <- pulitzer %>% filter(Pulitzer.Prize.Winners.and.Finalists..2004.2014 >= 5) %>% 
                                 filter(Circulation.Change == min(Circulation.Change)) %>%
                                 select(Newspaper) %>% 
                                 toString()

# Your turn! An important part about being a data scientist is asking questions. 
# Create a question and use dplyr to figure out the answer.  
## On average, how much did circulation decrease between 2004 and 2013?
circulation.average.decrease <- pulitzer %>% summarize(mean = mean(Circulation.Change), median = median(Circulation.Change))
