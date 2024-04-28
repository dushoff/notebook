---
title: "Notes on a robust power-mean function"
author: Jonathan Dushoff
date: 2024 April
---

$x^\varepsilon$ = $\exp(\varepsilon \log(x))$ =
$1 + \varepsilon\log(x) + \varepsilon^2\log(x)^2/2 + \ldots$

When $\varepsilon$ is small, we probably want to be dealing with the stable quantity $(x^\varepsilon-1)/\varepsilon$
$\approx \log(x) + \varepsilon\log(x)^2/2$

What are the issues with computing this and inverting it? I think it's probably ok to assume that $\log(x)$ is relatively small in magnitude (maybe warn if it's not?). The quadratic approach leads to more instability, so we should do a naive inversion

If $y \approx \ell + \varepsilon \ell^2/2$, then to first order
If $\ell \approx y - \varepsilon y^2/2$.
