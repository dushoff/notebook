use strict;
use 5.10.0;

my $base=100;
my $mult=27;
my $max=27;
my $gcf=3;
my @first;

sub tree{
	my $num = shift @_;
	my @low = @{shift @_};
	my @high = @{shift @_};
	my @mid = ($low[0]+$high[0], $low[1]+$high[1]);
	$mid[2] = int($mult*$base*$mid[0]/$mid[1] + 1/2);
	$first[$mid[2]] = $mid[1] unless defined $first[$mid[2]];
	# return if $num >=$nmax;
	tree($num+1, \@low, \@mid) unless $mid[2]-$low[2]<=1;
	tree($num+1, \@mid, \@high) unless $high[2]-$mid[2]<=1;
}

$first[0] = $first[$max*$base] = 1;
tree(0, [0, 1, 0], [$max/$gcf, $mult/$gcf, $max*$base]); 

for my $i (0..$#first){
	say $i/$base . " $first[$i]";
}
