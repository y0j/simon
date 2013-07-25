#!/usr/bin/perl 

use strict;

while ( my $out_status = <>) {
	  $out_status =~ s/<[^>]*>/\ /g;
	  print $out_status;
  }	  
