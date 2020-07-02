use strict;
use 5.10.0;

my %slots;
foreach my $day (qw(Mon Tue Wed Thu Fri)){
	foreach my $hour (1..5, 9..12){
		foreach my $minute (qw(00 15 30 45)){
			$slots{"$day $hour:$minute"} = 0;
		}
	}
}

say join "\n", sort keys %slots;
