#!/usr/bin/env perl

use 5.016;
use warnings;
use Getopt::Long qw(:config no_ignore_case bundling);
my ($after, $before, $context, $count, $ignore, $invert, $fixed, $line);
my $num = 0;
GetOptions (		'A=n' => \$after,
			'B=n' => \$before,
			'C=n' => \$context, 
			'c' => \$count,
			'i' => \$ignore,
			'v' => \$invert,
			'F' => \$fixed, 
			'n' => \$line
 );

my ($substr) = @ARGV;

my $str;
my @list = map {
	my @v = split /\s+/, $_;
	@v == 1 ? $v[0] : \@v;
} grep { chomp; /\S/ } <>;

$substr = quotemeta $substr if (defined $fixed);
$substr = fc ($substr), map { $_ = fc ($_) } @list if (defined $ignore);
$invert //= 0;

for (my $i=0; $i < scalar @list; $i++){
    if ($list[$i] =~ /($substr)/ != $invert){
        $num++;
		next if defined $count;
		if(defined $context) {
      		B ($i, $context, $line, @list);
      		printer($i); ;
      		A ($i, $context, $line, @list);
    	}
		else {
       		if (defined $before) {
    			B ($i, $before, $line, @list);
    			$after // printer($i);
    		} 
    		if (defined $after){
    			printer($i);
      			A ($i, $after, $line, @list);
			}
			else {
      			printer($i);;
      		}
    	}
	}
}
print "$num\n" if (defined $count);

sub printer{
	my ($i) = shift;
	$line ? print "$i:$list[$i]\n" : print "$list[$i]\n";
}

sub A {
	my ($local, $edge, @text) = @_;
	my $limit = $local + $edge;
	my $end = $limit < $#text ? $limit : $#text - 1;
	for (my $i = $local + 1;$i < $end; $i++) {
    	printer($i);
	}
}



sub B {
	my ($local, $edge, @text) = @_;
	my $limit = $local - $edge;
	my $start = $limit > 0 ? $limit : 0;
	for (my $i = $start; $i < $local - 1; $i++) {
	    printer($i);
	}
}


