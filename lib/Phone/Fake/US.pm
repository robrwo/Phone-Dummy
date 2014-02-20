package Phone::Fake::US;

=head1 NAME

Phone::Fake::US - Fake phone numbers for North America

=cut

use strict;
use warnings;

use 5.10.0;

use Carp;
use Readonly;

use version 0.77; our $VERSION = version->declare("v0.1.0");

# https://en.wikipedia.org/wiki/List_of_North_American_Numbering_Plan_area_codes

# http://cseweb.ucsd.edu/~bsy/area.html

Readonly::Scalar my $CountryCode => '1';

Readonly::Hash my %Ranges => (
    '958' => { template => '555 XXXX', from => 0, to => 9999 },
      map { $_ => { template => '555 01XX',  from => 0, to => 99 } }
       (201..219, 224..225, 227..229, 231, 234, 236, 239..240, 242, 246,
	248..254, 256, 260, 262, 264, 267..270, 272, 274, 276, 278,
        280..284, 289, 301..321, 323, 325, 327, 330..331, 334,
        336..337, 339..341, 345, 347, 351..354, 358, 360..361, 365,
        369, 380..381,
        383, 385..386, 401..410, 412..420, 423..425, 430..432,
        434..435, 437, 440..443, 445, 447, 464, 469..470, 473, 475, 478..480,
        484, 500..510, 512..520, 522, 530, 533, 540..541, 544, 546,
        555, 557, 559,
        561..564, 566..567, 571..574, 577, 580, 582, 585, 588,
        590, 600..610, 612..620,
        623, 626..628, 630..631, 636, 639, 641, 646..647, 649..651, 657,
        659..662, 664, 667, 669..671, 678..679, 689, 700..710,
        712..720, 724, 727, 730..732, 734, 737, 740, 747, 752, 754,
        757..758, 760, 763..765, 767, 770, 772..775, 778, 780..781,
        784..787, 800..810, 812..819, 822, 828, 830..833, 835..836,
        843..845, 847..848, 855..870, 872..873, 876..878, 880..882, 888,
        900..910, 912..920, 925, 928, 931, 935..937, 939..941, 947,
        949, 951..952, 954, 956..957, 959, 969..973, 975..976,
        978..980, 984, 985, 989 )
    );


sub rand_phone {
    my %opts = @_;
    $opts{prefix} //= qr/^(?!([56789]00|[58]22|[58]33|[58]44|[855|[58]66|[58]77|588|88[0128]|976|710))/;
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
