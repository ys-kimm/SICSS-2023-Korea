#Quiz 3
#YSK
library(tidyverse)
load(url('https://dssoc.github.io/datasets/congress.RData'))
#1. Create a bar plot to show the average ages of democrat and republican congress members. Now do the same for M and F genders (this second part should include members of all parties).
congress$age <- 2023 - congress$birthyear
mutate(congress, congress$age)

age_average<- congress %>%
  filter(party==c("Democrat", "Republican")) %>%
    group_by(party) %>%
      summarise(age_average=mean(age, na.rm=TRUE))

ggplot(age_average, aes(party, weight=age_average))+
  geom_bar()+
  xlab("age and party of the senator")+
  theme_minimal()

age_average_2<- congress %>%
  group_by(gender) %>%
    summarise(age_average=mean(age, na.rm=TRUE))

ggplot(age_average_2, aes(gender, weight=age_average))+
  geom_bar()+
  xlab("age and gender of the senator")+
  theme_minimal()

#2. Create two bar charts: one that shows the total number of social media accounts among democrats and republicans (Twitter, Facebook, YouTube), and one that shows the average number of accounts per-politician for each party. Which political party has more social media accounts? Which party has a higher per-politician average?


