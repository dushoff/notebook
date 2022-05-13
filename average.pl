my $base=1000;
my @N;

sub tree{
   my $num = shift @_;
   my @low = @{shift @_};
   my @high = @{shift @_};
   my @mid = ($low[0]+$high[0], $low[1]+$high[1]);
   $mid[2] = int($base*$mid[0]/$mid[1] + 1/2);
   $N[$mid[2]] = $mid[1] unless defined $N[$mid[2]];
   # return if $num >=$nmax;
   tree($num+1, \@low, \@mid) unless $mid[2]-$low[2]<=1;
   tree($num+1, \@mid, \@high) unless $high[2]-$mid[2]<=1;
}

$N[0] = $N[$base] = 1;
tree(0, [0, 1, 0], [1, 1, $base]); 

for my $n (0..$#N){
   print "$n $N[$n]\n";
}
