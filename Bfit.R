library(lme4)
library(shellpipes)
library(broom.mixed)

commandEnvironments()

summary(l)

gamm <- glmer(cases ~ 0 + strain*obsWeek + (1 | obsWeek)
	, data=l
	, family = Gamma(link = "log")
)

summary(gamm)

## poly rescales confusingly – in fact the result is nearly identical
## no evidence (or even trend ☺) for increasing difference
qgamm <- glmer(cases ~ 0 + strain*poly(obsWeek, 2) + (1 | obsWeek)
	, data=l
	, family = Gamma(link = "log")
)

summary(qgamm)

gammA <- augment(gamm)
names(gammA)
saveVars(gammA)
