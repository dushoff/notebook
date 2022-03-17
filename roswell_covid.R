library(tidyverse)

library(shellpipes)

loadEnvironments()

vid <- read.csv("https://github.com/nytimes/covid-19-data/raw/master/rolling-averages/us-states.csv")

head(vid)

## ----reference data-----------------------------------------------------------

ref_date <- vid %>% filter(date =="2021-10-17") %>%  select(state, ref_case_rate = cases_avg_per_100k)

new_vid<-vid %>% left_join(ref_date)


## ----rescale data and filter states-------------------------------------------
nel_vid<-new_vid %>% mutate(nel_rate = log(cases_avg_per_100k/ref_case_rate)
                            , prop_rate = cases_avg_per_100k/ref_case_rate
                            , date = as.Date(date))

near_states <-c("Maryland", "Virginia", "Delaware", "District of Columbia", "West Virginia", "Pennsylvania")


## ----plot arithmetic----------------------------------------------------------
nel_vid %>%  
  filter(state %in% near_states) %>% 
  ggplot(aes(date, prop_rate))+
  geom_point(size = 0.2)+
  facet_wrap(~state) +
  theme_classic() +
  geom_hline(yintercept = 1, size = 0.1) +
  geom_vline(xintercept = as.Date("2021-10-17"), color = "red") +
  scale_x_date() +
  labs(y = "Cases relative to my reference", x = "date") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))



## ----first nel plot-----------------------------------------------------------
nel_vid %>%  
  filter(state %in% near_states) %>% 
  ggplot(aes(date, nel_rate))+
  geom_point(size = 0.2)+
  facet_wrap(~state) +
  theme_classic() +
  geom_vline(xintercept = as.Date("2021-10-17"), color = "red") +
  scale_x_date() +
  geom_hline(yintercept = 0, size = 0.1) +
  labs(x = "date", y = "Cases relative to my reference \n(nels)") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))




## ----nel to centinel----------------------------------------------------------
# drop before april 2020
cut_vid <-nel_vid %>% filter(date > as.Date("2020-04-01"))

# we are used to using percents instead of proportions
cut_vid %>%  
  filter(state %in% near_states) %>% 
  ggplot(aes(date, prop_rate))+
  geom_point(size = 0.2)+
  facet_wrap(~state) +
  theme_classic() +
  geom_hline(yintercept = 1, size = 0.1) +
  geom_vline(xintercept = as.Date("2021-10-17"), color = "red") +
  scale_x_date() +
  scale_y_continuous(labels = scales::percent) +
  labs(y = "Cases relative to my reference", x = "date") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))

# now "centinels" instead of "nels"
cut_vid %>% 
  filter(state %in% near_states) %>% 
  ggplot(aes(date, nel_rate*100))+
  geom_point(size = 0.2)+
  facet_wrap(~state) +
  theme_classic() +
  geom_vline(xintercept = as.Date("2021-10-17"), color = "red") +
  scale_x_date() +
  geom_hline(yintercept = 0, size = 0.1) +
  labs(x = "date", y = "Cases relative to my reference \n(nels)") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))



## ----centinels vs. percents---------------------------------------------------

x <- c(100, 5, pi)
# 1% increase
y <- x*1.01 
z <- x *0.99
w <- x / 1.01
centinel <- function(x, ref){
  100*log(x/ref)
}

percent <- function(x, ref){
  100*(x/ref -1)
}


percent(y, x)
# it's pretty close
centinel(y, x)


# compare to decreases
percent(z, x)
# these are all close too
percent(w, x)

centinel(z, x)
centinel(w, x)  

# percents go additively, though. So it's hard to think about compounding them
# which is what we usually want to do when things change

# if COVID went up by 1% a day for five consecutive days, it would go up by 
# about 5 %. 
1.01^5
# But if it went up by 1% a day for fifty consecutive days
1.01^50
# it would go up by more than 60%. This can really trip me up!

# centinels compound much more sensibly

compounded <- function(x, change, times){
  x*change^times
}

# compound 1% 50 times, you get a 64% increase
percent(compounded(x, 1.01, 50), x)

# but a 50 centinel increase :-)
centinel(compounded(x, 1.01, 50), x)

# try going backwards
percent(compounded(x, 0.99, 50), x)
# that's annoying. Only 39% now?!?!


centinel(compounded(x, 0.99, 50), x)
# still a change of 50 centinels

# and more precisely opposite 
centinel(compounded(x, 1/1.01, 50), x)



## ----centinels and ratios-----------------------------------------------------

cut_vid %>% 
  filter(state %in% near_states) %>% 
  ggplot(aes(date, nel_rate))+
  geom_point(size = 0.2)+
  facet_wrap(~state) +
  theme_classic() +
  geom_vline(xintercept = as.Date("2021-10-17"), color = "red") +
  scale_x_date() +
  scale_y_continuous(
    labels = function(x){str2expression(print_operator(x))}
   , breaks = rat_breaks()
   , sec.axis = sec_axis( trans = function(x){x*100}
                          , name = "centinels")) + 
  geom_hline(yintercept = 0, size = 0.1) +
  labs(x = "date", y = "Cases relative to my reference \n(ratio scale)" ) +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))


