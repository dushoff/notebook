use strict;
use 5.10.0;

## Print the yaml header (if any) undisturbed
while(<>){
	print;
	last if /^$/;
}

## Treat lines as ¶s
while(<>){
	next if /^$/;
	s/\.([A-Z])/. $1/g;
	s/,([a-z])/, $1/g;
	s/  +/ /g;
	s/Corey/Cori/g;
	s/Wally/Wallinga/g;
	s/inspector/infector/;
	s/victim/infectee/;
	s/cereal/serial/;
	say;
}
