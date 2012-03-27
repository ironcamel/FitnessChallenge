use utf8;
package RackerTracker::Schema::Result::Workout;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

RackerTracker::Schema::Result::Workout

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

=head1 TABLE: C<workout>

=cut

__PACKAGE__->table("workout");

=head1 ACCESSORS

=head2 email

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 0
  size: 200

=head2 day

  data_type: 'date'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "email",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 200 },
  "day",
  { data_type => "date", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</email>

=item * L</day>

=back

=cut

__PACKAGE__->set_primary_key("email", "day");

=head1 RELATIONS

=head2 email

Type: belongs_to

Related object: L<RackerTracker::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "email",
  "RackerTracker::Schema::Result::User",
  { email => "email" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07017 @ 2012-03-23 06:39:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cU0CDRms2ZmBfURN7W2gsg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
