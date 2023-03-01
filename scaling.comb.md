---
title: Scaling a linear model
author: Jonathan Dushoff
fontsize: 12pt
date: 2023 March
---

If we have a linear model given by $\hat Y = Xβ$, a good way to think about rescaling the fit is by writing it as  $\hat Y = (XT)(Sβ), where $T$ is a transformation of model matrix, and $S$ is its inverse. Thus, if we fit an lm with model matrix $XT$ the coefficients will be $Sβ$. Thus we can “undo” the scaling and get the original $β$ back by left-multiplying the new $β$ by the same $T$ that we used on $X$! 

## Standard scaling (like `scale()`)

It's easy to see that we could unscale a scaled model matrix by right-multiplying by 

$$ S = \begin{pmatrix}
1 & μ_1 & μ_2 & …\cr
0 & σ1 & 0\cr
0 & 0 & σ2\cr
\vdots &  &  & \ddots\cr
\end{pmatrix} $$

The inverse is 

$$ T = \begin{pmatrix}
1 & -κ_1 & -κ_2 & \ldots\cr
0 & 1/σ_1 & 0\cr
0 & 0 & 1/σ_2\cr
\vdots &  &  & \ddots\cr
\end{pmatrix} $$

where $κ = σ/μ$ is the CV.

So `scale()` is equivalent to right-multiplying $X$ by $T$. We can transform the coefficients of a scaled fit back to the original coefficients by left-multiplying by the fitted $β$ by $T$.
