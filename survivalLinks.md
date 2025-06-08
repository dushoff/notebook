---
layout: page
title: Modeling survival
---

The hazard interpretation is very satisfying, and modeling survival with hazards is intuitively appealing. But there are several “hazards” to doing this, and I guess the log odds approach is more robust in general.

The “direct” hazard approach is the most mechanistically appealing, but is fragile because it cuts off very sharply at H=0. Modeling using hazard makes the most sense when hazards are relatively high.

When hazards can be low, people typically use a log-hazard approach. This can feel a bit like the best of both worlds, but log hazard isn't hazard, and in many cases the idea of multiplying hazards (i.e., adding log hazards) does not feel mechanistic. An exception to this is time of exposure: multiplying hazard here has a straightforward interpretation and a straightforward implementation: log(time) as an offset on the log hazard scale.

Given these concerns, log odds seem almost like a miracle. They work like hazard at high hazards (which is what you want mechanistically); work like log hazard at low hazard (which is what you need for stability; _and_ also can sensibly take a log(time) offset. The offset works just like log hazard at low hazard (which may be when you most want it to): e.g., a risk of 1% goes to 2% when exposure time doubles. It saturates sensibly at high hazard (whereas log hazard models saturate very quickly: e.g., doubling exposure time makes the 90% risk goes to 95% in the log-odds model, but 99% in the log-hazard model.

Of course, log odds only _seem like_ a miracle. Sometimes they won't work well, and sometimes either the science or linked parts of a model will mean that you have to use hazards. 

A particular concern is when you have multiple observations of the same individual. By calculating a likelihood for each observation, you are implicitly combining the two periods with a hazard approach. This works fine for models on the hazard or log-hazard scale, but leads to a nominal inconsistency on the log-odds scale: the model incurably estimates a better chance of survival for the whole period if an individual is observed only once.

