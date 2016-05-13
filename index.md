---
layout: page
title: Overview
---

[Current entry (probably in progress)](current.html)

This is a publicly readable (but not public) site. It is by and for Jonathan Dushoff. It is modelled loosely on Carl Boettiger's lab notebook, and is intended to get me to write up notes in a nice form. I might share links to individual pages from here, but the general idea will be to ship things out to a more public site.

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

# In progress (stuff I hope I'm working on)

* [moments](moments.html)