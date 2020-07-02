
library(caret)
## True betas
b0 <- 0.1
b1 <- 0.5

## Binary x
x <- ifelse(runif(100)>0.5, 1, 0)

## Outcome
y <- b0 + b1*x + rnorm(100)

df <- data.frame(y = y, x = as.factor(x))

## lm
summary(lm(y ~ x, data = df))

## Using model matrix
mod_mat <- model.matrix(~x, data = df)[,-1, drop = FALSE]
summary(lm(y ~ mod_mat))

## Using dummy variables
dummy <- dummyVars(y ~ x, sep = "_", data = df)
dummy_mat <- predict(dummy, df)
head(dummy_mat)

summary(lm(y ~ dummy_mat))

