#!/usr/bin/perl 

use strict;
my $out_status

while ($out_status = <>) {
    $out_status =~ s/<[^>]*>/\ /g;
	print $out_status;
} 
