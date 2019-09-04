#!/usr/bin/env perl

use 5.016;
no warnings;
my @parameters=@ARGV;
my $colomn=0;
for my $i (0..$#parameters){
	if ($parameters[$i] eq "-k"){
		$colomn=$parameters[$i+1];
		splice(@parameters,$i+1,1);
	}
}
my @rray=(<STDIN>);

sub r{
	my @sorted= reverse sort {$a cmp $b} @_;
	for my $i (@sorted){
		print "$i";
	}		
}
sub n{
	my @sorted= sort {$a <=> $b} @_;
	for my $i (@sorted){
		print "$i";
	}
}
sub rn{
	my @sorted= reverse sort {$a <=> $b} @_;
	for my $i (@sorted){
		print "$i";
	}
}
sub u{
	for (my $k=0;$k<scalar(@_);$k++){
		for (my $p=$k+1;$p<scalar(@_);$p++){
			if (not ($_[$k] cmp $_[$p])){
				splice(@_,$p,1);
			}
		}
	}
	return @_;
}
sub knr{
	my $k = pop;
	my @arr;
	for my $i (@_){
		my @buf_arr=split(" ",$i);
		push @arr, \@buf_arr;
	}
	for (my $i=scalar(@arr);$i>0;$i--){
		for (my $j=0;$j<$i;$j++){
			if (${$arr[$j]}[$k] < ${$arr[$j+1]}[$k]){
				($arr[$j],$arr[$j+1])=($arr[$j+1],$arr[$j]);
			}
		}
	}
	my $var;
	for my $i (0..$#arr){
		for my $j (@{$arr[$i]}){
			$j.=" ";
			$var.=$j;
		}
		@arr[$i]=$var;
		$var="";
	}
	for my $i (@arr){
		print "$i \n";
	}
}
sub kn{
	my $k = pop;
	my @arr;
	for my $i (@_){
		my @buf_arr=split(" ",$i);
		push @arr, \@buf_arr;
	}
	
	for (my $i=scalar(@arr);$i>0;$i--){
		for (my $j=0;$j<$i;$j++){
			if (scalar(${$arr[$j]}[$k]) > scalar(${$arr[$j+1]}[$k])){
				($arr[$j],$arr[$j+1])=($arr[$j+1],$arr[$j]);
			}
		}
	}
	my $var;
	for my $i (0..$#arr){
		for my $j (@{$arr[$i]}){
			$j.=" ";
			$var.=$j;
		}
		@arr[$i]=$var;
		$var="";
	}
	for my $i (@arr){
		print "$i \n";
	}
}
sub k{
	my $k = pop;
	my @arr;
	for my $i (@_){
		my @buf_arr=split(" ",$i);
		push @arr, \@buf_arr;
	}
	for (my $i=scalar(@arr);$i>0;$i--){
		for (my $j=0;$j<$i;$j++){
			if (${$arr[$j]}[$k] gt ${$arr[$j+1]}[$k]){
				($arr[$j],$arr[$j+1])=($arr[$j+1],$arr[$j]);
			}
		}
	}
	my $var;
	for my $i (0..$#arr){
		for my $j (@{$arr[$i]}){
			$j.=" ";
			$var.=$j;
		}
		@arr[$i]=$var;
		$var="";
	}
	for my $i (@arr){
		print "$i \n";
	}
}
sub kr{
	my $k = pop;
	my @arr;
	for my $i (@_){
		my @buf_arr=split(" ",$i);
		push @arr, \@buf_arr;
	}
	for (my $i=scalar(@arr);$i>0;$i--){
		for (my $j=0;$j<$i;$j++){
			if (${$arr[$j]}[$k] gt ${$arr[$j+1]}[$k]){
				($arr[$j],$arr[$j+1])=($arr[$j+1],$arr[$j]);
			}
		}
	}
	my $var;
	for my $i (0..$#arr){
		for my $j (@{$arr[$i]}){
			$j.=" ";
			$var.=$j;
		}
		@arr[$i]=$var;
		$var="";
	}
	for my $i (@arr){
		print "$i \n";
	}
}
my $r=0;
my $n=0;
my $u=0;
my $k=0;
for my $p (@parameters){
	if ($p eq "-r")		{$r=1}
	elsif ($p eq "-n")	{$n=1}
	elsif ($p eq "-u")	{$u=1}
	elsif ($p eq "-k")	{$k=1}
	else			{die "incorret parameters"}
}
if ($u==1){
	@rray=u(@rray);
}
if ($n==1){
	if ($r==1){
		if ($k==1){
			@rray=knr(@rray,$colomn);
		}
		else{
			@rray=rn(@rray);
		}
	}
	else{
		if ($k==1){
			@rray=kn(@rray,$colomn);
		}
		else{
			@rray=n(@rray);
		}
	}
}
else{
	if ($r==1){
		if ($k==1){
			@rray=kr(@rray,$colomn);
		}
		else{
			@rray=r(@rray);
		}
	}
	else{
		if ($k==1){
			@rray=k(@rray,$colomn);
		}
		else{
			for my $i (@rray){
				print "$i \n";
			}
		}
	}
}


	

	

