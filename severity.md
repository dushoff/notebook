---
layout: page
title: Simple calculations about routes of transmission
---

If we summarize something like a COVID SEAIR model in terms of routes of transmission, we can write the van den Driessche/Watmough $$FV^{-1}$$ as $$PBD$$, where $$D$$ is the diagonal matrix of durations, $$B$$ (capital $$β$$) is the diagonal matrix of subgroup infectiousness, and $$P$$ is the matrix of proportion of infections from group $$j$$ that go to group $$i$$ (columns sum to 1). But for a real renewal approach, we don't want to split $$B$$ and $$D$$, so I'll just write $$PΔ$$

The “generational” eigenvector is the dominant eigenvector of this matrix, satisfying $$gR = PΔg$$.

To calculate the “incidence” eigenvector, we need the “discounted” version of $$Δ$$. If we want to be able to jump a bit between renewal and ODE approaches, a convenient way to write this is:

$$δ_j(r) = \int \beta_j(\tau) F_j(\tau) \exp(-rτ) dτ$$, 

where $$F$$ is the probability of being infectious at time τ after infection (ignored for a pure generation approach) and $$β$$ is the infectiousness given that you're infectious (constant for a pure SEIR). $$δ_j(0)$$ is just the subgroup reproduction number $$δ_j$$.

We can rewrite the generational eigenvector equation as  $$gR = PΔ(0)g$$, reflecting the fact that we have generalized the $$Δ$$ vector. This determines both the eigenvector and the reproductive number $$R$$.

The incidence eigenvector equation is then $$i = PΔ(r)i$$, and determines both the eigenvector and the rate of exponential growth $$r$$. 

Park's “incidence reproductive number” is then the sum of $$δ(0) i_j$$. Since we've specified $$Δ$$ as a diagonal matrix, this works out in linear algebra as $$R_p = \vec{1} Δ(0) \hat i$$, where $$\vec 1$$ is a horizontal vector of 1s, and $$\hat i$$ is the incidence eigenvector normalized to sum to 1. 

We can show that $$R_p$$ is a threshold quantity by pre-multiplying the incidence eigenvector equation by $$\vec 1$$.

$$\vec 1 \hat i = \vec 1 PΔ(r)\hat i$$

The product on the left is just 1, since we normalized $$i$$ without loss of generality. The product $$\vec 1 P$$ is just $$\vec 1$$ since $$P$$ is a matrix of proportions.

$$ 1 = \vec 1 Δ(r)\hat i$$.

We compare this to:

$$R_p = \vec 1 Δ(0)\hat i = R_p$$.

Since $$Δ(0) > Δ(r)$$ precisely when $$r>0$$, $$R_p$$ is a threshold quantity.
