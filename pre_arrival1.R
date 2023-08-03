#Lesson 1
2+2

mynumber <- 2+2

my_vector <- c(1, 2, 3)

my_string_vector <- c("this", "is", "a", "vector" )

mean (my_vector)

#this is a comment

#indexing vector
my_vector[2]

#load files
load ("file path")

#change default working directory
setwd("")

#search something within data
mydata$gender

#Quiz 1
#1. What arguments can you use for the mean function in R?
?mean 
#2. Extract the third element of the vector using numerical indexing.
random_vector <- c("R","is","great")
random_vector[3]
#3. Use R code to identify the data type of some_vector. What is the largest number in this vector? How about the mean value?
some_vector <- c(25555,342343,123123123,4234234,53243234,54324234,5421111,12312312,111231,1231231,12312312,12312312,123123,898972,789872,2343,23423423,2343221,23423,14444,44324222,2342341,124231111,22233345,1111233333,1231231,1231231)
class (some_vector)
mean (some_vector)
max (some_vector)
#4. How many rows and columns does the congress dataframe have? Use a function to show its data type. You must use R code to generate these values.
load(url('https://dssoc.github.io/datasets/congress.RData'))
view(congress)
ncol (congress)
nrow (congress)
summary (congress)
#5. What is the average age of all congress members? What is the data type of the birthyear column?
congress$age <- 2023 - congress$birthyear
mean (congress$age)
class(congress$birthyear)
#6. How much older is Sherrod Brown (a member of congress) compared to the average of members of congress? How about Dianne Feinstein?
mutate(congress, congress$age)
filter (congress, full_name == "Sherrod Brown")
filter (congress, full_name == "Dianne Feinstein")
#7. Who are the oldest members of congress?
max (congress$age)
filter (congress, age == 90)


# lesson 4 Data “Wrangling”
install.packages ("tidyverse")
no

#path of package
.libPaths()

library(tidyverse)
load(url('https://compsocialscience.github.io/summer-institute/assets/datasets/Apple_Mobility_Data.Rdata'))

view (apple_data)
Brazil_data <- filter (apple_data, region == "Brazil")
region<- select (apple_data, region)
view (region)

transport_types<-count(apple_data, transportation_type)
view (transport_types)

alpha_order<- arrange(apple_data, region)
view (alpha_order)

#backtick key == option + ~
long_apple_data<-gather(apple_data, key=day, value=mobility_data, `2020-01-13`:`2020-08-20`)
view (long_apple_data)
remove (long_apple_data)
