use strict;
use 5.10.0;

my %rule;
while (<>){
	my ($n, $r) = split /:\s*/;
	$rule{$n} = $r;
}

sub numstring{
	my ($n) = @_;
	die ("No rule for $n") unless defined (my $r = ${rule}{$n});
	return 1 if $r =~ /".*"/;

	my $sum=0;
	foreach my $branch (split /[|]/, $r){
		$branch =~ s/\s*//;
		my $prod=1;
		foreach my $step (split /\s+/, $branch){
			$prod *= numstring($step);
		}
		$sum += $prod;
	}
	return $sum;
}

say numstring(0);
