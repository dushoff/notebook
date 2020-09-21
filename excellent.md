
An excellent number (base b) is a number that can be partitioned into a concatenation N = c(x,y) s.t. N = |x² - y²|. N = c(x, y) of course implies that to saying that N = Bx+y, where B>y is a power of b. 

Unless otherwise specified, I will assume below that the nominal base b=A (that is ten, the standard base, written in agnostic notation ☺). The functional base B is then a power of ten, which I can now write as 10.

In "strictly" excellent numbers (e.g., 34188), the length of x is the same or one less than the length of y. This means we are splitting the numbers in a natural, base-like way: choosing the functional base B for a given N as the smallest power of b that allows N to be written as Bx+y with x, y both less than B. 

In "positively" excellent numbers (e.g., 13467), N = x² - y². Positively excellent numbers cannot be strict (x must exceed B because x^2 must exceed Bx).

An excellent number where N = y² - x² is a negatively excellent number. It is left as an exercise to find a negatively excellent number that is not strictly excellent.

Here are some things I know about excellent numbers. I'm not sure how I learned them, but I doubt any of them are hard to prove.

## Mappings

If P is a positively excellent number with functional base B, then P-(B^2-1) is a negatively excellent number (and conversely). For example, since 34188 is excellent 1034187 is also excellent; similarly, 13467 is positively excellent, so 3468 is negatively excellent. 

This is a one-to-one mapping from positively to negatively excellent numbers for any _functional_ base, but it's not quite one-to-one for the set of functional bases under a nominal base. The number 1 base b can is mapped to from B^2 for any B that is a power of b. For example, 100 and 10000 are both positively excellent numbers which map to the negatively excellent 1.

## Factorizations

Any pair of excellent numbers (one positively, one negatively excellent) corresponds to a factorization of B²-1. A convenient way to think of this factorization is in terms 
