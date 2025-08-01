# notebook (hosted on master now)

# http://localhost:4111/notebook/survivalLinks
# http://dushoff.github.io/notebook/survivalLinks

# http://localhost:4111/notebook/outputs/powerPhenHet.wt.math

# http://dushoff.github.io/notebook/rclone/
# http://dushoff.github.io/notebook/hotelWindow
# http://dushoff.github.io/notebook/snowball
# http://dushoff.github.io/notebook/powerPhenHet.wt
# http://dushoff.github.io/notebook/outputs/powerPhenHet.wt.math
# http://dushoff.github.io/notebook/outputs/powerPhenHet.wt.math

# http://localhost:4111/notebook/pronouns.html

## Looks good in outputs but not in
# http://localhost:4111/notebook/outputs/ComplexFactoring
# http://dushoff.github.io/notebook/outputs/ComplexFactoring

# http://dushoff.github.io/notebook/expCensoring
# http://dushoff.github.io/notebook/shifts.html
# http://dushoff.github.io/notebook/outputs/multilog.pdf
# http://dushoff.github.io/notebook/pronouns.html
# http://dushoff.github.io/notebook/pythagoras.html
# http://dushoff.github.io/notebook/acf.html
# http://dushoff.github.io/notebook/statstrength.html
# http://dushoff.github.io/notebook/ape.png
# http://dushoff.github.io/notebook/outputs/rp.newpyth.Rout.pdf
# http://dushoff.github.io/notebook/outputs/skewnormal.rmd.html
# http://dushoff.github.io/notebook/qbd.html

# http://dushoff.github.io/notebook/outputs/average.Rout.pdf
# http://dushoff.github.io/notebook/colors.html
# http://dushoff.github.io/notebook/outputs/urns.pdf
# http://dushoff.github.io/notebook/outputs/urns.html
# http://dushoff.github.io/notebook/outputs/rankReduce.html
# http://dushoff.github.io/notebook/outputs/newbd.html
# http://dushoff.github.io/notebook/outputs/VoCcomp.Rout.pdf
# http://dushoff.github.io/notebook/outputs/vlaps.Rout.csv
# http://dushoff.github.io/notebook/outputs/ryg.Rout.html

# https://github.com/dushoff/notebook/blob/master/orderStats.R
# https://github.com/dushoff/notebook/blob/master/rankReduce.md
# https://github.com/dushoff/notebook/blob/master/ryg.R
# https://github.com/dushoff/notebook/blob/master/outputs/
# https://github.com/dushoff/notebook/blob/master/outputs/rp.newpyth.Rout.pdf
# https://github.com/dushoff/notebook/raw/master/outputs/rp.newpyth.Rout.pdf

# serve: jekyll.log

## Suppress pandoc (don't want to pandoc here, we want to make serve instead)

## URL problem:
## Use relative pathnames for plain pages; /notebook/ for posts.
## Move on!

### Hooks for the editor to set the default target
current: target
-include target.mk

-include makestuff/perl.def
-include makestuff/python.def

######################################################################

Sources += mldoc.tex multilog.bib multilog.tex

multilog.pdf: multilog.tex

######################################################################

## Play with epigrowthfit

egf.Rout: egf.R

LF.Rout: LF.R

######################################################################

## Lucas-Fibonacci

LF.Rout: LF.R

######################################################################

## rclone pages

Sources += rclone/index.md rclone/privacy.md rclone/service.md

######################################################################

## log hazard, hazard, log odds
## survivalLinks.md

## bolkerSurvival.Rout: bolkerSurvival.R

######################################################################

## L-means

Ignore += *.html
Lmeans.html: Lmeans.md
	pandoc $< --mathjax -s -o $@
	$(panmath)

## wrapR is a good trick for functional code that we want to share with others!
Lmeans.Rout: Lmeans.R
	$(wrapR)

Lmtest.Rout: Lmtest.R Lmeans.rda

######################################################################

## 2024 is a CIPS!

cips.Rout: cips.R

units_trick.Rout: units_trick.R

## Inelegant solution to one of M's physics problems
hotelWindow.html: hotelWindow.md
	pandoc -f gfm -o $@ $< 

######################################################################

## Weitz, Rose gamma sculpting
sculpting.Rout: sculpting.R

## Hand raising; calling on people
.PHONY: calling.HTML
Sources += calling.html
Ignore += calling.HTML
calling.HTML: calling.html calling.pl
	$(PUSH)

call: calling.HTML
	google-chrome --new-window $< &
	while true; do $(MAKE) $<; sleep 1; done

######################################################################

## Composite of the day (cotd)

composite_list.Rout: composite_list.R

######################################################################

## Quantile-based distributions
# Johnson code is in https://github.com/dushoff/scratch

## skewnormal.rmd: skewnormal.wikitext
## skewnormal.rmd.md: skewnormal.rmd
skewnormal.rmd.html: skewnormal.rmd
	$(knithtml)

## Working surprisingly well (see pipeline stuff below)
## Still struggling with getting knit/render to produce md of the quality of their html or pdf
## Here it is refusing to not escape the tex
skewnormal.gh.md: skewnormal.rmd Makefile
	Rscript -e 'library("rmarkdown"); render("$<", output_format=md_document(variant="markdown_github"), output_file="$@")'

######################################################################

## Pinyin conversion

Ignore += romanized_names.tsv
Sources += names.txt ctable.py
romanized_names.tsv: names.txt ctable.py
	$(PITH)

## chainedStates.md

######################################################################

autopipeR = defined

## order statistics experiments

pngDesc += order
order.Rout: order.R
## order.uniform.png: order.R
## order.exp.png: order.R

orderStats.Rout: orderStats.R

## spin Not working well (needs to pass shellpipes stuff, for example)
## Seems like craziness anyway (rule doesn't specify target)
## Changed pipeline to read order.md and got a different error 2023 Dec 27 (Wed)
Ignore += *.MD
order.MD: order.R
	Rscript -e "knitr::spin('$<')"
Ignore += order.pdf
order.pdf: order.md
	$(pandocs)

######################################################################

## posfun.Rout.html: posfun.R

## centinels, divmults and breaks

Ignore += times.states.*.csv
times.states.%.csv:
	wget -O $@ "https://github.com/nytimes/covid-19-data/raw/master/rolling-averages/us-states.csv"
roswell_covid.Rout: roswell_covid.R breaks.rda times.states.01.csv

## breaks.Rout.html: breaks.R
## breaks.Rout: breaks.R

## ggratios.Rout: ggratios.R

######################################################################

## Counting ways of combining numbers

## A list of 15000 combinations
Sources += waltcount.txt

## Drop d and associated operators
Ignore += *.abc.txt
## waltcount.abc.txt: abc.pl
%.abc.txt: %.txt abc.pl
	$(PUSH)

## Drop the power operator
Ignore += *.abc.txt
Ignore += *.nopower.txt
## waltcount.nopower.txt: waltcount.txt nopower.pl
%.nopower.txt: %.txt nopower.pl
	$(PUSH)

#### maxima pipeline

Sources += oeis.txt

Sources += assume.mx

Ignore += *.mx
## waltcount.abc.mx: mxsimp.pl
%.mx: %.txt mxsimp.pl
	$(PUSH)

## waltcount.abc.mx.out: mxsimp.pl
%.mx.out: %.mx assume.mx
	cat assume.mx $< | maxima > $@

Ignore += *.expr
## waltcount.abc.mx.expr: mxexpr.pl
%.mx.expr: %.mx.out mxexpr.pl
	$(PUSH)

## waltcount.mx.expr.su:
## waltcount.abc.mx.expr.su:
Ignore += *.su *.wc
%.su: %
	sort -u $< > $@

## waltcount.mx.expr.su.wc:

#### bc pipeline (not used anymore)

Ignore += *.ivals.txt
## waltcount.nopower.ivals.txt: waltcount.txt nopower.pl
%.ivals.txt: %.txt ivals.pl
	$(PUSH)

## waltcount.nopower.txt:
## waltcount.nopower.abc.txt:
## waltcount.nopower.abc.ivals.txt:

Sources += bscale.txt
%.bcalc: %.txt sf.pl bscale.txt
	cat bscale.txt $< | bc -l | perl -wf $(filter %.pl, $^) > $@

Ignore += *.bcalc *.bvals
## waltcount.nopower.ivals.txt:
## waltcount.nopower.ivals.bcalc:
## waltcount.nopower.ivals.bvals:
## waltcount.nopower.abc.ivals.bvals:
%.bvals: %.bcalc
	sort -nu $< > $@

######################################################################

%.bc.out: %.bc
	bc -l < $< > $@

plane.bc.out: plane.bc

cryptic_heavy.bc.out: cryptic_heavy.bc

######################################################################

## Spinning a reverse-Polish engine for non-existent deeper explorations; stopped at random
## Uses digits, not real numbers (easy to fix)

rpn.out: rpn.pl
	$(PUSH)

year.Rout: year.R

omicron.Rout: omicron.R

## Prints numbers and the sum of their proper divisors (perfect number style)
## Also has an issquare function which is not used. Origin seems mysterious.
nowords.Rout: nowords.R

## Practicing for MMED
partic.Rout: partic.R

## stochInv project MOVED!!!
hetGen.Rout: hetGen.R

######################################################################

## Linton et al. correction notes

# http://dushoff.github.io/notebook/outputs/incfuns.comb.jax.html
## expCensoring.comb.md: expCensoring.md

######################################################################

## R script is in the research sandbox
rankReduce.html: rankReduce.md
	$(panmath)

## Avoid confusing people!
## confusing.md:
## 
bbias.Rout: bbias.R

## lognormal rarity identity from Roswell
ln_ident.Rout: ln_ident.R

## Adler weird problem (abandoned R because it doesn't have good hashes)
4loop.out: 4loop.pl
	$(PUSH)

## Adler sequence of sums of squares
squareSum.Rout: squareSum.R
	$(wrapR)

######################################################################

Sources += $(wildcard *.bc)

mathbox.out: mathbox.bc

## Long excellent numbers

## 9999999: 3 3 239 4649
## 10000001: 11 909091
## (158730)[k]16(126984)[k]128
## e1.out: e1.bc
## e2.out: e2.bc
%.out: %.bc
	bc -l < $< > $@

## Sincere numbers
sincere.out: sincere.bc

Sources += sincere_fra.txt sincere_jd.txt
sincere.check.Rout: sincere.check.R sincere_fra.txt sincere_jd.txt
	$(pipeR)

######################################################################

Ignore += f1data
f1data:
	ln -s ~/Dropbox/$@ .

## See also dataviz!
## Data from https://www.kaggle.com/miguelluna93/formula-1-1950-2020
vlaps.Rout: vlaps.R $(wildcard f1data/*.csv) f1data
## vlaps.Rout.csv: vlaps.R

vlap_plots.Rout: lap_plots.R vlaps.rds
	$(pipeR)

######################################################################

## stupid-simple jags model

######################################################################

# http://localhost:4111/notebook/statstrength.html
# http://dushoff.github.io/notebook/statstrength.html
statstrength.md:  statstrength_figs
Sources += statstrength_figs/*.png
Sources += statstrength_cases.pdf
statstrength_figs: %: %/case-0.png %/case-1.png %/case-2.png %/case-3.png %/case-4.png %/case-5.png
Ignore += statstrength_cases-*.pdf
## statstrength_figs/case-0.png: statstrength_cases-0.pdf
statstrength_figs/case-%.png: statstrength_cases-%.pdf 
	convert -density 400 -crop 3200x1000+400+300 -trim $< -quality 100 -sharpen 0x1.0 $@

clarStrength.Rout: clarStrength.R

######################################################################

acf.Rout: acf.R

gdc.Rout: gdc.R
	$(run-R)

VoC.Rout: VoC.R
	$(makeR)

Ignore += VoC.pdf
VoC.pdf: VoC.R
	$(rmdpdfBang)

Ignore += VoCsimple.pdf
VoCsimple.Rout: VoCsimple.R
	$(pipeR)

VoCsimple.pdf: VoCsimple.R
	$(rmdpdfBang)

VoCinfer.Rout: VoCinfer.R orphan code to solve implied PHE rR

## 2020 Dec 30 (Wed) In flux: try to DRY 
## FIXME: this behaves suspiciously when r is very small
VoCcomp.Rout: VoCcomp.R
	$(pipeR)
## VoCcomp.Rout-1.pdf: VoCcomp.R

matthew.Rout: matthew.R doodle.csv
	$(pipeR)

## matthew.Rout.csv:

######################################################################

## log-log accumulation (slow divergent series)
slow.Rout: slow.R
	$(run-R)

spline_knots.Rout: spline_knots.R
	$(makeR)

######################################################################

## Confused about polynomial regression from Rethinking

Ignore += kung.scsv
kung.scsv:
	curl -o $@ "https://raw.githubusercontent.com/rmcelreath/rethinking/master/data/Howell1.csv"

kung.Rout: kung.R kung.scsv
	$(makeR)

## pronouns.md

curve.Rout: curve.R

## Treasure problem from stack overflow
stack.Rout: stack.R
	$(makeR)

## HW degrees of freedom?
hwd.Rout: hwd.R
	$(makeR)

## Aberdeen diet
## aberdeen.md

## Exploring deconvolution

backproj.Rout: backproj.R
	$(makeR)

## shifts.md.voice: shifts.md voice.pl

######################################################################

## jax.md Notes about rendering

## Facebook birthday

Sources += facebook.md

######################################################################

## There is a lot of complexity here, and maybe I was spinning
## Basically things seem to always work online (no complexity needed)
## and never work offline (or at least not solved yet)
## Maybe 265號 was an edge case ☺
panmath = pandoc $< --mathjax=https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js?config=TeX-AMS_CHTML-full -s -o $@

## Urns problem

Ignore += urns.comb.md
## urns.comb.md: urns.md
## %.comb.md: %.md texcomb.pl
## $(PUSHRO)

Ignore += urns.check.tex
urns.check.tex: urns.comb.md
	$(pandocs)

Ignore += urns.pdf
urns.pdf: urns.comb.md
	$(pandocs)

## It is not clear what happened 2023 Feb 28 (Tue)
## Now working with explicit URL AND passing through tex
## But it's somehow losing the hyperlink
## urns.html: urns.md
urns.html: urns.check.tex
	$(panmath)

## panmath looks complicated, and this works as well?
## newurns.html: urns.md
newurns.html: urns.check.tex
	pandoc $< --mathjax -s -o $@

######################################################################

## Edit by hand ComplexFactoring.md from ComplexFactoring.wikitext

## Rename made files to use TEX, &c.
## ComplexFactoring.html: ComplexFactoring.md

Ignore += ComplexFactoring.tex
ComplexFactoring.tex: ComplexFactoring.md
	$(pandocs)

ComplexFactoring.html: ComplexFactoring.tex
	$(panmath)

## mathjax does not work at all this way for me (at least under jekyll)
## Making pdf this way _does_ work (and I did it accidentally), but probably the same or worse than making it directly from tex
ComplexFactoring.out.md: ComplexFactoring.tex
	$(panmath)

ComplexFactoring.pan.md: ComplexFactoring.tex
	$(pandocs)

######################################################################

## Still NOT working with direct path; use a .tex intermediary

## pantest.jax.html: pantest.md

######################################################################

## Scaling notes 2023 Mar 01 (Wed) #orthogonality

scaling.comb.jax.html: scaling.md makestuff/texcomb.pl 

######################################################################

## Incidence function notes from DAIDD 2022

# http://dushoff.github.io/notebook/outputs/incfuns.comb.jax.html
Ignore += incfuns.check.tex
incfuns.check.tex: incfuns.comb.md
	$(pandocs)

Ignore += incfuns.pdf
## incfuns.pdf: incfuns.md
incfuns.pdf: incfuns.comb.md
	$(pandocs)

## incfuns.comb.jax.html: incfuns.md

## incfuns.html: incfuns.md
incfuns.html: incfuns.check.tex
	pandoc $< --mathjax -s -o $@

incfuns.Rout: incfuns.R

######################################################################

## Sorting dates and times in a dumb way to explain how David Braley did that
locker.out: locker.pl
	$(PUSH)

## Dummy variables from Steve C.

dummy.Rout: dummy.R

## Craig Payne asked me for a pdf
Sources += close.pdf close.txt
close.pdf: close.txt
	## sleep 5
	pdfroff $< | cpdf -crop "0.9in 10.8in 1.8in 0.2in" -stdin -o $@ 

######################################################################

## Curve curve 

## test curving 2023

orCurve.Rout: orCurve.R

orCurve.mac.out: orCurve.mac
	maxima -b $< > $@

## Test curving 2020 online final was too hard.
## Not sure what I did here; I think just a simple OR adjustment (unlike the older wiki stuff)

test_curve.Rout: test_curve.R

Sources += $(wildcard *.mac)
Ignore += *.mac.out
curve.mac.out: curve.mac
	maxima -b $< > $@

logcurve.mac.out: logcurve.mac
	maxima -b $< > $@

######################################################################

## B117 exploration

Sources += DenmarkB.tsv
DenmarkB.Rout: DenmarkB.R DenmarkB.tsv
	$(pipeR)

DenmarkBfit.Rout: Bfit.R DenmarkB.rda
	$(pipeR)

DenmarkBpix.Rout: Bpix.R DenmarkBfit.rda
	$(pipeR)

######################################################################

## P values of t tests from an exponential distribution

pt.Rout: pt.R
	$(makeR)

ptt.Rout: ptt.R
	$(makeR)

sandbox.Rout: sandbox.R
	$(pipeR)

## Heterogeneous susceptibility notes

######################################################################

Sources += $(wildcard *.wikitext)

## This stuff is not working, even though weirder stuff seems to be …

## There is weird stuff below trying to get yaml stuff into md, since, um, something? It looks like there's just a perl script.

.PRECIOUS: %.wikitext.MD
%.wikitext.MD: %.wikitext wtrmd.pl
	$(PUSH)

.PRECIOUS: %.wt.md
%.wt.md: | %.wikitext.MD
	$(pcopy)

## powerPhenHet.wt.math.html: powerPhenHet.wt.md
%.math.html: %.md
	pandoc $< --mathjax -s -o $@

%.mj.html: %.rmd
	pandoc $< --mathjax -s -o $@

## make powerPhenHet.md
## powerPhenHet.wt.math.html: powerPhenHet.wt.md

## diff powerPhenHet.rmd powerPhenHet.wikitext.MD

######################################################################

## Wiki import dev deprecating? 2024 Aug 27 (Tue)

%.rmd: %.wikitext wtrmd.pl
	$(PUSH)

%.rmd.html: %.rmd
	pandoc $< --mathjax -s -o $@

## rmd ⇒ md pipeline; seems weird 2024 Aug 27 (Tue)
## ebolaRisk.rmd: ebolaRisk.wikitext wtrmd.pl
## nomogram.md: nomogram.rmd
## permBinom.md: permBinom.rmd
## permTables.md: permTables.wikitext; pandoc -f mediawiki -o $@ $<
## powerPhenHet.rmd: powerPhenHet.wikitext
## powerPhenHet.rmd.html: powerPhenHet.rmd
Ignore += *rmd_files

Ignore += $(wildcard rmd.md)
.PRECIOUS: %.rmd.md
%.rmd.md: %.rmd
	Rscript -e 'library("rmarkdown"); render("$<", output_format="md_document", output_file="$@")'

%.yaml.md: %.rmd
	perl -nE "last if /^$$/; print; END{say}" $< > $@

%.md: %.yaml.md %.rmd.md
	$(cat)

######################################################################

## Adjust mixing matrices using the balance trick of Busenberg and CCC
## This is an ALPHA version
## Not as stable as I would like, but this may require linear algebra to fix

mixpref.Rout: mixpref.R

## Try an RSA example -- NOT properly adjusted
Sources += rsa.tsv
rsapref.Rout: rsa.tsv mixpref.Rout rsapref.R

######################################################################

## COVID curves with Bolker

# flattening.Rout.pdf.gp:
## http://dushoff.github.io/notebook/git_push/flattening.Rout.pdf
flattening.Rout: flattening.R

######################################################################

## Packages for ICES and Earn
packages.Rout: packages.R

ningbo.Rout: ningbo.R

recursive_logs.Rout: recursive_logs.R

## Statistical foundations/philosophy

Sources += exponential_tails.md

exponential_tails.Rout: exponential_tails.R


######################################################################

StochasticModels_Lab1.Rout: StochasticModels_Lab1.R
## Crazy stats (error and conflation)
## Inspired by the tsetse

Ignore += tsetse
tsetse: dir=~/Dropbox
tsetse:
	$(alwayslinkdir)
tsetse_density.Rout: tsetse/deMeeus.csv tsetse_density.R
conflation.Rout: conflation.R
Sources += conflation.md
conflation_products: conflation.Rout-0.png.gp conflation.Rout-1.png.gp conflation.Rout.pdf.gp

######################################################################

## Levin sums

powerSum.Rout: powerSum.R

powerSum.out: powerSum.pl
	$(PUSH)

## Adler palindromes

alpal.Rout: alpal.R

######################################################################

## Bolker-style google sheet doodle poll
## I spent too much time on this, but did it wrong
## Dates and times should be unitary, so that it can calculate 
## when it's tomorrow somewhere
## Or else, just add an asterisk?
## That would be better for matching the current mixed line format

## See google spreadsheets (QMEE 2019, Theobio lab, searched for times of day)
## Current versions are called MacDoodle, so I can have my own schedule baked in
Ignore += doodle.csv
Sources += doodle.in
doodle.csv: doodle.in doodle.pl
	$(PUSH)

######################################################################

## EPL table insanity

premiere.Rout: premiere.R

imputation.Rout: imputation.R

ind_ricker.Rout: ind_ricker.R

## Baseball hit streaks (inefficient confirmation of easy algebra)
streak.Rout: streak.R

## And how does identical work?
identical.Rout: identical.R

Sources += $(wildcard *.mac)
Ignore += *.out
max = maxima < $< | tee $@

## Binomial random effects
## I don't know why I thought this integral was doable
randInt.out: randInt.mac
	$(max)

## What is a correlation matrix?
correlate.Rout: correlate.R rclean.pl
	R --vanilla < $< | perl -wf rclean.pl > $@

######################################################################

## Share on twitter or somewhere?
## Developed from Brent D.
## Moved here for Mike R.

## Not tested for pipeR
color_pix: colors.Rout-0.png.gp colors.Rout-0.small.png.gp colors.Rout-1.png.gp
colors.Rout: colors.R
	$(pipeR)
colors.Rout.png: colors.R
Ignore += colors.small.png
%.small.png: %.png
	convert -scale 10% $< $@

## Red-yellow-green recommendation? Green-yellow too similar! 
## ryg.Rout.html: ryg.R
ryg.Rout: ryg.R
	$(pipeR)

## Ramps etc from Roswell
## color_ramps.Rout.html: color_ramps.R
color_ramps.Rout: color_ramps.R
	$(pipeR)

## https://developer.r-project.org/Blog/public/2019/04/01/hcl-based-color-palettes-in-grdevices/

raw_ramps.Rout: raw_ramps.R
	$(pipeR)

## Restricted color perception
rcl_colors.Rout: rcl_colors.R

######################################################################

mattPredict.Rout: mattPredict.R

######################################################################

Sources += serosurvey.md covid.md

## Elisha and tsetse

Sources += are.md

######################################################################

## Is this whole section about dimension and Susan Holmes?

## Li's lambda
lambda.Rout: lambda.R
lampix.Rout: lambda.Rout lampix.R

## Magnificent mu
mu.Rout: mu.R
mupix.Rout: mu.Rout mupix.R

## What is dimension?
balls.Rout: balls.R

######################################################################

## Knitting (hybrid ideas brought together 2019 Jun 25 (Tue))

mre.html: mre.rmd
	$(knithtml)

mre.md: mre.rmd
	Rscript -e "knitr::knit('$<')"

mre.rmd.md: mre.md
	Rscript -e 'library("rmarkdown"); render("$<", output_format="md_document", output_file="$@")'

######################################################################

## ln -s ~/Dropbox/maya ##
Ignore += maya
## https://docs.google.com/spreadsheets/d/1qTYPV7PXb_5EVyG2SoxuAdlzXRfvJxgRUOwAgbYwS7s/edit#gid=581089094
## downcall maya/blood.xlsx ##
blood.Rout: maya/blood.xlsx blood.R

## BAILED on googlesheets package because it requires "publishing"
maya.Rout: maya.R

######################################################################

## mkdir MMEDaccounts ##
Ignore += MMEDaccounts

## downcall MMEDaccounts/2019.xlsx ##
mmed2019.Rout: MMEDaccounts/2019.xlsx MMEDaccounts.R
	$(run-R)

######################################################################

# Posts

# Posts are made from drafts as a side effect of making *.post
Sources += $(wildcard _posts/*.*)
Sources += post.pl

Ignore += *.post
## Linking stuff is broken!
## statstrength.post: 
%.post: %.post.md post.pl
	$(PUSH)
	$(shell_execute)
%.post.md: %.md
	perl -npe 's/layout:\s+page/layout: post/' $< > $@


######################################################################
## Statistical clarity NONE of this is up to date 2025 Jun 18 (Wed)
## Look in sandbox
Sources += statstrength.tsv $(wildcard *.desc.tsv)

statstrength.%.ggp.png: statstrength%.Rout ;
sspix: statstrength.clarity.ggp.png.op statstrength.classic.ggp.png.op statstrength.lakens.ggp.png.op
## statstrength.clarity.Rout: statstrength.R statstrength.tsv clarity.desc.tsv
## statstrength.classic.Rout: statstrength.R statstrength.tsv classic.desc.tsv
## statstrength.dichotomy.Rout: statstrength.R statstrength.tsv dichotomy.desc.tsv
## statstrength.lakens.Rout: statstrength.R statstrength.tsv lakens.desc.tsv
.PRECIOUS: statstrength.%.Rout
statstrength.%.Rout: statstrength.R statstrength.tsv %.desc.tsv
	$(pipeRcall)

######################################################################

## sucker bet

alice.Rout: alice.R

##################################################################

## Early Trapman-interval math. Should be subsumed by Park et al. MS
# http://localhost:4111/notebook/conditional_kernel.html
conditional_kernel.html: conditional_kernel.md

combinations.Rout: combinations.R

## This was a live-coding statistical sampling session; not sure why it was ever here or if I ever put it somewhere good.
vitaminA.Rout: vitaminA.R

## Unitary fractions game (with Gavin)
unitary.Rout: unitary.R
birthday.Rout: unitary.Rout birthday.R
fourunits.Rout: unitary.Rout fourunits.R

## A numeric check about volumes in a martini glass (a problem which confused me)
martini.Rout: martini.R

## Test a method for solving an Euler problem (didn't look at answer, just confirmed to make sure I was giving Walt good advice)
## pandigital fibs
pf.out: pf.pl
	$(PUSH)

######################################################################

alldirs += answer_match
Ignore += answer_match

######################################################################

gamma_shape.Rout: gamma_shape.R

# Log-plus-one as a scale
log1p.Rout: log1p.ssv log1p.R

Sources += walt.in
walt.out: walt.in walt.pl
	$(PUSH)

######################################################################

## checkplots and millipedes

Sources += checkplots.Rmd

####### Modularized diagnostic plots
checkFuns.Rout: checkFuns.R
	$(pipeR)

### Sets of fake data

lndata.Rout: lndata.R
gamdata.Rout: gamdata.R
tdata.Rout: tdata.R
cauchy.Rout: cauchy.R

## Stats on a list of lists of fake data (or something)

## gamdata.liststats.Rout: liststats.R
impmakeR += liststats
%.liststats.Rout: %.rds liststats.R
	$(pipeR)

## checkplot
## http://dushoff.github.io/notebook/git_push/lndata.listplots.Rout.pdf
## lndata.listplots.Rout: listplots.R
## gamdata.listplots.Rout: listplots.R
## tdata.listplots.Rout: listplots.R
## cauchy.listplots.Rout: listplots.R
impmakeR += listplots
%.listplots.Rout: %.liststats.rda checkFuns.rda listplots.R
	$(run-R)

## lndata.pianoPlots.Rout: pianoPlots.R
## gamdata.pianoPlots.Rout: pianoPlots.R
## tdata.pianoPlots.Rout: pianoPlots.R
## cauchy.pianoPlots.Rout: pianoPlots.R
%.pianoPlots.Rout: %.liststats.rda checkFuns.rda pianoPlots.R
	$(run-R)

## lndata.rangePlots.Rout: rangePlots.R
## tdata.rangePlots.Rout: rangePlots.R
%.rangePlots.Rout: checkFuns.rda %.liststats.rda rangePlots.R
	$(run-R)

## Slug plots are one type of range plot?
## lndata.slugPlots.Rout: slugPlots.R
## gamdata.slugPlots.Rout: slugPlots.R
## tdata.slugPlots.Rout: slugPlots.R
## cauchy.slugPlots.Rout: slugPlots.R
%.slugPlots.Rout: checkFuns.rda %.liststats.rda slugPlots.R
	$(run-R)

## What is this??
roswellCheck.Rout: roswellCheck.R

### How to do the binomial?

binom.Rout: checkFuns.rda binom.R

blaker.Rout: blaker.R

### The simplest example
freqPiano.Rout: freqPiano.R checkFuns.rda

######################################################################

## Try perm CIs; do the pianos come into play?

permCI.Rout: permCI.R

######################################################################

## Constrained quadratic
## Arising from rubella project

cq.Rout: cq.R

meeus.Rout: meeus.R

######################################################################

## materials and products are both deprecated for git_push; wonder if anything there matters
## Materials

allmd = $(wildcard *.md)
rmd = $(wildcard *.rmd)
rmdmd = $(rmd:rmd=md)

notmd += $(wildcard *.post.md *.yaml.md *.rmd.md) $(rmdmd)
sourcemd = $(filter-out $(notmd), $(allmd))

Sources += $(rmd) $(sourcemd) updates.html
Ignore += $(notmd)

# Sources += $(wildcard materials/*.*)
Sources += $(wildcard _drafts/*.md)

## Things made here that we want to be visible
# Sources += $(wildcard products/*.*)
products:
	mkdir $@

products/%: % products
	$(CP) $< $@

## sublime and excellent models
## sublime.md
## sublime.Rout: sublime.R

Sources += sublime.in
sublime.out: sublime.in sublime.pl
	$(PUSH)


######################################################################

# Scripts

## AoC Monster messages.
Sources += *monster.in
monster.out: monster.in monster.pl
	$(PUSH)

waltmonster.out: waltmonster.in monster.pl
	$(PUSH)

Sources += $(wildcard *.R *.pl)

filledCircle.Rout: filledCircle.R

pythagoras.Rout: pythagoras.R
newpyth.Rout: newpyth.R
	$(pipeR)

rp.newpyth.Rout: rp.R newpyth.rda
	$(pipeR)

cards.Rout: cards.R

logistic.Rout: logistic.R

17.html: 17.md

19.html: 19.md

nmds_comp.Rout: nmds_comp.R

islr_boot.Rout: islr_boot.R

# Ongoing
moments.html: moments.md
moments.Rout: moments.R

## severity.md:

######################################################################

# http://localhost:4111/notebook/diversity.html: diversity.md

## Branch text, hopefully for a manuscript
rarity.html: rarity.md

## Playing with Simpson
simpson.Rout: simpson.R
checkplot.Rout: checkplot.R

## Shannon samples
## Terrible scattershot approach; not sure this will ever work
## Idea was to come up with an formula for expected sample Shannon diversity
## to make better fake diversity communities
shannon.Rout: shannon.R

######################################################################

# Developing
sir.Rout: sir.R
tmp.Rout: tmp.R
lecture.Rout: lecture.R

# Simple fitting of growing-epidemic data (Chowell, Bernardin)
genFit.md:
genFit.Rout: genFit.R

##################################################################

## Testing

flog:
	sleep 5
	make deriv.Rout

deriv.Rout: deriv.R

### Rec math (other stuff?)

elves.out: elves.pl
	$(PUSH)
elves.html: elves.md

## Batting averages
	average.md:
Ignore += average.out
average.out: average.pl
	$(PUSH)

average.Rout: average.R average.out

### Hmm. this all seems a bunch of nonsense. Understand (document?) before trying to hack.
Ignore += era.out
era.out: era.pl
	$(PUSH)
era.Rout: era.out era.R

## Fractions
fractions.Rout: fractions.R

##################################################################

## MRE about R craziness

## Can't reproduce which.max craziness from 3SS!
which.Rout: which.R

##################################################################

# Blogging
## CP raw html suppresses mathjax (somehow)
## CP rendered html doubles mathjax (fix by hand?)
## Blogger is just absolutely fricking crazy about <p>, <br> and <div> tags. No easy fix for this, either.

# Maybe just give up on blogger…

## pythagoras.cp.html: cp.pl
%.cp.html: _site/%.html cp.pl
	$(PUSH)

######################################################################

## Studying imputation

## Learn about MICE

mice.Rout: mice.R

Sources += mice.md

######################################################################

## A probably stupid attempt to process information about airline movies
## Actually, could be useful for taking a list of movies to look up on rt and not worrying so much about Air Canada nonsense.
## Could modularize AC parsing and RT linking. In theory.
## … interrupted in the middle to do work

# http://localhost:4111/notebook/ac.html
## ac.md: ac.dump rotten.pl; $(PUSH)

# Images

# Things we want pushed and referred to
LocalImages = $(ImageTargets:%=images/%)
Sources += $(LocalImages)
$(LocalImages): images/%: %
	$(copy)

# Aesthetics

# Notebook picture
Sources += notebook.jpg
banner.jpg: notebook.jpg
	convert $< -crop 4096x1600+0+350 $@

# Jekyll

not:
	$(RMF) about.md feed.xml

## Using underscore because we don't want to track .lock file
Sources += _config.yml $(wildcard Gemfile_*)
Sources += _includes/* _layouts/* css/* _sass/*

Ignore += .sass-cache/ Gemfile Gemfile.lock _site/

## Gemfile.sb:
Gemfile.%:
	/bin/ln -s Gemfile_$* Gemfile

######################################################################

### Makestuff

Sources += Makefile

Ignore += makestuff
msrepo = https://github.com/dushoff
Makefile: makestuff/Makefile
makestuff/Makefile:
	git clone $(msrepo)/makestuff
	ls $@

-include makestuff/os.mk
-include makestuff/git.mk
-include makestuff/visual.mk
-include makestuff/pipeR.mk
-include makestuff/texi.mk
-include makestuff/pandoc.mk
-include makestuff/pdfpages.mk
-include makestuff/forms.mk
