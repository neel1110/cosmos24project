library(tidyverse)
library(gtsummary)


stroke_data <- read.csv ("data/Stroke.csv")

stroke_data <- stroke_data%>%
  mutate(Outcome = as.numeric(case_when(Outcome == "n" ~ 0,
                                        Outcome == "y" ~ 1)))

logistic_model <- glm(Outcome ~ age + LKW + gender + RACE.score, family = binomial, data=stroke_data)
summary(logistic_model)

library(rsample)
set.seed(10) 

data_split <- initial_split(stroke_data, prop = 0.5)
train_data <- training (data_split) 
test_data <- testing (data_split)

logistic_model2 <-glm(Outcome ~ age + LKW + gender + RACE.score, data=train_data)
summary(logistic_model2)

library(pROC)
test_prob = predict(logistic_model2, newdata = test_data, type = "response")
test_roc = roc(test_data$Outcome ~ test_prob, plot = TRUE, print.auc = TRUE)


