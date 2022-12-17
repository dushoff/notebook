library(tidyr)
library(dplyr)
library(ggplot2); theme_set(theme_bw())

library(shellpipes)

maxSize=5
numSize=41
numthe=6

relSize = exp(seq(log(1/maxSize), log(maxSize), length.out=numSize))
the = seq(0, 1, length.out=numthe)

g <- expand_grid(NULL
	, relSize=relSize
	, the=the
)

g <- g %>% mutate(NULL
	, lamPow = relSize/(relSize^the)
	, lamSat = relSize/(relSize*the + 1-the)
)

print(ggplot(g)
	+ aes(relSize, lamPow, color=as.factor(the))
	+ geom_line()
	+ scale_x_log10()
)

print(ggplot(g)
	+ aes(relSize, lamSat, color=as.factor(the))
	+ geom_line()
	+ scale_x_log10()
)
