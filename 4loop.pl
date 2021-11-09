use strict;
use 5.10.0;

sub ss{
	my($x, $b) = (@_);
	return int($x/$b)**2 + ($x%$b)**2;
}

sub ssloop{
	my %vals;
	my $ct = 0;
	my($x0, $b) = (@_);
	my $x = $x0;
	while (!defined $vals{$x}){
		## say $x;
		$vals{$x} = $ct;
		$x = ss($x, $b);
		last if $x >= $b**2;
		$ct++;
	}
	return $ct if $x == $x0;
	return "inf" if $x >= $b**2; 
	return 0;
}

for my $i (100..9999){
	say "$i " . ssloop($i, 100);
}

for my $i (10..99){
	say "$i " . ssloop($i, 10);
}
