    library(rRlinks)
    library(dplyr)

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

    library(tidyr)
    library(ggplot2)

    day <- 2.37
    day <- 0.37
    rmin <- -0.1/day
    rmax <- 0.1/day
    rsteps <- 100
    Dmax <- 500/day

    dr <- 0.057/day ## r_new-r_orig (PHE via Day)
    Rscale <- 1.47 ## R_new/R_orig

    g <- 6.6*day
    kappa <- 0

    week <- 7*day

    ######################################################################

    r_orig <- seq(rmin, rmax, length.out=rsteps)

    calcf <- (data.frame(r_orig)
        %>% mutate(
            r_offset = r_orig + dr
            , R_orig = genExp(r_orig*g, kappa)
            , R_mult = R_orig*Rscale
            , r_mult = genLog(R_mult, kappa)/g
        )
    )

    rf <- (calcf
        %>% select(contains("r_", ignore.case=FALSE))
        %>% pivot_longer(!r_orig, names_to="method", values_to="r_new")
        %>% mutate(r_orig=r_orig*day, r_new=r_new*day
            , method=sub("r_", "", method)
        )
    )

    print(rf)

    ## # A tibble: 200 x 3
    ##     r_orig method   r_new
    ##      <dbl> <chr>    <dbl>
    ##  1 -0.1    offset -0.043 
    ##  2 -0.1    mult   -0.0416
    ##  3 -0.0980 offset -0.0410
    ##  4 -0.0980 mult   -0.0396
    ##  5 -0.0960 offset -0.0390
    ##  6 -0.0960 mult   -0.0376
    ##  7 -0.0939 offset -0.0369
    ##  8 -0.0939 mult   -0.0356
    ##  9 -0.0919 offset -0.0349
    ## 10 -0.0919 mult   -0.0335
    ## # … with 190 more rows

    Df <- (rf
        %>% transmute(
            D_orig = log(2)/r_orig
            , D_new = log(2)/r_new
            , method=method
        )
        %>% filter(D_orig < Dmax/day)
    )

    print(
        ggplot(rf)
        + aes(x=r_orig, y=r_new, color=method)
        + geom_point()
        + geom_line()
    )

![](VoC_files/figure-markdown_strict/unnamed-chunk-1-1.png)

    silent <- (
        ggplot(Df)
        + aes(x=D_orig, y=D_new, color=method)
        + geom_point()
        + geom_line()
    )
