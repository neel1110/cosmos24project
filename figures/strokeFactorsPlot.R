library(ggplot2)
library(tidyverse)
library(ggthemes)
library(corrplot)

stroke_data <- read.csv("data/Stroke.csv")

stroke_data <- mutate(stroke_data, gender = as.factor(gender),
                 RACE.score = as.integer(RACE.score))

stroke_data <- stroke_data %>% 
  mutate(gender = case_when(gender == 1 ~ "Male",
                            gender == 0 ~ "Female")) 

stroke_data <- stroke_data %>% 
  mutate(Outcome = as.numeric(case_when(Outcome == "n" ~ -1,
                                        Outcome == "y" ~ 1)))



ggplot(stroke_data, aes(x = age,
                   y = RACE.score,
                   shape = Outcome,
                   color = Outcome,
                   size = 1)) +
  geom_point() +
  facet_grid(.~gender) +
  scale_size(range = c(1, 5)) +
  labs(x = "Age (years)", 
       y = "RACE Score",
       title = "Stroke Factors") +
  scale_y_continuous(breaks=seq(0,10,by=1))



stroke_data_cor <- stroke_data %>% 
  select(-ID, -gender, -age) %>%
  cor()

stroke_correlations <- stroke_data_cor["Outcome", ] %>% 
  sort(decreasing = TRUE) %>% 
  head(50)

stroke_correlations

corrplot(stroke_data_cor, method ="color")
