
while (<>){
	print if s/.d([)]*)$/$1/;
}
