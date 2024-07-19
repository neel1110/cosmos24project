stroke_data <- read.csv("data/Stroke.csv")


pc_data <- as.data.frame(res$x[, 1:5])
colnames(pc_data) <- c("PC1", "PC2", "PC3", "PC4", "PC5")

stroke_data <- stroke_data %>% 
  mutate(Outcome = as.numeric(case_when(Outcome == "n" ~ 0,
                                        Outcome == "y" ~ 1)))

pc_data$x <- stroke_data$Outcome

logistic_model <- glm(x ~ PC1 + PC2 + PC3 + PC4 + PC5, family = binomial, data = pc_data)
summary(logistic_model)

library(rsample)
set.seed(10)

data_split <- initial_split(pc_data, prop = 0.5) 
train_data <- training(data_split)
test_data <- testing(data_split)

logistic_model2 <- glm(x ~ PC1 + PC2 + PC3 + PC4 + PC5, family = binomial, data = train_data)
summary(logistic_model2)

library(pROC)
test_prob = predict(logistic_model2, newdata = test_data, type = "response")
test_roc = roc(test_data$x ~ test_prob, plot = TRUE, print.auc = TRUE)

pred_prob <- logistic_model2 %>% 
  predict(test_data,type="response")
predicted.classes <- ifelse(pred_prob > 0.5, "1", "0")
mean(predicted.classes == test_data$x)
