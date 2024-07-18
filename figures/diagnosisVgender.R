stroke_data <- read.csv("data/Stroke.csv")
head(stroke_data)

install.packages("ggplot2")
library(ggplot2)

ggplot(data = stroke_data) +
  geom_point(aes(x = gender, y = diagnosis), color = "darkgreen") +
  labs(x = "gender", y = "diagnosis") +
  theme_minimal()

