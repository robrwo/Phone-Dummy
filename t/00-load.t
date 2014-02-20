#!perl -T

use strict;
use warnings;

use Test::More 0.61 tests => 2;

BEGIN {
    use_ok( 'Phone::Fake' ) || print "Bail out!
";
}

diag( "Testing Phone::Fake $Phone::Fake::VERSION, Perl $], $^X" );

my $x = rand_phone( country => 'US', country_code => 1,  );

ok($x);

diag($x);
