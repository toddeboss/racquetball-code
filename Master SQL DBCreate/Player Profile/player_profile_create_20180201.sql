/* 11/3/08: player_profile table
12/5/16: updated with new data.

12/5/16: added home country

10/16/17: went to master player profile, added gender
11/8/17 added twitter

1/27/18: added picture flag, changed other flags to be proper data types and right names, deployed in all DBs.

 */


use cp30725_irt;

SET SQL_SAFE_UPDATES = 0;

desc results;

create table player_profile_20180127 as select * from player_profile;

drop table player_profile;

create table player_profile
( player varchar(50),
 picture_flag varchar(10),
 twitter varchar(100),
 gender varchar(1),
 tourney_winner_flag varchar(10),
 active_flag varchar(10),
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
 


truncate table player_profile;


load data local infile 'E:/Dropbox/z rball/master_player_profile.csv' into table player_profile
fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'C:/Users/tboss/Dropbox/z IT/incoming/rball/master_player_profile.csv' into table player_profile
fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'e:/Dropbox/z IT/incoming/rball/master_player_profile.csv' into table player_profile
fields terminated by ',' enclosed by '"' lines terminated by '\n';


delete from player_profile where player='Player';

delete from player_profile where player is null;

-- delete from player_profile where tourney_wins is null;

delete from player_profile where player='';

update player_profile set tmp_dob=STR_TO_DATE(dob, '%m/%d/%Y');


commit;


select * from player_profile;

create table players_all (player varchar(50));


truncate table players_all;

insert into players_all
select distinct winner as name from results 
union 
select distinct loser as name from results order by name;

select * from players_all;


-- Now run name clean up!

