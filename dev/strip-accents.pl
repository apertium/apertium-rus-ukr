#!/usr/bin/perl

use warnings;
use strict;

while (<>) 
{
	s/и́/и/g;
	s/у́/у/g;
	s/а́/а/g;
	s/о́/о/g;
	s/я́/я/g;
	# Ukrainian
	s/і́/і/g;

	print;
}
