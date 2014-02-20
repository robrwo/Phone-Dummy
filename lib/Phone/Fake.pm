package Phone::Fake;

use base 'Exporter';

use warnings;
use strict;

use 5.10.0;

=head1 NAME

Phone::Fake - foo

=head1 VERSION

Version 0.01

=cut

use version 0.77; our $VERSION = version->declare("v0.1.0");

use Module::Load;


=head1 SYNOPSIS

  use Phone::Fake;

  my $number = rand_phone();

=head1 EXPORTS

=over

=cut

our @EXPORT = qw( rand_phone );

our @EXPORT_OK = @EXPORT;

=item rand_phone

=cut

sub rand_phone {
    my %opts = @_;
    $opts{country} //= 'UK';
    my $namespace = __PACKAGE__ . '::' . $opts{country};
    load $namespace;

    {
	no strict 'refs';
	my $fn = *{$namespace . '::rand_phone'};

	return &{$fn}(%opts);
    }

}

=back

=head1 SEE ALSO

L<Data::Faker::PhoneNumber>

=head1 AUTHOR

Robert Rothenberg, C<< <rrwo at cpan.org> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2012 Robert Rothenberg.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Phone::Fake
