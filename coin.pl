use strict;
use 5.10.0;
use integer;
use bignum;

my $tot = 0;
my $curr = 0;
my $x = 1504170715041707;
my $y=4503599627370517;

my $not=0;
my $a=$x;
my $b=$y;
while($a){
	say $a;
	$not += $a;
	my $tmp = -$b % $a;
	$b = $a;
	$a = $tmp;
}
say $not;

exit(0) if $y >= 1e7;

my $best=$y;
while($best){
	$curr += $x;
	$curr -= $y if $curr>=$y;
	if ($curr<$best){
		$tot += $curr;
		$best = $curr;
		# say($curr);
	}
}
say $tot;

