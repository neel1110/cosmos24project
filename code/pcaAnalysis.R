library(tidyverse)
library(ggfortify)

stroke_data <- read.csv("data/Stroke.csv")

res=stroke_data %>% 
  select(-ID, -gender, -age, -RACE.score, -LKW, -Outcome) %>%
  prcomp(scale. = TRUE, center = TRUE)
summary(res)

#autoplot(res, data = stroke_data, color = "Outcome")

eigenvalues <- res$sdev^2

plot(eigenvalues, type = "b",
     xlab = "Principal Component",
     ylab = "Eigenvalue",
     xlim = c(1, 20))

res$x
