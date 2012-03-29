package RackerTracker;
use Dancer ':syntax';

use Dancer::Plugin::DBIC 'schema';
use Data::Dump 'dump';
use DateTime;

get '/' => sub {
    template 'officecomp15';
};

#{'email' => '','exercise' => ['1332691921129']}
post '/ajax/workouts' => sub {
    my $data = from_json request->body;
    my $email = $data->{email};
    if ( ! $email or $email !~ /^.+\@mailtrust\.com$/ or $email =~ /'|"/ ) {
        status 400;
        return { error => "Invalid email" };
    }
    $email = lc $email;
    my $user = schema->resultset('User')->find_or_create({ email => $email });
    my $current_name = $user->email;
    $current_name =~ s/\@mailtrust\.com$//;

    for my $epoch ( @{ $data->{exercise} } ) {
        $epoch = substr $epoch, 0, 10;
        my $date = DateTime->from_epoch(epoch => $epoch);
        $user->workouts->update_or_create({day => $date->ymd});
    }
    return _get_data($current_name);
};

get '/ajax/workouts' => sub { _get_data() };

sub _get_data {
    my ($current_name) = @_;
    my @users = schema->resultset('Workout')->search({}, {
        '+select' => [{ count => 'email' }],
        '+as'     => ['cnt'],
        group_by  => 'email',
    });
    @users = map {
        email => $_->get_column('email'),
        score => $_->get_column('cnt'),
    }, @users;
    return { users => \@users };
}

true;
