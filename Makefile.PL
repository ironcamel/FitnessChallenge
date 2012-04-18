use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'RackerTracker',
    AUTHOR              => q{YOUR NAME <youremail@example.com>},
    VERSION_FROM        => 'lib/RackerTracker.pm',
    ABSTRACT            => 'YOUR APPLICATION ABSTRACT',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Dancer'                   => 1.3095,
        'Dancer::Plugin::DBIC'     => 0,
        'DateTime'                 => 0,
        'DateTime::Format::SQLite' => 0,
        'JSON'                     => 0,
        'SQL::Translator'          => 0.11006,
        'Test::More'               => 0,
        'YAML'                     => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'RackerTracker-*' },
);
