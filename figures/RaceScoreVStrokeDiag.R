library(ggplot2)
library(tidyverse)
stroke_data <- read.csv("data/Stroke.csv")
head(stroke_data)


stroke_data <- mutate(stroke_data, RACE.score = as.factor(RACE.score))


ggplot(data = stroke_data,
       aes(x = RACE.score,
           fill = Outcome)) +
  geom_bar(position = "dodge")


