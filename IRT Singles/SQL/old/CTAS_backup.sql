/* 7/19/13: getting CTAS backups of all main tables */

create table results_postmigration_20130719 as select * from results;

create table player_profile_postmigration_20130719 as select * from player_profile;

create table rankings_postmigration_20130719 as select * from rankings;

create table seedings_postmigration_20130719 as select * from seedings;

create table tourneys_postmigration_20130719 as select * from tourneys;

create table tour_champions_postmigration_20130719 as select * from tour_champions;

