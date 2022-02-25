while(<>){
	chomp;
	next unless /%i/;
	s/\S*\s*//;
	print "$_\n";
}
