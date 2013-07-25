#! /usr/bin/perl -w

use strict;

my $parse_begin = 0;
my %domains;
while (<STDIN>) {
 	$parse_begin = 1 if (/<table border=0><tr><th>Srv<th>PID/);
 	next unless ($parse_begin);

	if (/<td>(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})<td nowrap>(.*)<td nowrap>(.*)<\/tr>/) {
		$domains{"$5"} = 0 unless(defined($domains{"$5"}));
		$domains{"$5"}++;
	}
}

my @domains = sort { $domains{$b} <=> $domains{$a} } keys %domains;

for (@domains) {
	print "$_\t***\t$domains{$_}\n";
}
