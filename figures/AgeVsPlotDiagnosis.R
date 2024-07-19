library(ggplot2)

stroke_data <- read.csv ("data/Stroke.csv")
head(stroke_data)

ggplot(data = stroke_data) +
  geom_boxplot(aes (x= age, y= Outcome), color = "darkred") +
  labs (x = "age", y = "Diagnosis") +
  theme_minimal()
