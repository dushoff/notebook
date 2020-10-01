---
layout: page
title: Excellent numbers
---

An excellent number (base b) is a number that can be partitioned into a concatenation N = c(x,y) s.t. N = |x² - y²|. N = c(x, y) of course implies that to saying that N = Bx+y, where B>y is a power of b. 

Unless otherwise specified, I will assume below that the nominal base b=A (that is ten, the standard base, written in agnostic notation ☺). The functional base B is then a power of ten, which I can now write as 10.

In "strictly" excellent numbers (e.g., 34188), the length of x is the same or one less than the length of y. This means we are splitting the numbers in a natural, base-like way: choosing the functional base B for a given N as the smallest power of b that allows N to be written as Bx+y with x, y both less than B. 

In "positively" excellent numbers (e.g., 13467), N = x² - y². Positively excellent numbers cannot be strict (x must exceed B because x² must exceed Bx).

An excellent number where N = y² - x² is a negatively excellent number. It is left as an exercise to find a negatively excellent number that is not strictly excellent.

Here are some things I know about excellent numbers. I'm not sure how I learned them, but I doubt any of them are hard to prove.

## Mappings

If P is a positively excellent number with functional base B, then P-(B²-1) is a negatively excellent number (and conversely). For example, since 34188 is excellent 1034187 is also excellent; similarly, 13467 is positively excellent, so 3468 is negatively excellent. 

This is a one-to-one mapping from positively to negatively excellent numbers for any _functional_ base, but it's not quite one-to-one for the set of functional bases under a nominal base. The number 1 base b can is mapped to from B² for any B that is a power of b. For example, 100 and 10000 are both positively excellent numbers which map to the negatively excellent 1.

## Factorizations

Any pair of excellent numbers (one positively, one negatively excellent) corresponds to a factorization B²-1 = ff'. It's useful to write this as B²-1 = ℓh·ℓ'h', where ℓℓ' = B-1 and hh' = B+1. Conceptually, the factorization ff' starts from the factorization (B-1)(B+1) and then “switches” ℓ and h (or, equivalently, ℓ' and h').

There is a lot of half-baked algebra I did mostly in my head which I am not going to try to write here, at least for a while. I'll instead skip to some assertions about the results.

Any factorization will give us an algebraic solution, but for this solution to correspond to an excellent number, we need the values of y (which differ by only 1) to be < B. For example 640² - 1025² = -641025, so 640 and 1025 solve the algebraic equations for B=1000, but we can't concatenate them to get an excellent number because there's an extra digit.

The ratio between ℓ and h determines the “magnitude” of the excellent number, defined as N/B² (I'll use N;P for the negatively and positively excellent members of a pair). It turns out that the tipping point where a solution is no longer excellent is when the magnitude is around 1/σ, where σ is the golden ratio (thus P/B² would be around σ): this tipping point occurs when the larger of ℓ and h is around sig^3 bigger than the smaller. When ℓ and h are closer together than b-1 and b+1 (approximately) the magnitude becomes smaller than 1/b and we can have negatively excellent numbers which are not strictly excellent.

If one of the factors (conventionally, f) is 1, then we generate the pair 1, B². Otherwise, we assume without loss of generality that ℓ>h (thus ℓ'<h').

We define m = (ℓ-h)/2, n = (ℓ+h)/2. m' and n' are defined correspondingly (with something switched so that m'>0). 

_Example_: ℓ=27 and h=11. Thus, m=8, n=19, ℓ'=37, h'=91 m'=27, n'=64.

We can generate N as (mB+n)·m' or as (m'B+n')·m + 1.

_Example_: N = 8019·27 = 216513 = 27064·8 + 1.

We can obviously generate P as N+B-1, but it also has its own rules. P = (nB+m)·n' = (n'B+m')·n -1

_Example_: P = 19008·64 = 64027·19 - 1.

These products can also be structured in terms of just one set of switches. For example m' = (mB+n)/(hℓ), thus N = (mB+n)²/(hℓ). Similarly, n' = (nB+m)/(hℓ).

_Example_: 19008/(11·27) = 

######################################################################

-(216^2-513^2)
8019*27
27064*8 + 1
8019^2/27/11
27064*(27000-64)/37/91 + 1

1216^2 - 512^2
19008*64
64027*19 - 1
19008^2/27/11
64027*(64000-27)/37/91 - 1
