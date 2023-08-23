---
layout: page
title: Doubly censored intervals
---

Linton et al.\cr(https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7074197/) proposes correcting the doubly censored interval likelihood formula for exponential growth and for truncation.

The likelihood is:

$$
L =
\int_{e_L}^{e_R}
\int_{s_L}^{s_R}
g(e) f(s-e)
ds\,de
$$

where $$e$$ and $$s$$ mnemonically represent exposure and symptom onset. The proposed correction leaves $$g(e)$$ as uniform and instead implements the assumed exponential growth [in a survival framework](https://speakerdeck.com/highlow/estimation-of-epidemiological-time-intervals-and-their-properties). As far as I can tell, it implements an exponential censoring function (with rate $$r$$ to be survived before observation). This seems inappropriate, and leads to a form that seems to have bad theoretical properties (does not converge to the expected simpler estimator as $$r\to0$$) and has caused trouble in practice.

We can correct for dynamical effects on the scale of the _observation window_ (distinguished here from the censoring window) simply by truncating, which we do using a straightforward denominator, integrating across possible  (un-truncated) observation times of $$s$$ for a given observation of $$e$$.

$$
L = \frac
{\int_{e_L}^{e_R} \int_{s_L}^{s_R} g(e) f(s-e) ds\,de}
{\int_{e_L}^{e_R} \int_{e_L}^{T} g(e) f(s-e) ds\,de}
$$

We can correct for dynamical effects on the scale of the _censoring_ window by using $$g(e) = \exp(re)$$, instead of $$g(e)=1$$. We expect this correction to have small effect as long the unitless quantity $$r(e_R-e_L)$$ is almost always small (in other words, as long as the censoring interval is almost always substantially less than the time scale of exponential change $$1/\vert r\vert $$.
