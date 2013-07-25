#!/usr/bin/perl -w

use strict;

my $parse_begin = 0;
my %domains;
while (<STDIN>) {
        #$parse_begin = 1 if (/<table border=0><tr><th>Srv<th>PID/);
        $parse_begin = 1 if (/<table bgcolor="#ffffff" border="0"/);
        next unless ($parse_begin);

        if (/<td nowrap><font (.*)>(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})<\/font><td nowrap><font (.*)>(.*)<\/font><td nowrap>(.*)<\/tr>/) {
                $domains{"$7"} = 0 unless(defined($domains{"$7"}));
                $domains{"$7"}++;
        }
}

my @domains = sort { $domains{$b} <=> $domains{$a} } keys %domains;

for (@domains) {
        print "$_\t***\t$domains{$_}\n";
}

