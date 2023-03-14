
If you use a jekyll layout then md will be automatically converted to html. The syntax here is apparently $$ to open and close any math, with displaystyle being context-dependent in the obvious way.

Not sure if it is ever better to do a fancier version using the .jax.html pipeline, which seems to also kind of work. The styles are inconsistent: inline equations won't work right unless the have the specific number of dollar signs for the approach.

The .jax approach also does not inherit the jekyll styling ...

There are some notes from Bolker about jax that I should definitely add here.

Resolve self-contained vs. mathjax conflict
* https://ms.mcmaster.ca/~bolker/misc/pandoc_diffs.html

Embedding images etc. while getting mathjax resources from the web ??
* https://github.com/jgm/pandoc/issues/682

Local mathjax? 
* https://stackoverflow.com/questions/48867501/mathjax-offline-for-web-view

