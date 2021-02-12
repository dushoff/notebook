library(lme4)
library(shellpipes)

commandEnvironments()

summary(l)

m <- glmer(cases ~ 0 + strain + strain*obsWeek + (1 | obsWeek)
	, data=l
	, family = Gamma(link = "log")
)

summary(m)
