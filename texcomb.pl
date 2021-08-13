use 5.10.1;
use strict;

while(<>){
	chomp;
	s/\(([^\s)]*)\)\bC\b\(([^\s)]*)\)/{$1 \\choose $2}/g;
	s|/([^/]*)//([^/]*)/|\\frac{$1}{$2}|g;
	say;
}
