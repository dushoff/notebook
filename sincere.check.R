
jonathan <- as.vector(unlist(read.table("sincere_jd.txt")))
fred <- as.vector(unlist(read.table("sincere_fra.txt")))

match(fred,jonathan)
match(jonathan,fred)
intersect(fred,jonathan)

