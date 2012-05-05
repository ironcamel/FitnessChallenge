use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'FitnessChallenge',
    AUTHOR              => [
        'Dave Williams <dave.williams@rackspace.com>',
        'Naveed Massjouni <naveedm9@gmail.com>',
    ],
    VERSION_FROM        => 'lib/FitnessChallenge',
    LICENSE             => 'perl',
    PREREQ_PM => {
        'Capture::Tiny'            => 0,
        'Dancer'                   => 1.3095,
        'Dancer::Plugin::DBIC'     => 0,
        'DateTime'                 => 0,
        'DateTime::Format::SQLite' => 0,
        'JSON'                     => 0,
        'SQL::Translator'          => 0.11006,
        'Template'                 => 0,
        'Test::More'               => 0,
        'YAML'                     => 0,
    },
);
