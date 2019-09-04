#!/usr/bin/env perl

use 5.016;
use warnings;
use strict;
use Getopt::Long qw(:config no_ignore_case bundling);
use List::MoreUtils qw(uniq);
use Data::Dumper;
my %fields = ("d"=> "\t");
GetOptions ( \%fields, "f=s", "d=s" , "s");
my @num =map {$_-1} sort {$a <=> $b} uniq split ",", $fields{"f"} if ($fields{"f"});
while (my $l = <>){
	chomp $l;
	my @arr = split "$fields{'d'}", $l;
	if ( $fields{'s'} and scalar @arr < 2){
		next;
	}
	if (defined $fields{'f'} and scalar @arr != 1){
		say join $fields{"d"}, grep /.+/, map { $arr[$_] } @num;
	}else{
		say $l;
	}
} 

