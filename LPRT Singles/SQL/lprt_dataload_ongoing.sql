-- 11/20/16: Ongoing data load for LPRT: creating new file for LPRT

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

delete from results_staging;

delete from seedings_staging;

load data local infile 'c:/temp/lprt_2023chicago_singles.csv' into table results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';


select * from results_staging;



-- update results_staging set season='1977-78';

update results_staging set season='2023-24' where season like '2023-24%';

-- update results_staging set tmp_date='2016-10-09' where date='10/9/2016';

update results_staging set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

-- check for duplicates
select event, loser, count(*) from results_staging
where loser <> '?' group by event,loser having count(*) > 1;


insert into results select * from results_staging;
commit;



-- Main insert query for non-grand slams; change N to Y for a Grand Slam
insert into tourneys (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'N' from results_staging;

SET SQL_SAFE_UPDATES = 0;

select * from tourneys order by tmp_date desc;

update tourneys set preview_url='https://blog.proracquetballstats.com/index.php/2023/11/16/lprt-turkey-shootout-preview/'
 where event='2023 LPRT Turkey Shootout';

update tourneys set wrapup_url='https://blog.proracquetballstats.com/index.php/2023/08/14/world-singles-and-doubles-2023-wrap-up/'
 where event='2023 LPRT Turkey Shootout';

-- select * from tourneys;

-- update tourneys set major_flag='Y' where event='21st United Healthcare US Open';


load data local infile 'c:/temp/lprt_2023chicago_singles_seeding.csv' into table seedings_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

select * from seedings_staging order by seeding;

insert into seedings select * from seedings_staging;
commit;


--
-- do doubles now, then...
-- run name cleanup after doing Doubles....
--

delete from wins;
insert into wins
select winner, count(winner) as wins
from results
group by winner;
commit;


delete from banner;
insert into banner values ('Database updated to 2023 LPRT Turkey Shoot from Chicago','11/21/23');
commit;

