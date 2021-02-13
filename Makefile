# notebook (gh-pages branch, which is the only one I use)
# http://localhost:4111/notebook/17.html
# http://localhost:4111/notebook/pronouns.html
# http://localhost:4111/notebook/shifts.html
# http://localhost:4111/notebook/hwd.R

# http://dushoff.github.io/notebook/pronouns.html
# http://tinyurl.com/they-them-he-him
# http://dushoff.github.io/notebook/shifts.html
# http://dushoff.github.io/notebook/average.Rout
# http://dushoff.github.io/notebook/outputs/DenmarkBpix.Rout.pdf
# make serve ## jekyll.log ##

## Suppress pandoc (don't want to pandoc here, we want to make serve instead)

## URL problem:
## Use relative pathnames for plain pages; /notebook/ for posts.
## Move on!

### Hooks for the editor to set the default target
current: target
-include target.mk

-include makestuff/perl.def

######################################################################

Sources += $(wildcard *.bc)

## Long excellent numbers

## 9999999: 3 3 239 4649
## 10000001: 11 909091
## (158730)[k]16(126984)[k]128
## e1.out: e1.bc
## e2.out: e2.bc
%.out: %.bc
	bc -l < $< > $@

######################################################################

VoC.Rout: VoC.R
	$(makeR)

VoC.pdf: VoC.R
	$(rmdpdfBang)

Ignore += VoCsimple.pdf
VoCsimple.Rout: vOcsimple.R
	$(pipeR)
VoCsimple.pdf: VoCsimple.R
	$(rmdpdfBang)

VoCinfer.Rout: VoCinfer.R orphan code to solve implied PHE rR

## 2020 Dec 30 (Wed) In flux: try to DRY 
## FIXME: this behaves suspiciously when r is very small
VoCcomp.Rout: VoCcomp.R
	$(pipeR)
VoCcomp.Rout-1.pdf:

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

## Test curving 2020 online final was too hard.
## Not sure what I did here; I think just a simple OR adjustment (unlike the older wiki stuff)

test_curve.Rout: test_curve.R

Sources += curve.mac
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

Sources += hetSusc.wikitext
## This is bad because it escapes all the math
%.md: %.wikitext
	pandoc -f mediawiki -t ghm -o $@ $< 

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

color_pix: colors.Rout-0.png.gp colors.Rout-0.small.png.gp colors.Rout-1.png.gp
colors.Rout: colors.R
colors.Rout.png: colors.R
Ignore += colors.small.png
%.small.png: %.png
	convert -scale 10% $< $@

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

mre.md: mre.rmd
	Rscript -e "knitr::knit('$<')"

mre.rmd.md: mre.md
	Rscript -e 'library("rmarkdown"); render("$<", output_format="md_document", output_file="$@")'

## Wiki import dev

%.rmd: %.wikitext wtrmd.pl
	$(PUSH)

## rmd ⇒ md pipeline

## ebolaRisk.rmd: ebolaRisk.wikitext wtrmd.pl
## nomogram.md: nomogram.rmd
## permBinom.md: permBinom.rmd
## permTables.md: permTables.wikitext; pandoc -f mediawiki -o $@ $<

Ignore += *rmd_files

%.rmd.md: %.rmd
	Rscript -e 'library("rmarkdown"); render("$<", output_format="md_document", output_file="$@")'

%.yaml.md: %.rmd
	perl -nE "last if /^$$/; print; END{say}" $< > $@

%.md: %.yaml.md %.rmd.md
	$(cat)

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
## covid.post: 
%.post: %.post.md post.pl
	$(PUSH)
	$(shell_execute)
%.post.md: %.md
	perl -npe 's/layout:\s+page/layout: post/' $< > $@

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

## It seems impossible that this was ever useful
quiz.Rout: quiz.R

## Test a method for solving an Euler problem (didn't look at answer, just confirmed to make sure I was giving Walt good advice)
## pandigital fibs
pf.out: pf.pl
	$(PUSH)

######################################################################

alldirs += answer_match
Ignore += answer_match

######################################################################

## Testing the RData pipeline??
## Answer: you need better documentation
## Also: RData is generally hidden in wrapR, since it's meant to be called indirectly
runmake = TRUE
wrap.Rout: wrap.R
unwrap.Rout: wrap.Rout unwrap.R

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
## checkFuns.R ##

### Sets of fake data

lndata.Rout: lndata.R
gamdata.Rout: gamdata.R
tdata.Rout: tdata.R
cauchy.Rout: cauchy.R

## Stats on a list of lists of fake data (or something)

## GrandMean is here, and is bad.
lndata.liststats.Rout:
%.liststats.Rout: %.Rout liststats.R
	$(run-R)

## checkplot
## http://dushoff.github.io/notebook/git_push/lndata.listplots.Rout.pdf
## lndata.listplots.Rout: listplots.R
## gamdata.listplots.Rout: listplots.R
## tdata.listplots.Rout: listplots.R
## cauchy.listplots.Rout: listplots.R
%.listplots.Rout: %.liststats.Rout checkFuns.Rout listplots.R
	$(run-R)

## lndata.pianoPlots.Rout: pianoPlots.R
## gamdata.pianoPlots.Rout: pianoPlots.R
## tdata.pianoPlots.Rout: pianoPlots.R
## cauchy.pianoPlots.Rout: pianoPlots.R
%.pianoPlots.Rout: %.liststats.Rout checkFuns.Rout pianoPlots.R
	$(run-R)

## tdata.rangePlots.Rout: rangePlots.R
%.rangePlots.Rout: checkFuns.Rout %.liststats.Rout rangePlots.R
	$(run-R)

## lndata.slugPlots.Rout: slugPlots.R
## gamdata.slugPlots.Rout: slugPlots.R
## tdata.slugPlots.Rout: slugPlots.R
## cauchy.slugPlots.Rout: slugPlots.R
%.slugPlots.Rout: checkFuns.Rout %.liststats.Rout slugPlots.R
	$(run-R)

## tdata.rangePlots.Rout: rangePlots.R
%.rangePlots.Rout: %.liststats.Rout checkFuns.Rout rangePlots.R
	$(run-R)

## What is this??
roswellCheck.Rout: roswellCheck.R

### How to do the binomial?

binom.Rout: checkFuns.Rout binom.R

blaker.Rout: blaker.R

### The simplest example
freqPiano.Rout: checkFuns.Rout freqPiano.R

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

## Boot camp

## mkdir boot ##
## downcall boot/ ##
Ignore += $(wildcard boot/*)

############## simple incidence -- bailed for time (and dis-modularity of old work flow)
incidence.Rout: boot/inc01.xls fitting_code/routines.Rout incidence.R
	$(run-R)

pardirs += fitting_code

Ignore += $(pardirs)

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
Ignore += rarity.html
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
average.Rout: average.out average.R

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

Ignore += *.cp.html
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

Gemfile:
	/bin/ln -s Gemfile_sb $@

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
-include makestuff/projdir.mk
-include makestuff/pipeR.mk
-include makestuff/pandoc.mk
-include makestuff/forms.mk
