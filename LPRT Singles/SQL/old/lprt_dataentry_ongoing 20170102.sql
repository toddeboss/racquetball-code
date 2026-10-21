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


load data local infile 'c:/temp/wirt_1996catchup.csv' into table results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

select * from results_staging;

update results_staging set season='1996-97';

update results_staging set season='2016-17';

-- update results_staging set tmp_date='2016-10-09' where date='10/9/2016';

update results_staging set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');


insert into results select * from results_staging;
commit;



-- Main insert query for non-grand slams; change N to Y for a Grand Slam
insert into tourneys (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'N' from results_staging;

-- select * from tourneys;

-- update tourneys set major_flag='Y' where event='21st United Healthcare US Open';


delete from wins;
insert into wins
select winner, count(winner) as wins
from results
group by winner;
commit;

load data local infile 'c:/temp/wirt_1996catchup_seeding.csv' into table seedings_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

select * from seedings_staging order by seeding;

insert into seedings select * from seedings_staging;
commit;

delete from banner;
insert into banner values ('Loaded up first part of 1996-97 season','12/21/16');
commit;


-- now post to meetandplay, twitter

Caught up last four LPRT events into www.proracquetballstats.com database.  Latest event in Bremerton with @paolongoria over @aLeexandraahr in the final

Latest event in Bremerton with @paolongoria over @aLeexandraahr in the final

Loaded entire 2000-01 season for LPRT (then known as LPRA) into www.proracquetballstats.com database.  Year-end champ = Gudinas and big debut season for Rajsich

Loaded entire 2001-02 season for LPRT (then known as LPRA) into www.proracquetballstats.com database.  Year-end champ = Gudinas.  Paraiso, Wachtel and Rajsich top 4.

Loaded entire 2002-03 season for LPRT (then known as LPRA) into www.proracquetballstats.com database.  Year-end champ = Gudinas.  Paraiso, Wachtel and Rajsich top 4.

Loaded entire 1995-96 season for LPRT (then known as WIRT) into www.proracquetballstats.com database.  Undefeated season for Michelle Gould, Gudinas.  Paraiso, Wachtel and Rajsich top 4.


Loaded LPRT Ladies pro #racquetball Xmas Classic results from Laurel www.proracquetballstats.com database. (1/2)

@paolongoria over @fredelambert in the final, @violentasalas and @leonaparrilla semi finalists (2/2).