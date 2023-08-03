#SICSS boot camp
#Programming Basics
#YSK

senators_data$twitter_url[1]
library(rtweet)
test<-get_timeline("https://twitter.com/SenDanSullivan")
?get_timeline()

#Quiz
#1. In your own words, describe what a function is and provide one example of how you might use it in a data science.
#A. Fuction is for making small bundle of program. It is especially useful when you need to iterate tasks with computer. 

#2. Packages in R can contain many useful functions/commands. If you didn’t know what a certain function did, or how it worked, where within RStudio would you look to learn more / see example code? Where would you look outside RStudio?
#A. ?function(), stackoverflow..

#3. 3. Write a function that takes a character vector as an argument and returns a character vector containing the first letters of each element in the original vector. To show that it works, test it on the character vector sentence defined below.
#sentence <- c('you', 'only', 'understand', 'data', 'if', 'data', 'is', 'tidy')
# A.
get_first_letters <- function(original_vector) {
  return(substring(original_vector, 1, 1))
}
sentence <- c('you', 'only', 'understand', 'data', 'if', 'data', 'is', 'tidy')
get_first_letters(sentence)

#4. Create your own function which accepts a birthyear vector and returns an approximate current age, then use it on the birthyear column of the congress dataframe to create a new age column with mutate.
load(url('https://dssoc.github.io/datasets/congress.RData'))
calculate_age <- function(x) {
  current_year <- 2023
  age <- current_year - x
  return(age)
}
library(tidyverse)

congress <- congress %>%
  mutate(age = calculate_age(birthyear))

#5. Write a function that accepts a date string and returns the day of the week it corresponds to, then use it to create a new column of congress representing the weekday of the birth of each politician using mutate.
library(lubridate)

get_weekday <- function(date_string) {
  date <- as.Date(date_string, format = "%Y-%m-%d")
  return(weekdays(date))
}
  
congress <- congress %>%
  mutate(weekday_birth = get_weekday(birthdate))

#6. Write a function that accepts a dataframe with the columns birthday and full_name, and prints the names and ages of the k oldest representatives in congress (i.e. not including senators) using a “for loop”. In this sense, k is an arbitrary number that should be given as an argument to the function - set the default value to be 5. If you use the dataframe as the first argument, you can use the pipe operator (“%>%”) to pass the dataframe directly to the function. Define your function such that you can use it like this: congress %>% print_oldest(3).
# Install and load the lubridate package if you haven't already
# install.packages("lubridate")

library(lubridate)

print_oldest <- function(df, k = 5) {
  df_representatives <- df %>%
    filter(!grepl("Senator", full_name, ignore.case = TRUE))
  
  # Sort by age in descending order
  df_representatives <- df_representatives[order(-df_representatives$age), ]
  
  # Print the names and ages of the k oldest representatives
  for (i in 1:k) {
    cat("Name:", df_representatives$full_name[i], "- Age:", df_representatives$age[i], "\n")
  }
}

