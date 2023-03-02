---
layout: page
title: Incidence functions
author: Jonathan Dushoff
fontsize: 12pt
date: 2022 Dec
---

The key to getting nice functional forms _with nice parameters_ for disease-incidence functions is to have both a standard population size $K$ and an actual population size $N$. $K$ is comparable to $N$ (same units) but _does not change_ in the course of a realization of the model. For many models a good choice for $K$ will be the disease-free equilibrium value of $N$.

Then we can write the “standard” incidence function (corresponding to frequency-dependent transmission) as:

$$ \Lambda = \beta / I//N / $$

… and the “mass-action” incidence function (corresponding to density-dependent transmission) as:

$$ \Lambda = \beta / I//K / $$

In both cases $\Lambda$ and $\beta$ are pure rates, and $I$ has the same units as its denominator.

From here, we can build friendly versions of generalized incidence, following either the “power” approach

$$ \Lambda = \beta / I//N^\theta K^{1-\theta} / $$

… or the “saturating” approach

$$ \Lambda = \beta / I//N\theta+K(1-\theta) / $$


