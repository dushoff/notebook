---
layout: page
title: Overview
---

This is a publicly readable site, but not really intended for the public. It is by and for Jonathan Dushoff, and is intended to get me to write up notes in a nice form. It is modelled loosely on Carl Boettiger's lab notebook.

# Updates (newest at top)
<!-- # [Updates](updates.html) -->

<ul class="post-list">
	{% for post in site.posts limit:4 %}
		<li>
			<span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}: </span>
				<a class="post-mini" href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
		</li>
	{% endfor %}
</ul>

# [Older updates](updates.html)

# In progress (stuff I hope I'm working on)

* [Generalized-exponential fitting](genFit.html)
* [moments](moments.html)
* [Quantile-based distributions](qbd.html)
* [Pools and memory](pools.html)
* [Conditional kernels](conditional_kernel.html)

# Planned (stuff I'd like to be working on)

* New DHS
