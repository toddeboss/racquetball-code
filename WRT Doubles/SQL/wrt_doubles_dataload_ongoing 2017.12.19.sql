-- 9/15/13: modifying this for new season, new site

/* Process:
- start Bitvise ssh client
- login to 3essentials site
- minimize window
- start Mysql workbench as normal

*/



/* -------------------------------------------------------- */
-- simple instructions

use cp30725_wrt;

SET SQL_SAFE_UPDATES = 0;

delete from results_doubles_staging;

delete from seedings_doubles_staging;

load data local infile 'C:/Users/tboss/Dropbox/z rball/WRT Doubles/wrt_doubles_results.csv' into table results_doubles_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

select * from results_doubles_staging;

update results_doubles_staging set round=99 where round=0;

delete from results_doubles_staging where winner_p1='Winner Player 1';

-- update results_staging set tmp_date='2016-11-19';

update results_doubles_staging set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

-- this gets trailing space embedded in the xls data entry.
update results_doubles_staging set season='2012' where season like '2012%';
update results_doubles_staging set season='2013' where season like '2013%';
update results_doubles_staging set season='2014' where season like '2014%';
update results_doubles_staging set season='2015' where season like '2015%';
update results_doubles_staging set season='2016' where season like '2016%';
update results_doubles_staging set season='2017' where season like '2017%';


-- truncate table results_doubles;

insert into results_doubles select * from results_doubles_staging;
commit;

-- truncate table tourneys_doubles;

-- Main insert query for non-grand slams; change N to Y for a Grand Slam
insert into tourneys_doubles (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'N' from results_doubles_staging;



load data local infile 'C:/Users/tboss/Dropbox/z rball/WRT Doubles/wrt_doubles_seedings.csv' into table seedings_doubles_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

select * from seedings_doubles_staging order by seeding;

delete from seedings_doubles_staging where event='Event';

insert into seedings_doubles select * from seedings_doubles_staging;
commit;

--
-- run name clean up here
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



delete from banner;
insert into banner values ('WRT Singles Database updated to San Antonio event, 2017 Season Complete, congrats to Bobby Horn, year-end title winner!  WRT Doubles database now populated to first 2012 WRT event','12/19/17');
commit;

-- now post to meetandplay, twitter
