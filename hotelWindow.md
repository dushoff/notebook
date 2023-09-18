## Approximate solultion

The average speed passing your window is v_w = 1.6m/0.15s. Take that as approximately the speed in the _middle_ of the window and use v^2 = 2ad. Then drop point is d = v_w^/2g above the middle of the window.

(1.6/0.15)^2/(2*9.8) ## 5.80m

Since the middle is 0.8m from the top, this is 5.00m from the top.

This method will not always be good. The acceleration during the window stage should be relatively small compared to the mean velocity.

## Exact solution

The height above the _top_ of the window is h_t, and the height above the bottom is h_b = h_t+1.6m

The time to _reach_ the top is then sqrt(2h_t/g) and similar for the bottom

So the equation to solve is:

sqrt(2h_b/g) - sqrt(2h_t/g) = 0.15s

This seems like a pain. Definitely make both sides relatively simple before squaring.

sqrt(2h_b/g) = sqrt(2h_t/g) + δ

2h_b/g = 2h_t/g + 2δ sqrt(2h_t/g) + δ^2

2/g(h_b-h_t) - δ^2 =  2δ sqrt(2h_t/g)

2*(1.6m)/g - δ^2 = 2δ sqrt(2h_t/g)

Simplify some more so that we can square both sides again!

(2*(1.6m)/g - δ^2)/(2δ) = sqrt(2h_t/g)

(2*1.6/9.8 - 0.15^2)/(2*0.15) ## 1.0134s

(1.0134s)^2 = 2h_t/g

h_t = (1.0134s)^2 * g/2 

1.0134^2 * 9.8/2 ## 5.032m

So that's presumably how you were supposed to do it. Notice that the approximation worked pretty well in this case, but I was also a bit worried how you were supposed to know that it would.




