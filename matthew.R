
library(shellpipes)

dat <- csvRead()

print(dat)

## Old-fashioned code

tmpdate <- c(NA, dat$Date[-nrow(dat)])
for (r in 1:nrow(dat)){
	dat$Date[[r]] <- ifelse(is.na(dat$Date[[r]]), tmpdate[[r]], dat$Date[[r]])
}

csvSave(dat)

