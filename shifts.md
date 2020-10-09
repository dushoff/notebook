---
layout: page
title: R(t)
---

Thoughts on [Gostic et al.](https://www.medrxiv.org/content/10.1101/2020.06.18.20134858v3) and other investigations of R(t) for COVID-19.

We attempt to infer reproductive numbers by referring to time series of observed cases. Our observations may represent the actual time of infection, the onset of symptoms, time of seeking medical care, test confirmation date, …

To infer reproductive number, we need to know something about the amount of time it takes a case to produce another case. We use “serial interval” generally, to describe interval between the standardized observation time of an infectee and the observation time of their infector. This can be calibrated to correspond to the time series as above. Interestingly, calibration is necessary – if we define observation time differently, we get different distributions of serial intervals, even though all these distributions describe generations of the same underlying process. A vivid example of this is the fact that a serial interval based on medical reports can be negative (the infectee might be reported before the infector) whereas a serial interval based on actual time of infection (typically known as a generation interval) cannot be. 

## Infection times

Let's first imagine that we want to infer the reproductive number based on actual infection times. For a few diseases, notably rabies (where infection is often transmitted by dramatic biting events) this may actually be a good observation point. For other diseases, we would first need to infer an infection time series from our observation time series.

There are two simple frameworks in which we can do this. The first we call the “instantaneous reproductive number”. In this framework, the number of people who become infected on a given day is proportional to the reproductive number for that day. This is the number inferred by the method of Cori.

The second we call the “case reproductive number”. In this framework, the infectiousness of people infected on a given day is proportional to the reproductive number for that day. In other words, the chance that I infect you today depends directly not on the conditions of today, but the conditions when I became infected. This is the method of Wallinga. In this context, it is less appropriate. because it attributes effects to an earlier time (infection of the primary case).

## Symptom onset times

The next best thing to infection times is probably symptom onset times. These are _biologically_ related both to the infection and the infectiousness of the focal individual. They suffer less from administrative and technical complications than medical visits, tests or reports. But they still create a lot of potential problems.

Estimating the _infection-based_ instantaneous reproductive number using symptom onset data requires inferring both an infection time-series, and an estimate of the distribution of _generation_ intervals (generally from observed symptom-based serial intervals. Both are technically challenging.

A commonly employed, “second-best” method, is to directly infer time-dependent reproductive numbers from the observed time series. This is reasonably straightforward to do, but harder to interpret.

In this context, the instantaneous reproductive number assumes that the number of people who become _symptomatic_ on a given day is proportional to conditions on that day. In fact, the number of people who become symptomatic today certainly depends on conditions in the past. Thus, in this case, the instantaneous reproductive number attributes effects _later_ than they occur (because the observation occurs after the infection).

But we already know that case reproductive numbers tend to attribute effects _earlier_ than they occur. Could these two effects cancel out? If we naively apply the case reproductive number to a symptom onset time series, we are assuming that the likelihood of transmission is related to conditions at the time when the infectors become symptomatic. The quality of this assumption depends on the nature of a given disease, but this seems like a pretty good fit for Covid-19.

## Conclusion

In an _ideal_ world, we would estimate the generation-interval distribution, infer infection time series, and use the method of Cori to estimate the instantaneous reproduction number. For real-world Covid-19 applications, directly using symptom onset and estimates of the serial interval, and estimating the case reproductive number based on symptoms with the method of Wallinga might be the most practical alternative.

