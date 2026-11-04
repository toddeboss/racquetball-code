/* 11/3/08: player_profile table

this table matches the format of the player_profile.csv with the exception of the tmp-date field, w hich is tacked on the end
and which is updated post-db load

---------
Revision history:
- 11/3/08: creation
- ... missed a few updates 
- 12/5/16: updated with new data.
- 12/5/16: added home country
- 10/16/17: went to master player profile, added gender
- 11/8/17 added twitter
- 1/27/18: added picture flag, changed other flags to be proper data types and right names, deployed in all DBs.
- 10/10/18: added facebook and instagram links too
- 10/11/18: also added rydf_flag for ease of data research
- 9/11/19: renamed picture_flag to picture_filename, expanded field.
- 9/22/19: added new field called photo source to provide photo credit.
- 10/24/19: added home page
- 10/28/19: adding nickname
- 4/23/20: moving first 8 fields to "end" of xls/table for ease of use of XLS file
- 9/23/20: added a pickelball flag at the beginning
- 10/14/21: added job and fun facts fields
- 11/8/21: added WOR flag.
- 1/23/22: added additional sponsors field, changed existing to be racquet sponsor
- 9/5/25: added hall of Fame flag to beginning of xls
- 3/24/26: changed directory of ingestion with migration to new computer
 */


use cp30725_prs;

SET SQL_SAFE_UPDATES = 0;

create table player_profile_20260324 as select * from player_profile;

drop table player_profile;

create table player_profile
( player varchar(50),
 gender varchar(1),
 hof_flag varchar(10),
 wor_flag varchar(10),
 pickleball_flag varchar(10),
 tourney_winner_flag varchar(10),
 active_flag varchar(10),
 country varchar(100),
 hometown varchar(100),
 current_residence varchar(100),
 height varchar(10),
 weight varchar(4),
 college varchar(50),
 racquet_sponsor varchar(50),
 addl_sponsors varchar(255),
 dob varchar(10),
 l_r_flag varchar(1),
 current_age integer,
 picture_filename varchar(200),
 photo_source varchar(200), 
 twitter varchar(100),
 facebook varchar(100),
 instagram varchar(100), 
 homepage varchar(100), 
 nickname varchar(50),
 rydf_flag varchar(10), 
 job varchar(255),
 fun_facts varchar(255),
 notes varchar(255),
 tmp_dob date);
 
truncate table cp30725_prs.player_profile;

load data local infile 'C:/Dropbox/z rball/Player Profile/master_player_profile.csv' into table cp30725_prs.player_profile
fields terminated by ',' enclosed by '"' lines terminated by '\n';

-- load data local infile 'C:/Users/tboss/Dropbox/z IT/incoming/rball/master_player_profile.csv' into table player_profile
-- fields terminated by ',' enclosed by '"' lines terminated by '\n';

-- load data local infile 'e:/Dropbox/z IT/incoming/rball/master_player_profile.csv' into table player_profile
-- fields terminated by ',' enclosed by '"' lines terminated by '\n';





/* !!!! note: don't run this, run the ongoing cleanup */


commit;

select count(*) from cp30725_prs.player_profile;


select * from cp30725_prs.player_profile;


-- Now run name clean up!

 
/* this is all done dymaically now in code each time
create table players_all (player varchar(50));

truncate table players_all;

insert into players_all
select distinct winner as name from results 
union 
select distinct loser as name from results order by name;

select * from players_all;

*/


-- 9/11/19: overloading picture_flag with picture image filename; included in main DDL above
-- alter table cp30725_prs.player_profile rename picture_flag picture_filename varchar(200);
