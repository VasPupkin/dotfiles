#!/usr/bin/env perl

use warnings;
use strict;
use HTML::TokeParser;

my $p = HTML::TokeParser->new( shift ) || die;

while ( my $tag = $p->get_tag( 'a' ) ) { 
    printf qq|%s %s\n|, $p->get_text, $tag->[1]{href};
}
