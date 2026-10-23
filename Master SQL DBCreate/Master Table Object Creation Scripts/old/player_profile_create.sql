/* 11/3/08: player_profile table
12/5/16: updated with new data.

12/5/16: added home country

 */


use cp30725_irf;

SET SQL_SAFE_UPDATES = 0;


drop table player_profile;

create table player_profile
( player varchar(50),
 total_wins integer,
 tourney_wins integer,
 country varchar(100),
 hometown varchar(100),
 current_residence varchar(100),
 height varchar(10),
 weight varchar(4),
 college varchar(50),
 sponsor varchar(50),
 dob varchar(10),
 l_r_flag varchar(1),
 current_age integer,
 notes varchar(255),
 tmp_dob date);
 
 
select * from player_profile;

create table player_profile_20161205a as select * from player_profile;

truncate table player_profile;


load data local infile 'E:/Dropbox/z rball/IRF/irf_player_profile.csv' into table player_profile
fields terminated by ',' enclosed by '"' lines terminated by '\n';


delete from player_profile where player='Player';

delete from player_profile where player is null;

delete from player_profile where tourney_wins is null;

delete from player_profile where player='';

select * from player_profile;

commit;


/* Now don't forget to run perl code to fix the tmp_dob dates!!!  Or run this: */

update player_profile set tmp_dob=STR_TO_DATE(dob, '%m/%d/%Y');

select * from player_profile;
