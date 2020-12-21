use strict;
use 5.10.0;

my %rule;

sub matchstring{
	my ($n, $s) = @_;
	die ("No rule for $n") unless defined (my $r = ${rule}{$n});
	return "no" unless $s;

	if ($r =~ /[a-z]/){
		return "no" unless $s =~ s/^$r//;
		return $s
	}

	my $sum=0;
	foreach my $branch (split /[|]/, $r){
		$branch =~ s/\s*//;
		foreach my $step (split /\s+/, $branch){
			say "matchstring $step, $s";
			$s = matchstring($step, $s) unless $s eq "no"; 
			say $s;
			return "" if $s eq "";
		}
		return "no"
	}
}

while (<>){
	chomp;
	last if /^$/;
	my ($n, $r) = split /:\s*/;
	$r =~ s/"//g;
	$rule{$n} = $r;
}

while(<>){
	chomp;
	say "Read $_";
	say "Output: " . matchstring(0, $_)
}
