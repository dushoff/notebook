
library(rRlinks) 
source("vocUnit.R")

# If the baseline number of cases is B, then the variant went from 0.2B to 0.44B cases in four weeks, and the wild-type from 0.8B to 0.56B

# Thus we can calculate
Window <- 2*week
r_wt <- log(0.56/0.8)/Window
r_voc <- log(0.44/0.2)/Window
r_voc <- 0.566/week


## To estimate R we need an estimate of fbar and kappa – the mean and shape of the forward serial interval (since we're observing incidence of reports)

fbar <- 4.7*day
kappa <- 0.5 ## SEIR-like (see lots and lots of stuff that I never ever write up)

R_wt <- genExp(r_wt*fbar, kappa)
R_voc <- genExp(r_voc*fbar, kappa)
ratio <- 
print(c(R_voc = genExp(r_voc*fbar, kappa)))
