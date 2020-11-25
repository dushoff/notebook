
library(readr)
library(dplyr)

source("makestuff/makeRfuns.R") ## Will eventually be a package

dat <- (tableRead(delim=";")
	%>% filter(age >= 18)
	%>% mutate(
		cwt = weight-mean(weight)
		, ww = cwt^2
	)
)

lin <- lm(height~cwt, data=dat)
quad <- lm(height~cwt+ww, data=dat)

summary(lin)
summary(quad)


mean(dat$height)

## makeGraphics()

## To save as .rda
## saveVars(y) ## OR
## saveEnviroment()
