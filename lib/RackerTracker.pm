package RackerTracker;
use Dancer ':syntax';
use Dancer::Plugin::DBIC 'schema';
use DateTime;

eval { schema->deploy };

get '/' => sub { template 'officecomp15' };

get '/ajax/workouts' => sub { _get_data() };

post '/ajax/workouts' => sub {
    my $data = from_json request->body;
    my $email = $data->{email};
    my $time = $data->{time};
    if ( ! $email or $email !~ /^.+\@mailtrust\.com$/ or $email =~ /'|"/ ) {
        status 400;
        return { error => "Invalid email" };
    }
    $email = lc $email;
    my $user = schema->resultset('User')->find_or_create({ email => $email });
    foreach my $epoch ( @{ $data->{exercise} } ) {
        my $date = _date_from_time($epoch);
        $user->workouts->update_or_create({day => $date->ymd});
    }
    return _get_data($time);
};

post '/ajax/delete-user' => sub {
    my $email = param('email');
    debug "Admin is trying to delete user $email";
    return { error => 'Invalid admin password' }
        unless param('admin_password') eq setting('admin_password');
    schema->resultset('User')->search({email => $email})->delete_all;
    return {};
};

get '/admin' => sub {
    my @users = sort { $a->email cmp $b->email } schema->resultset('User')->all;
    template admin => {
        users => \@users,
    };
};

sub _get_data {
    my ($time) = @_;
    my $dt_start = _date_from_time($time || time());
    $dt_start->set_day(1)->truncate(to => 'day');
    my $dt_end = DateTime->last_day_of_month(
        year => $dt_start->year, month => $dt_start->month);
    my $dtf = schema->storage->datetime_parser;
    my @users = schema->resultset('Workout')->search(
        {
            day => {
                -between => [
                    $dtf->format_datetime($dt_start),
                    $dtf->format_datetime($dt_end),
                ],
            }
        },
        {
            '+select' => [{ count => 'email' }],
            '+as'     => ['cnt'],
            group_by  => 'email',
        }
    );
    @users =
        map {
            email => $_->get_column('email'),
            score => $_->get_column('cnt'),
        },
        sort { $b->get_column('cnt') <=> $a->get_column('cnt') }
        @users;
    return {
        users => \@users,
        month => $dt_start->month_name,
    };
}

# The time received from the js side needs to be shortened to 10 digits
sub _date_from_time { DateTime->from_epoch(epoch => substr $_[0], 0, 10) }

true;
