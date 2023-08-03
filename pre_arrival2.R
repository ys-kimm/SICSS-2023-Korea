#Quiz 2 
#YSK
#1. Describe what the following tidyverse functions do. Also describe the pipe operator “%>%”. You may need to look up the official documentation for each of these.
install.packages ("nycflights13")
library (tidyverse)
library(nycflights13)
#1) Pick observations by their values (filter()).
#2) Pick variables by their names (select()).
#3) Create new variables with functions of existing variables (mutate()).
#4) count() lets you quickly count the unique values of one or more variables
#5) Reorder the rows (arrange()).
#6) A gather() function is used for collecting (gather) multiple columns and converting them into a key-value pair.
#7) Pipes are a powerful tool for clearly expressing a sequence of multiple operations. The point of the pipe is to help you write code in a way that is easier to read and understand. 

#2.Create a new dataframe that includes only senators and the columns gender, birthyear, and party. Then use that new dataframe to compute the number of male and female democrats and republicans (the output should be five rows corresponding to female democrats, male democrats, male independents, female republicans, and male republicans).
load(url('https://dssoc.github.io/datasets/congress.RData'))
new_congress <- select(congress, full_name, gender, birthyear, party)
count (new_congress, party, gender)
new_congress %>% count(party, gender)
#3. Identify the oldest and youngest male and female democrat senators using tidyverse functions.
age_congress <- arrange (congress, party, gender, age)
#4. Using mutate, create a new variable called age which represents the approximate age of each member of congress. How many democratic senators are over 60 years old?
congress$age <- 2023 - congress$birthyear
mutate(congress, congress$age)
count (congress, party=="Democrat" & age>60)
#5. Create a new column that indicates whether or not the member of congress is more than 55 years old, and create a single dataframe showing the number of male and female members of congress that are over and under 55.
morethan55 <- ifelse (congress$age > 55, "Yes", "No")
newcongress <- mutate(congress, morethan55)
#6. Using gather, create a new dataframe where each row corresponds to a valid twitter, facebook, or youtube social media account, then compute the total number of accounts for each political party. Then do the same with pivot_longer.
load(url('https://compsocialscience.github.io/summer-institute/assets/datasets/Senators_Data.Rdata'))

#Below, I define for you two vectors corresponding to policies that US States have adopted to respond to COVID-19: restrictions on travel (recorded May 20, 2020) and requirements that citizens to wear masks in public (recorded August 17, 2020).

travel_restrictions <- c("WA", "OR", "NV", "CA", "NM", "MN", "IL", "OH", "MI", "PA", "VA", "NY", "MA", "VH", "ME", "DE", "MD", "NJ")

require_masks <- c("HI", "WA", "OR", "NV", "CA", "MT", "CO", "NM", "KS", "TX", "MN", "AR", "LA", "WI", "IL", "AL", "MI", "IN", "OH", "KY", "WV", "NC", "VA", "DC", "DE", "PA", "NY", "VT", "NH", "MA", "RI", "CT", "ME")
#7. write code to print only the states who implemented both travel restrictions and mask requirements:
Reduce(intersect,list(travel_restrictions, require_masks))
#8. Write code to print the states who had implemented mask requirements but not travel restrictions:
require_masks[is.na(pmatch(travel_restrictions, require_masks))]

rm(list = ls())

#Lesson: Data Visualization
load(url('https://compsocialscience.github.io/summer-institute/assets/datasets/Apple_Mobility_Data.Rdata'))
library (tidyverse)
long_apple_data<-gather(apple_data, key=day, value=mobility_data, `2020-01-13`:`2020-08-20`)
country_average<- long_apple_data %>%
                    filter(transportation_type == "walking") %>%
                      group_by(country) %>%
                        summarise(walking_average=mean(mobility_data, na.rm=TRUE))
                          filter(!is.na(country))

ggplot(country_average, aes(y=country, weight=walking_average)) +
  geom_bar(fill="blue") +
    xlab("Relative Rate of Walking Direction Request")+
      theme_minimal()

long_apple_data$day
library(lubridate)
long_apple_data$day <- as_date(long_apple_data$day)

long_apple_data %>%
  filter(country=="Italy", transportation_type=="walking")

italy_spain_data<-long_apple_data %>%
  filter(country==c("Italy", "Spain"), transportation_type=="walking") %>%
    group_by(country, day) %>%
      summarise(walking_average=mean(mobility_data, na.rm=TRUE))
    
ggplot(italy_spain_data, aes(x=day, y=walking_average, group=country)) +
  geom_line()+
    facet_wrap(~country)+
      theme_bw()

#Lesson: Progamming
load(url('https://compsocialscience.github.io/summer-institute/assets/datasets/Senators_Data.Rdata'))

install.packages('rtweet')
no
library(rtweet)  

twitter_url_remover <-function(x){
  handle<-gsub("http://twitter.com/", "", x) 
  return(handle)
}

twitter_holder <-as.data.frame(NULL)

for(i in 1:5){
  handle<-twitter_url_remover(senators_data$twitter_url[i])
  tweets<-get_timeline(handle)
  twitter_holder<-rbind(twitter_holder, tweets)
}
