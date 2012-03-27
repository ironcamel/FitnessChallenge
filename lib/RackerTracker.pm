package RackerTracker;
use Dancer ':syntax';

use Dancer::Plugin::DBIC 'schema';
use Data::Dump 'dump';
use DateTime;

get '/' => sub {
    template 'officecomp15';
};

#{'email' => '','exercise' => ['1332691921129']}
post '/ajax/track' => sub {
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
    my @rows = schema->resultset('Workout')->search({},
        {
            '+select' => [{ count => 'email' }],
            '+as'     => ['cnt'],
            group_by  => 'email',
        }
    );
    my @users;
    for my $row (@rows) {
        my $name = $row->email->email;
        $name =~ s/\@mailtrust\.com$//;
        push @users, { name => $name, score => $row->get_column('cnt') };
    }
    my $now = DateTime->now;
    return {
        users => \@users,
        month => $now->month_name,
        name  => $current_name,
    };
};

true;
