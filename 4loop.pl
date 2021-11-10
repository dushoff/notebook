use strict;
use 5.10.0;

sub ss{
	my($x, $b) = (@_);
	my $tot = 0;
	while($x > 0){
		$tot +=  ($x%$b)**2;
		$x = int($x/$b);
	}
	return $tot;
}

sub ssloop{
	my %vals;
	my $ct = 0;
	my($x0, $b) = (@_);
	my $x = $x0;
	my $top = $b**4;
	while (!defined $vals{$x}){
		## say $x;
		$vals{$x} = $ct;
		$x = ss($x, $b);
		last if $x >= $top;
		$ct++;
	}
	$ct = -$x unless $x == $x0;
	return $ct;
}

for my $i (1..19999){
	my $ss = ssloop($i, 100);
	say "$i $ss" if $ss;
}

say "Two digits";

for my $i (1..200){
	my $ss = ssloop($i, 10);
	say "$i $ss" if $ss;
}
