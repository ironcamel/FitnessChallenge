#!/bin/bash

dbicdump -o dump_directory=/home/naveed/projects/RackerTracker/lib \
 -o components='[qw(InflateColumn::DateTime)]' \
 -o relationship_attrs='{has_many => {cascade_copy => 1, cascade_delete => 1}}'\
 FitnessChallenge::Schema dbi:SQLite:./tracker.db

