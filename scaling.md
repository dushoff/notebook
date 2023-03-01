

If we have a linear model given by Ŷ = Xβ, the way to think about rescaling the same model is by writing it as  Ŷ = XT*Sβ, where T is a transformation of model matrix, and S is its inverse. Thus, if we start with XT then lm.fit will give us Sβ. We can get the original β back by left-multiplying the new β by the same T that we used on X! So that if we scale X then solve, we can move back to the original variables by multiplying β by the same matrix that we used to scale X.

----------------------------------------------------------------------

We can unscale a scaled model matrix by right-multiplying by 

1 μ1 μ2 …
0 σ1  0
0  0 σ2

The inverse is 

1  -κ1  -κ2
0 1/σ1   0
0   0  1/σ2

