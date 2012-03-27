#!/bin/bash

dbicdump -o dump_directory=/home/naveed/projects/RackerTracker/lib \
    -o components='[qw(InflateColumn::DateTime)]' \
    RackerTracker::Schema dbi:SQLite:./tracker.db

