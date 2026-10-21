-- 9/15/13: modifying this for new season, new site

/* Process:
- start Bitvise ssh client
- login to 3essentials site
- minimize window
- start Mysql workbench as normal

*/



/* -------------------------------------------------------- */
-- simple instructions

use cp30725_men;

SET SQL_SAFE_UPDATES = 0;

delete from results_staging;

delete from seedings_staging;


load data local infile 'c:/Dropbox/z IT/temp/irt_fountainvalley_2026_singles.csv' into table results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

-- load data local infile 'C:/Users/tboss/Dropbox/z IT/incoming/rball/backup copies/irt_2003usopen_qualifiers.csv' into table results_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\n';

select * from results_staging;

-- update results_staging set tmp_date='2016-11-19';

update results_staging set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

update results_staging set season='2025-26';

-- update results_staging set season='1994-5';

-- check for duplicates
select event, loser, count(*) from results_staging
where loser <> '?' group by event,loser having count(*) > 1;

-- final qa
select * from results_staging;


insert into results select * from results_staging;
commit;

-- select * from tourneys where tmp_date='19911104';
-- delete from tourneys where tmp_date='19911104';

-- Main insert query for non-grand slams; change N to Y for a Grand Slam
insert into tourneys (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'N' from results_staging;

SET SQL_SAFE_UPDATES = 0;

select * from tourneys order by tmp_date desc;

update tourneys set preview_url='https://blog.proracquetballstats.com/index.php/2026/03/11/irt-papa-nicholas-coffee-shamrock-shootout-preview/' 
 where event='2026 The Players Championships';

update tourneys set wrapup_url='https://blog.proracquetballstats.com/index.php/2026/03/17/irt-2026-shamrock-shootout-recap/'
 where event='2026 The Players Championships';



-- Seedings

load data local infile 'c:/Dropbox/z IT/temp/irt_fountainvalley_2026_singles_seeding.csv' into table seedings_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

-- load data local infile 'C:/Users/tboss/Dropbox/z IT/incoming/rball/backup copies/irt_1999usopen_results_seedings.csv' into table seedings_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

select * from seedings_staging order by seeding;

insert into seedings select * from seedings_staging;
commit;

-- now do doubles....

-- do name cleanup

SET SQL_SAFE_UPDATES = 0;

delete from wins;
insert into wins
select winner, count(winner) as wins
from results
group by winner;
commit;


delete from banner;
insert into banner values ('Database updated to 2026 Players Championship','4/20/26');
commit;

