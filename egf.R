library(epigrowthfit)
library(dplyr)



ts <- read.table(header=TRUE, text = "\
t cases country
1 9 Canada
2 11 Canada
3 17 Canada
4 21 Canada
5 28 Canada
1 6 USA
2 8 USA
3 11 USA
4 21 USA
5 38 USA
")

win <- (ts
	|> select(country)
	|> distinct()
	|> mutate(start=-Inf, end=Inf)
)

modzero <- egf(model = egf_model(curve = "logistic", family = "pois")
	, data_ts = ts
	, formula_ts = cbind(t, cases) ~ country
	, formula_parameters = ~ country
	, data_windows = win
	, formula_windows = cbind(start, end) ~ country
	, se = TRUE
)

options(contrasts=replace(getOption("contrasts"), "unordered", "contr.sum"))

mod <- egf(model = egf_model(curve = "logistic", family = "pois")
	, data_ts = ts
	, formula_ts = cbind(t, cases) ~ country
	, formula_parameters = ~ 0+country
	, data_windows = win
	, formula_windows = cbind(start, end) ~ country
	, se = TRUE
)

fixef(modzero)
fixef(mod)
## confint(mod)
## predict(mod, log=FALSE)
