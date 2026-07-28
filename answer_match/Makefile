
## This is answerMatch, a misplaced set of test-comparison tools

current: target
-include target.mk

# -include makestuff/perl.def

######################################################################

# Content

vim_session:
	bash -ic "vmt"

######################################################################

Sources += $(wildcard *.R) anonymous.csv

check.Rout: read.Rout check.R
compare.Rout: read.Rout compare.R
	$(run-R)
cplot.Rout: compare.Rout cplot.R
id.Rout: idfuns.Rout compare.Rout id.R
	$(run-R)
read.Rout: anonymous.csv read.R
	$(run-R)

######################################################################

### Makestuff

Sources += Makefile

## Sources += content.mk
## include content.mk

Ignore += makestuff
msrepo = https://github.com/dushoff
Makefile: makestuff/Makefile
makestuff/Makefile:
	ln -s ../makestuff .
	ls $@

-include makestuff/os.mk

-include makestuff/wrapR.mk
-include makestuff/rmd.mk

-include makestuff/git.mk
-include makestuff/visual.mk
-include makestuff/projdir.mk
