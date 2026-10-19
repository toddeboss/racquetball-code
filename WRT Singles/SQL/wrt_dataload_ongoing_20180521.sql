-- 11/18/16: WRT ongoing data load process

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

delete from results_staging;

delete from seedings_staging;


load data local infile 'c:/temp/wrt_austin18.csv' into table results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

select * from results_staging;

update results_staging set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

-- update results_staging set tmp_date='2016-11-06';
update results_staging set season='2018';

insert into results select * from results_staging;
commit;

-- Main insert query for non-grand slams; change N to Y for a Grand Slam
insert into tourneys (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'N' from results_staging;



load data local infile 'c:/temp/wrt_austin18_seedings.csv' into table seedings_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

select * from seedings_staging order by seeding;

insert into seedings select * from seedings_staging;
commit;

-- run master names fixes here.

delete from wins;
insert into wins
select winner, count(winner) as wins
from results
group by winner;
commit;

delete from banner;
insert into banner values ('WRT Database updated to 2018 Long Horn Open in Austin, singles and doubles','1/15/18');
commit;



-- now post to meetandplay, twitter

