library(readr)
library(dplyr)
library(tidyr)
library(shellpipes)

v <- (tsvRead(comment="#")
	%>% mutate(week20 = ifelse(Week>35, Week, Week+max(Week)))
	%>% mutate(variant = Cases*B117/sequences)
	%>% mutate(wildtype = Cases-variant)
)

l <- (v
	%>% select(week20, variant, wildtype)
	%>% pivot_longer(!week20, names_to="strain", values_to="cases")
	%>% mutate(
		obsWeek = week20 - min(week20)
		, strain = factor(strain, levels=c("wildtype", "variant"))
	)
)

saveVars(l)
