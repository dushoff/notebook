while(<>){
	chomp;
	next unless /%i/;
	s/\S*\s*//;
	next unless $_;
	s/\*\*/^/g;
	print "$_\n";

	## Get rid of double exponentials in a very naive way.
	## next if /[*]{2}.[)][*]{2}/;
}
