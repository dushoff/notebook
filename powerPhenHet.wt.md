---
layout: page
title: Power law notes for phenomenological heterogeneity
---

## Intro 

Thinking about how to model hazard in a population with heterogeneous susceptibility.  Strongly related to the work done specifically for moth viruses, and specifically for the gamma distribution, at [[gamma speculations]].  Note that the "Approximation" section makes an approximation that is exactly equivalent to assuming gamma distributions.

### Links 

* [[Generalized exponential]] shows that this works perfectly for gammas, but worse than expected for other distributions.  I think.
* [[Heterogeneous susceptibility simulations]] seems to have nothing good.

## Framework 

Imagine a population of "surviving" individuals, with heterogeneous susceptibility distribution $N(s)$ that is exposed to a force of infection $f(t)$ such that an individual with susceptibility $s$ experiences hazard $s f(t)$.

## Definitions 

$N_k \equiv \int{s^k N(s)\,ds}$.  Thus, $N \equiv N_0$ is the size of the surviving population.  $N_1$ would be the total amount of susceptibility, which is awkward, and inspires our next set of moments:

$s_k \equiv N_k/N$.  Thus, $\bar s \equiv s_1$ is the mean susceptibility in the surviving population.  $s_2$ is $\bar s^2 + \sigma_s^2$, which is awkward, and inspires the definition:

$\kappa \equiv s_2/\bar s^2 - 1$.  $\kappa$ is the squared coefficient of variation of susceptibility in the surviving population.

$F \equiv \int{f(t)\,dt}$ is the cumulative force of infection experienced.

## Dynamics 

The distribution of surviving individuals will obey the "master equation":

$\frac{dN(s)}{dF} = -sN(s)$.

Integrating over $s$ gives: 

$\frac{dN}{dF} = -sN(s)$ $= -N_1$ $=-\bar s N$, which is nice and makes sense: the instantaneous change in the number of survivors is predicted by the ''mean'' susceptibility.

The cool part is that we can multiply the master equation by $s^k$ and get a chain of moment equations:

$\frac{s^k dN(s)}{dF} = -s^{k+1}N(s)$, and integrating gives

$\frac{dN_k}{dF} = -N_{k+1}$ $=-s_{k+1} N$.

In particular, when $k=1$, we can calculate how the mean susceptibility changes:

$\frac{dN_1}{dF} = -s_2 N$.

Using the quotient rule:

$\frac{d\bar s}{dF} = -s_2 + \bar s^2 = -\kappa\bar s^2$.

We could continue the moment chain, but we will stop here by making an approximation.  We assume that the unitless squared CV $\kappa$ remains constant (this will be exactly true if $N(s)$ is gamma distributed).

## Approximation 

### How susceptibility changes 

Using the approximation of constant $\kappa$, we can solve the dynamics of $\bar s$:

$\bar s = \frac{s_0}{1+\kappa Fs_0}$.  We can also set $s_0$ to 1, by calibrating $F$ to be equivalent to the mean hazard for the starting population.  Then 

$\bar s = \frac{1}{1+\kappa F}$. 

### Survival 

The proportion surviving follows:

$\frac{dN}{dF} = -\bar s N = \frac{N}{1+\kappa F}$,

which is solved by what I call the [[generalized exponential]]:

$N/N_0 = (1+\kappa F)^{-1/\kappa} \equiv X(F; \kappa)$

### Susceptibility vs. survival 

What is the relationship between mean susceptibility and proportion surviving?  Should this be suggested as an alternative to Granich heterogeneity?

We can invert our last formula to get $\bar s = (N/N_0)^\kappa$; in Granich terms, the prevalence $P$ is analogous to $1-N/N_0, and transmission is proportional to susceptibility, so the answer is power-law phenomenological heterogeneity: $\beta \propto (1-P)^\kappa$.

