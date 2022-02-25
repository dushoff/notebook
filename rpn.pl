use strict;
use 5.10.0;
use Scalar::Util qw(looks_like_number);

sub op{
	my ($b, $a, $op) = @_;
	return($a*$b) if $op eq "*";
	return($a+$b) if $op eq "+";
	return($a-$b) if $op eq "-";
	return($a/$b) if $op eq "/";
	return("unknown op")
}

sub rpn{
	my $inp = shift @_;
	my @stack = @{shift @_};
	return join " :: ", @stack unless $inp;
	my $item = substr($inp, 0, 1);
	if ( looks_like_number($item)){
		push @stack, $item;
	} else {
		push @stack, op(pop @stack, pop @stack, $item);
	}
	return rpn(substr($inp, 1), \@stack);
}

say rpn("637*4+-", []);
