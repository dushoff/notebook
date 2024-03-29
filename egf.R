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

mod <- egf(model = egf_model(curve = "logistic", family = "pois")
	, data_ts = ts
	, formula_ts = cbind(t, cases) ~ country
	, formula_parameters = ~ country
	, data_windows = win
	, formula_windows = cbind(start, end) ~ country
	, se = TRUE
)

mod0 <- update(mod,  formula_parameters = ~ 0 + country)

print(predict(mod)[1:5,])
print(predict(mod0)[1:5,])
