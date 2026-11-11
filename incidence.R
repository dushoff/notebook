library(ggplot2); theme_set(theme_bw())
library(dplyr)
library(tidyr)

library(shellpipes)
sourceFiles()
startGraphics()

## n = N/K
powFun <- function(n, theta){
	return(n^(1-theta))
}

satFun <- function(n, theta){
	return(n/(1-theta+n*theta))
}

## Human-friendly formula: f = (1-(1-theta)^n)/theta
## Rewritten with expm1 and log1p for accuracy
hazFun <- function(n, theta){
	stopifnot(length(theta)==1)
	if (theta==0) return(n)
	return(-expm1(n*log1p(-theta))/theta)
}

## Same families, parameterized by h = f(1/2)
## h=0.5 is mass action (theta=0); h=1 is frequency dependence (theta=1)
## theta as a function of h, for each family
powThetaHalf <- function(h) 1+log2(h)
satThetaHalf <- function(h) 2-1/h
hazThetaHalf <- function(h) 1-(1/h-1)^2

## One tibble with every form × h × n combination; both sets of plots are slices of it
## h values built from integers so that filtering on h matches exactly
forms <- list(
	Power=list(fun=powFun, theta=powThetaHalf)
	, Saturating=list(fun=satFun, theta=satThetaHalf)
	, Hazard=list(fun=hazFun, theta=hazThetaHalf)
)
incTab <- (expand_grid(form=names(forms), h=(5:10)/10)
	|> rowwise()
	|> mutate(theta=forms[[form]]$theta(h))
	|> reframe(form, h, theta, n=seq(0.01, 1, by=0.01)
		, f=forms[[form]]$fun(n, theta)
	)
	|> mutate(form=factor(form, levels=names(forms)))
)

## One plot per functional form, colored by h
for (fm in levels(incTab$form)){
	print(ggplot(filter(incTab, form==fm))
		+ aes(n, f, color=as.factor(h))
		+ geom_line()
		+ labs(color="h")
		+ ggtitle(fm)
	)
}

## One plot per h, colored by functional form
hPlot <- function(hv){
	return(ggplot(filter(incTab, h==hv))
		+ aes(n, f, color=form)
		+ geom_line()
		+ labs(color="form")
		+ ggtitle(paste("h =", hv))
	)
}

hVals <- (6:9)/10
for (hv in hVals) print(hPlot(hv))

## Same, with force of infection on a logit scale
## (f=1 at n=1 maps to Inf, so drop that point)
for (hv in hVals){
	print(hPlot(hv) + filter(incTab, h==hv, f<1)
		+ scale_y_continuous(transform="logit"
			, breaks=c(0.01, 0.03, 0.1, 0.25, 0.5, 0.75, 0.9, 0.97, 0.99, 0.997, 0.999)
		)
		+ ggtitle(paste("h =", hv, "(logit scale)"))
	)
}
