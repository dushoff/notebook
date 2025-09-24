## Goal 

Generate biased probability distributions, e.g., for codons with a given property. 

## Args

probs are observed probabilities.

counts are things that you want to bias by: the initial idea would be to use number of CG nucleotides in each codon

λ is the amount of bias; it should work symmetrically, with λ>0 increasing the amount of CG in the ensemble and conversely.

## Value

The function returns a vector of biased probabilities to be used for drawing codons.

## Comments

The suggestion is that this can be used separately for each multi-codon aa to redraw while preserving protein sequence, or can be used across all 61 codons.

It would also be worth considering adding 1 to each category count before calculating the initial probabilities, rather than assuming that anything you don't see in the sequence is just impossible. I think that this would correspond to a uniform Dirichlet prior. You could probably also consider adding something smaller than 1. I think that adding 1/2 corresponds to the Dirichlet Jeffreys prior. 

We could consider rewriting the function to accept counts instead of probabilities. If we call them counts, we would then want to rename the current counts, which are not well named anyway, maybe “covs” for covariates?
