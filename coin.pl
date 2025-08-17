use strict;
use 5.10.0;

my $tot = 0;
my $curr = 0;
my $x = 1504170715041707;
my $y=4503599627370517;
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

my $not=0;
while($x){
	$not += $x;
	my $tmp = -$y % $x;
	$y = $x;
	$x = $tmp;
}
say $not;

my $miriam = 1504170715041707;
say $miriam;
# 1504170715041707 4503599627370517.
