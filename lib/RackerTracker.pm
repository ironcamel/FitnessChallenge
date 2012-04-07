package RackerTracker;
use Dancer ':syntax';
use Dancer::Plugin::DBIC 'schema';
use DateTime;

get '/' => sub { template 'officecomp15' };

get '/ajax/workouts' => sub { _get_data() };

post '/ajax/workouts' => sub {
    my $data = from_json request->body;
    my $email = $data->{email};
    if ( ! $email or $email !~ /^.+\@mailtrust\.com$/ or $email =~ /'|"/ ) {
        status 400;
        return { error => "Invalid email" };
    }
    $email = lc $email;
    my $user = schema->resultset('User')->find_or_create({ email => $email });
    foreach my $epoch ( @{ $data->{exercise} } ) {
        $epoch = substr $epoch, 0, 10;
        my $date = DateTime->from_epoch(epoch => $epoch);
        $user->workouts->update_or_create({day => $date->ymd});
    }
    return _get_data();
};

sub _get_data {
    my @users = schema->resultset('Workout')->search({}, {
        '+select' => [{ count => 'email' }],
        '+as'     => ['cnt'],
        group_by  => 'email',
    });
    @users =
        map {
            email => $_->get_column('email'),
            score => $_->get_column('cnt'),
        },
        sort { $b->get_column('cnt') <=> $a->get_column('cnt') }
        @users;
    return {
        users => \@users,
        month => DateTime->now->month_name,
    };
}

true;
