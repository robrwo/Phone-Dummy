use strict;
use warnings;
use ExtUtils::MakeMaker;

use 5.10.0;

WriteMakefile(
    NAME                => 'Phone::Fake',
    AUTHOR              => q{Robert Rothenberg <rrwo@cpan.org>},
    VERSION_FROM        => 'lib/Phone/Fake.pm',
    ABSTRACT_FROM       => 'lib/Phone/Fake.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
	'Carp'		=> 0,
	'Exporter'	=> 0,
	'Module::Load'	=> 0,
	'Readonly'	=> 0,
        'Test::More'	=> 0.61,
	'version'	=> 0.77,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Phone-Fake-*' },
);
