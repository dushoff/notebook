## Intro 


## Intro

Thinking about how to model hazard in a population with heterogeneous
susceptibility. Strongly related to the work done specifically for moth
viruses, and specifically for the gamma distribution, at \[\[gamma
speculations\]\]. Note that the “Approximation” section makes an
approximation that is exactly equivalent to assuming gamma
distributions.

### Links

-   \[\[Generalized exponential\]\] shows that this works perfectly for
    gammas, but worse than expected for other distributions. I think.
-   \[\[Heterogeneous susceptibility simulations\]\] seems to have
    nothing good.

## Framework

Imagine a population of “surviving” individuals, with heterogeneous
susceptibility distribution *N*(*s*) that is exposed to a force of
infection *f*(*t*) such that an individual with susceptibility *s*
experiences hazard *s**f*(*t*).

## Definitions

*N*<sub>*k*</sub> ≡ ∫*s*<sup>*k*</sup>*N*(*s*) *d**s*. Thus,
*N* ≡ *N*<sub>0</sub> is the size of the surviving population.
*N*<sub>1</sub> would be the total amount of susceptibility, which is
awkward, and inspires our next set of moments:

*s*<sub>*k*</sub> ≡ *N*<sub>*k*</sub>/*N*. Thus, *s̄* ≡ *s*<sub>1</sub>
is the mean susceptibility in the surviving population. *s*<sub>2</sub>
is *s̄*<sup>2</sup> + *σ*<sub>*s*</sub><sup>2</sup>, which is awkward,
and inspires the definition:

*κ* ≡ *s*<sub>2</sub>/*s̄*<sup>2</sup> − 1. *κ* is the squared
coefficient of variation of susceptibility in the surviving population.

*F* ≡ ∫*f*(*t*) *d**t* is the cumulative force of infection experienced.

## Dynamics

The distribution of surviving individuals will obey the “master
equation”:

$\frac{dN(s)}{dF} = -sN(s)$.

Integrating over *s* gives:

$\frac{dN}{dF} = -sN(s)$  =  − *N*<sub>1</sub>  =  − *s̄**N*, which is
nice and makes sense: the instantaneous change in the number of
survivors is predicted by the ‘’mean’’ susceptibility.

The cool part is that we can multiply the master equation by
*s*<sup>*k*</sup> and get a chain of moment equations:

$\frac{s^k dN(s)}{dF} = -s^{k+1}N(s)$, and integrating gives

$\frac{dN\_k}{dF} = -N\_{k+1}$  =  − *s*<sub>*k* + 1</sub>*N*.

In particular, when *k* = 1, we can calculate how the mean
susceptibility changes:

$\frac{dN\_1}{dF} = -s\_2 N$.

Using the quotient rule:

$\frac{d\bar s}{dF} = -s\_2 + \bar s^2 = -\kappa\bar s^2$.

We could continue the moment chain, but we will stop here by making an
approximation. We assume that the unitless squared CV *κ* remains
constant (this will be exactly true if *N*(*s*) is gamma distributed).

## Approximation

### How susceptibility changes

Using the approximation of constant *κ*, we can solve the dynamics of
*s̄*:

$\bar s = \frac{s\_0}{1+\kappa Fs\_0}$. We can also set *s*<sub>0</sub>
to 1, by calibrating *F* to be equivalent to the mean hazard for the
starting population. Then

$\bar s = \frac{1}{1+\kappa F}$.

### Survival

The proportion surviving follows:

$\frac{dN}{dF} = -\bar s N = \frac{N}{1+\kappa F}$,

which is solved by what I call the \[\[generalized exponential\]\]:

*N*/*N*<sub>0</sub> = (1+*κ**F*)<sup>−1/*κ*</sup> ≡ *X*(*F*;*κ*)

### Susceptibility vs. survival

What is the relationship between mean susceptibility and proportion
surviving? Should this be suggested as an alternative to Granich
heterogeneity?

The answer looks like *s̄* = *X*<sup>*κ*</sup>; in Granich terms,
something like *β* ∝ (1−*P*)<sup>*κ*</sup>.
