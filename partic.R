library(tidyverse)
library(emmeans)

set.seed(0705)

N <- 1e4
numVacc <- N/2
base_hazard <- 0.5
efficacy <- 0.6

id = as.character(1:N)
vaccinees <- sample(id, numVacc)

pbase <- exp(-base_hazard)
print(pbase)
pvacc <- pbase*(1-efficacy)

pop <- tibble(NULL 
	, id=id
	, vacc = id %in% vaccinees
	, prob = ifelse(vacc, pvacc, pbase)
	, infection = rbinom(N, 1, prob)
)

dat <- (pop
	%>% select(-prob)
)

mod <- glm(infection ~ vacc, data=dat, family=binomial(link=cloglog))
summary(mod)
confint(mod)

emod <- emmeans(mod, specs="vacc")
summary(emod, type="response")

