library(tidyverse)
library(ggfortify)


stroke_data <- read.csv("data/Stroke.csv")

res=stroke_data %>% 
  select(-ID, -gender, -age, -RACE.score, -LKW, -Outcome) %>%
  prcomp()
summary(res)

autoplot(res, data = stroke_data, color = "Outcome")


res$rotation
