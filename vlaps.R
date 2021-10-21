library(shellpipes)
library(dplyr)
library(forcats)

lap <- (csvRead("drivers")
	%>% left_join(csvRead("times"))
	%>% left_join(csvRead("races"), by="raceId")
	%>% left_join(csvRead("circuits"), by="circuitId")
	%>% left_join(csvRead("pit"), by=c("raceId", "driverId", "lap"))
)

summary(lap)

vlap <- (lap
	%>% filter(surname=="Verstappen")
	%>% filter(year >= 2018)
	%>% transmute(NULL
		, race=name.x, circuit=name.y
		, year, lap, position, time=milliseconds.x/1000
		, pit_time=milliseconds.y/1000
	)
	%>% mutate(across(where(is.character), ~fct_rev(fct_infreq(.))))
	%>% filter(time<300)
)
summary(vlap)
csvSave(vlap)
rdsSave(vlap)
