## Based on an unsolvable challenge from Fred
use strict;
use 5.10.0;
use List::Util qw(sum);

my $best = 0;
my $biggest = 0;
for my $j (100..1000){
	my @j = map($_ = $_*$_, split //, $j*$j);
	my $diff = sum(@j) - $j;
	$best = $diff if $diff>$best;
}

say $best;
