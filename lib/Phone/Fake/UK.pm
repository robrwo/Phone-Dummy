package Phone::Fake::UK;

use strict;
use warnings;

use 5.10.0;

use Carp;
use Readonly;

use version 0.77; our $VERSION = version->declare("v0.1.0");

# http://stakeholders.ofcom.org.uk/telecoms/numbering/guidance-tele-no/numbers-for-drama

Readonly::Scalar my $CountryCode => '44';

Readonly::Hash my %Ranges =>
    (
     '0113'   => { template => '496 0XXX',  from => 0, to => 999 },
     '0114'   => { template => '496 0XXX',  from => 0, to => 999 },
     '0115'   => { template => '496 0XXX',  from => 0, to => 999 },
     '0116'   => { template => '496 0XXX',  from => 0, to => 999 },
     '0117'   => { template => '496 0XXX',  from => 0, to => 999 },
     '0118'   => { template => '496 0XXX',  from => 0, to => 999 },
     '0121'   => { template => '496 0XXX',  from => 0, to => 999 },
     '0131'   => { template => '496 0XXX',  from => 0, to => 999 },
     '0141'   => { template => '496 0XXX',  from => 0, to => 999 },
     '0151'   => { template => '496 0XXX',  from => 0, to => 999 },
     '0161'   => { template => '496 0XXX',  from => 0, to => 999 },
     '0191'   => { template => '498 0XXX',  from => 0, to => 999 },
     '020'    => { template => '7946 0XXX', from => 0, to => 999 },
     '028'    => { template => '9018 0XXX', from => 0, to => 999 },
     '029'    => { template => '2018 0XXX', from => 0, to => 999 },
     '01632'  => { template => '960XXX',    from => 0, to => 999 },
     '07700'  => { template => '900XXX',    from => 0, to => 999 },
     '08081'  => { template => '570XXX',    from => 0, to => 999 },
     '0909'   => { template => '8790XXX',   from => 0, to => 999 },
     '03069'  => { template => '990XXX',    from => 0, to => 999 },
    );

sub rand_phone {
    my %opts = @_;
    $opts{prefix} //= qr/^0[12]/;
    my @prefixes = grep { $_ =~ qr/$opts{prefix}/ } (keys %Ranges);

    croak "No matching prefixes" unless (@prefixes);

    my $prefix   = $prefixes[ int(rand(scalar(@prefixes))) ];
    my $range    = $Ranges{$prefix};

    my $val      = $range->{template};
    ($val =~ /([X]+)/) or croak "Invalid phone template: ${val}";
    my $size     = length($1);
    my $number   = sprintf("%0${size}d", int(rand($range->{to} - $range->{from})) + $range->{from});

    my $re       = "X" x $size;
    $val  =~ s/$re/$number/;

    my @r = ($prefix, $val);

    unshift @r, "+${CountryCode}" if ($opts{country_code});

    return "@r";
}

1;
