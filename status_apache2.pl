#!/usr/bin/perl 

#use strict;

my $parse_begin = 0;
my %domains;
while (<STDIN>) {
    $parse_begin = 1 if (/<table border="0"><tr><th>Srv<\/th><th>PID/);
    next unless ($parse_begin);

    if (/<\/td><td>(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})<\/td><td nowrap>(.*)<td nowrap>(.*)<\/td><\/tr>/) {
       $domains{"$5"} = 0 unless(defined($domains{"$5"}));
       $domains{"$5"}++;
    }
}

my @domains = sort { $domains{$b} <=> $domains{$a} } keys %domains;

for (@domains) {
    print "$_\t***\t$domains{$_}\n";
}
