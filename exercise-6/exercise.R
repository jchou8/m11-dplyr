# Exercise 6: DPLYR join introduction

# Install the nycflights13 package and read it in. Require the dplyr package.
# install.packages("nycflights13")
library(nycflights13)
library(dplyr)


# Create a dataframe of the average arrival delay for each destination, then use left_join
# to join on the "airports" dataframe, which has the airport info
airport.delays <- flights %>% mutate(faa = dest) %>% 
                              group_by(faa) %>% 
                              summarize(avg.arr.delay = mean(arr_delay, na.rm = TRUE)) %>% 
                              left_join(airports, by = 'faa') %>% 
                              arrange(desc(avg.arr.delay))

# Create a dataframe of the average arrival delay for each airline, then use left_join
# to join on the "airlines" dataframe, which has the airline info
airline.delays <- flights %>% group_by(carrier) %>% 
                              summarize(avg.arr.delay = mean(arr_delay, na.rm = TRUE)) %>% 
                              left_join(airlines, by = 'carrier') %>% 
                              arrange(desc(avg.arr.delay))


### Bonus ###
# Calculate the average delay by city AND airline, then merge on the city and airline information
city.airline.delays <- flights %>% mutate(faa = dest) %>% 
                                   group_by(faa, carrier) %>% 
                                   summarize(avg.arr.delay = mean(arr_delay, na.rm = TRUE)) %>% 
                                   left_join(airlines, by = 'carrier') %>% 
                                   left_join(airports, by = 'faa') %>% 
                                   arrange(desc(avg.arr.delay))
                                   

# If you're running into sorting issues:
# http://stackoverflow.com/questions/26555297/dplyr-arrange-a-grouped-df-by-group-variable-not-working