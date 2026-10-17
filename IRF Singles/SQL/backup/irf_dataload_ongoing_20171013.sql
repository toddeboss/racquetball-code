-- 10/13/17: irf ongoing data load file

/* Process:
- start Bitvise ssh client
- login to 3essentials site
- minimize window
- start Mysql workbench as normal

*/



/* -------------------------------------------------------- */
-- simple instructions

use cp30725_irf;

SET SQL_SAFE_UPDATES = 0;

delete from results_staging;

delete from seedings_staging;


load data local infile 'c:/temp/irt_usopen98.csv' into table results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

select * from results_staging;

-- update results_staging set tmp_date='2016-11-19';

update results_staging set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

update results_staging set season='1998-9';

insert into results select * from results_staging;
commit;

-- Main insert query for non-grand slams; change N to Y for a Grand Slam
insert into tourneys (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'N' from results_staging;

delete from wins;
insert into wins
select winner, count(winner) as wins
from results
group by winner;
commit;

load data local infile 'c:/temp/irt_usopen98_seeding.csv' into table seedings_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

select * from seedings_staging order by seeding;

insert into seedings select * from seedings_staging;
commit;

delete from banner;
insert into banner values ('Database updated to 2016 St. Louis event.  Also just uploaded 1998 full US Open Results with Seeds','12/30/16');
commit;


-- now post to meetandplay, twitter

St. Louis IRT #racquetball event entered into database; @KingKaneRB over @RockyCarsonRB in 3-gam final win.  http://proracquetballstats.com .

IRT database archive results; found full 128 on archive.org for 1998 US Open and uploaded with 


/* -------------------------------------------------------- */
-- Detailed instructions

use wwwbossconsultingcom;

/* 9/20/10: accidentally ran this code; wtf? do i need to find these results again?
select * from results where event='Michael Lanning Benefit Pro-Am';
delete from results where event='Michael Lanning Benefit Pro-Am';

delete from results where event='Elmwood Summer Cooler' and tmp_date='1998-08-09';

select * from results where winner='Carson, Rocky' and loser='Eagle, Doug';

delete from results where event='Coca-Cola Pro-Am';

select * from results where event='Coca-Cola Pro-Am';
*/

/* ongoing irt data load */

use wwwbossconsultingcom;
delete from results_staging;
/* remember local!!! */

/*
--load data local infile 'c:/temp/irt_memphis05.csv' into table results_staging
--load data local infile 'Pro_Results_new.csv' into table results
--load data local infile 'irt_nycriverside0506.csv' into table results_staging
*/

load data local infile 'c:/temp/irt_fullerton13.csv' into table results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data infile '/usr/home/tboss/mysql/irt_catchingup06.csv' 
into table results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

select * from results_staging;
delete from results_staging where winner='';
delete from results_staging where winner='winner';

delete from results_staging where round=2;

select distinct(date) from results_staging;
select distinct(tmp_date) from results_staging;
update results_staging set tmp_date='1999-10-24' where date='10/24/1999';
update results_staging set tmp_date='1999-10-31' where date='10/31/1999';
update results_staging set tmp_date='2000-01-23' where date='1/23/2000';
update results_staging set tmp_date='2000-02-13' where date='2/13/2000';
update results_staging set tmp_date='2000-03-19' where date='3/19/2000';

update results_staging set tmp_date='2013-05-19';

update results_staging set tmp_date='2008-09-21' where date='9/21/2008';
update results_staging set tmp_date='2008-10-03' where date='9/28/2008';

update results_staging set round='8' where round='Q';
update results_staging set round='4' where round='S';
update results_staging set round='2' where round='F';

select distinct(season) from results_staging;
update results_staging set season='1999-00' where season like '1999%';
update results_staging set season='1998-9' where season like '1998-9%';
update results_staging set season='1996-7' where season like '1996%';
update results_staging set season='1997-8' where season like '1997%';
update results_staging set season='1994-5' where season like '1994%';

update results_staging set season='2012-13';

update results_staging set source='www.irt-tour.com' where event='2008 Kansas City IRT Pro-Am';

select * from results_staging;

insert into results select * from results_staging;
commit;


select count(*) from results;

/* -------------------------------------------------------- */
-- New: must populate tourneys table as well.

update results set season='1998-9' where season like '1998-9%';

--delete from tourneys where event='Coca-Cola Pro-Am';

select * from tourneys where season='1999-00' order by tmp_date desc;
select * from tourneys where season='1994-5' order by tmp_date desc;
select * from tourneys where season like '1994-5%' order by tmp_date desc;

select * from tourneys order by tmp_date desc;

-- Main insert query for non-grand slams; change N to Y for a Grand Slam
insert into tourneys (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'N' from results_staging;

select * from tourneys where tmp_date='1999-10-24';
update tourneys set major_flag='Y' where event='2009 Motorola Racquetball World Championships';
update tourneys set major_flag='Y' where tmp_date='1999-10-24';


/* -------------------------------------------------------- */
-- re-populate winners table to get updated frequent players.

--select * from wins order by wins desc;

delete from wins;
insert into wins
select winner, count(winner) as wins
from results
group by winner;
commit;



/* -------------------------------------------------------- */
-- populate the seedings table...

truncate table seedings_staging;

load data local infile 'c:/temp/irt_fullerton13_seedings.csv' into table seedings_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

select * from seedings_staging order by seeding asc;

-- cleanup if needed
--- delete from seedings where event='15th Annual US Open';

insert into seedings select * from seedings_staging;
commit;


    

/* -------------------------------------------------------- */

-- last step: clear out results_staging for next.
delete from results_staging;
delete from seedings_staging;







/* -------------------------------------------------------- */
--  one time code below

/*
select * from results where event like '2009%';
update results set tmp_date='2009-01-11' where event like '2009%';

delete from tourneys where tmp_date is null;


select * from player_profile where player like 'Wood%';

select * from wins;

update player_profile set total_wins=wins.wins
from player_profile,wins
where player_profile.player = wins.winner
and player='Woodbury, Travis';


select * from results where loser like 'Schenck%';
update results set loser='Schenck, Darrin' where loser ='Schenck';


select * from results where winner='Herrera, A';
update results set winner='Herrera, Anthony' where winner='Herrera, A';

create table results_20091011 as select * from results;

*/

-- backup routines.
show tables;

create table results_20110925 as select * from results;
create table seedings_20110925 as select * from seedings;



select tour,count(tour) from results group by tour;


select * from results where event='21st United Healthcare US Open';

update results set season='2016-17' where event='21st United Healthcare US Open';

select last_update_date,banner_text from banner;





