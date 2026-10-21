-- 9/15/13: modifying this for new season, new site

/* Process:
- start Bitvise ssh client
- login to 3essentials site
- minimize window
- start Mysql workbench as normal

*/



/* -------------------------------------------------------- */
-- simple instructions

use cp30725_women;

SET SQL_SAFE_UPDATES = 0;

delete from results_doubles_staging;

delete from seedings_doubles_staging;

load data local infile 'C:/temp/lprt_2023chicago_doubles.csv' into table results_doubles_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

-- load data local infile 'C:/Users/tboss/Dropbox/z rball/LPRT Doubles/tmp files/lprt_doubles_results_201314season.csv' into table results_doubles_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\n';


select * from results_doubles_staging;

-- update results_doubles_staging set round=99 where round=0;

-- delete from results_doubles_staging where winner_p1='Winner Player 1';

-- update results_staging set tmp_date='2016-11-19';

update results_doubles_staging set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

-- this gets trailing space embedded in the xls data entry.
/*
update results_doubles_staging set season='2014-15' where season like '2014-15%';
update results_doubles_staging set season='2015-16' where season like '2015-16%';
update results_doubles_staging set season='2016-17' where season like '2016-17%';
update results_doubles_staging set season='2017-18' where season like '2017-18%';
update results_doubles_staging set season='2013-14' where season like '2013-14%';
*/

-- update results_doubles_staging set season='2019-20' where season like '2019-20%';
update results_doubles_staging set season='2023-24' where season like '2023-24%';

select * from results_doubles_staging;

-- truncate table results_doubles;

insert into results_doubles select * from results_doubles_staging;
commit;

-- truncate table tourneys_doubles;

-- Main insert query for non-grand slams; change N to Y for a Grand Slam
insert into tourneys_doubles (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'N' from results_doubles_staging;




load data local infile 'c:/temp/lprt_2023chicago_doubles_seeding.csv' into table seedings_doubles_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

-- load data local infile 'C:/Users/tboss/Dropbox/z rball/LPRT Doubles/tmp files/lprt_doubles_results_201314season_seedings.csv' into table seedings_doubles_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\r\n';



select * from seedings_doubles_staging order by seeding;

-- delete from seedings_doubles_staging where event='Event';

insert into seedings_doubles select * from seedings_doubles_staging;
commit;

--
-- run name clean up here after running both singles and doubles.
--


delete from wins_doubles;

insert into wins_doubles
select p.winner, sum(wins) as wins from (
select winner_p1 as winner, count(winner_p1) as wins
from results_doubles
group by winner_p1
union all
select winner_p2 winner, count(winner_p2) as wins
from results_doubles
group by winner_p2) p
group by p.winner order by 1;




-- now post to meetandplay, twitter
