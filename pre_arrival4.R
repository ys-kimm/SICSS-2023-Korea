#SICSS boot camp
#Data Visualization
#YSK


my_object <- 2
covid_tweets$date

library(tidyverse)
en_tweets <- filter(covid_tweets, language=="en")
ling_tweets <- select(covid_tweets, language)
count(covid_tweets, language=="en")
twitter_handle <- count(covid_tweets, twitter_handle)
alpha_tweets <- arrange(ling_tweets, language)

rm(list=ls())
library(tidyverse)
apple_data<-read_csv("https://sicss.io/assets/datasets/apple_mobility_data.csv") 
long_data<-gather(apple_data, key=day, value=mobility_data, `2020-01-13`:`2020-08-20`)

country_average<- long_data %>%
                  filter(transportation_type=="walking") %>%
                    group_by(country) %>%
                      summarise(walking_average=mean(mobility_data, na.rm=TRUE)) %>%
                        filter(!is.na(country))                        
## NA value controlling

ggplot(country_average, aes(y=reorder(country, walking_average), weight=walking_average)) +
  geom_bar(fill="blue")+
    xlab("Relative Rate of Walking Direction Requests")+
      theme_minimal()

long_data$day
library(lubridate)
long_data$day <- as_date(long_data$day)

italy_data<- long_data %>%
  filter(country=="Italy", transportation_type=="walking") %>%
    group_by(country, day) %>%
      summarise(walking_average=mean(mobility_data, na.rm = TRUE))

ggplot(italy_data, aes(x=day, y=walking_average)) + 
  geom_line()+
     theme_bw()+
        ylab("Relative Volume of Walking Direction Requests")
