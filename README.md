# Installation

    git clone git://github.com/ironcamel/FitnessChallenge.git
    cd FitnessChallenge
    sudo cpanm --installdeps .

# Setup

Setup is very easy. You do not even need to create a database.
The first time FitnessChallenge runs, it will create a database if it does
not exist yet.

Make copies of the config templates and edit them.

    cp config.example.yml config.yml

In config.yml, make sure to set the admin_password and user_domain.

    cp environments/development.example.yml environments/development.yml
    cp environments/production.example.yml environments/production.yml

In the above environment specific configs, make sure to set the correct dsn
values.

# Deployment

To deploy a development instance, simple run:

    ./bin/app.pl

You can now view the app in your browser at (http://localhost:3000).

For the different ways to deploy a production instance, see
[Dancer::Deployment](http://metacpan.org/module/Dancer::Deployment).
Personally, I prefer nginx proxying to Starman,
and using Ubic to manage the service.
