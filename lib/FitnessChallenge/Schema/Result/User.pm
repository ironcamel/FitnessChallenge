use utf8;
package FitnessChallenge::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FitnessChallenge::Schema::Result::User

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<user>

=cut

__PACKAGE__->table("user");

=head1 ACCESSORS

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 200

=cut

__PACKAGE__->add_columns(
  "email",
  { data_type => "varchar", is_nullable => 0, size => 200 },
);

=head1 PRIMARY KEY

=over 4

=item * L</email>

=back

=cut

__PACKAGE__->set_primary_key("email");

=head1 RELATIONS

=head2 workouts

Type: has_many

Related object: L<FitnessChallenge::Schema::Result::Workout>

=cut

__PACKAGE__->has_many(
  "workouts",
  "FitnessChallenge::Schema::Result::Workout",
  { "foreign.email" => "self.email" },
  { cascade_copy => 1, cascade_delete => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07017 @ 2012-05-05 21:54:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:75YWGPzkuiO7ZHm5Umjk+Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
