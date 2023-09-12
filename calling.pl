use strict;
use 5.10.0;

undef $/;

my $dummy = "1Mchoice";
my $f = <>;

my @ss = qw(front back left right);

my $sec = $ss[rand @ss];

$f =~ s/$dummy/$sec/;

say $f;
