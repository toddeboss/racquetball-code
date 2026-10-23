/* 12/2/16: load up of player profile data.  

12/5/16: added country of origin/home country

1/27/17: fixed as we were re-running over and over


*/

use cp30725_women;

SET SQL_SAFE_UPDATES = 0;

create table player_profile_20161205a as select * from player_profile;

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

create table player_profile_20161202 as select * from player_profile;

create table player_profile_20161205 as select * from player_profile;





truncate table player_profile;


load data local infile 'D:/Dropbox/z rball/LPRT/lpra_player_profile.csv' into table player_profile
fields terminated by ',' enclosed by '"' lines terminated by '\n';

select * from player_profile;

delete from player_profile where player='Player';

delete from player_profile where player='dummy';

delete from player_profile where player='';

update player_profile set tmp_dob=STR_TO_DATE(dob, '%m/%d/%Y');


commit;


-- fix tmp_dates

/*
-- 12/8/1976

SELECT STR_TO_DATE('2013-02-11', '%Y-%m-%d');

SELECT STR_TO_DATE('12/8/1976', '%m/%d/%Y');

select to_date(dob) from player_profile where player='Acosta, Susana';

select substring(dob,1,instr(dob,'/')-1) as month from player_profile where player='Acosta, Susana';

select substring(dob,instr(dob,'/')) from player_profile where player='Acosta, Susana';
*/




select * from player_profile;

select * from player_profile order by player;