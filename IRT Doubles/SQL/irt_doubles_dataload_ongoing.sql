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

delete from results_doubles_staging;

delete from seedings_doubles_staging;


load data local infile 'c:/temp/irt_siouxfalls2025_doubles.csv' into table results_doubles_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

-- load data local infile 'E:/Dropbox/z rball/IRT/irt_stlouis17_doublesresults.csv' into table results_doubles_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\n';

-- load data local infile 'C:/Users/tboss/Dropbox/z rball/IRT/temp working files/irt_portland17_doublesresults.csv' into table results_doubles_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\n';


select * from results_doubles_staging;

delete from results_doubles_staging where winner_p1='Winner Player 1';

-- update results_staging set tmp_date='2016-11-19';

update results_doubles_staging set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

-- select distinct(season) from results order by season;

-- this gets trailing space embedded in the xls data entry.
update results_doubles_staging set season='2025' where season like '2025%';

update results_doubles_staging set season='2020-21' where season like '2020-21%';
update results_doubles_staging set season='2019-20' where season like '2019-20%';
update results_doubles_staging set season='2018-19' where season like '2018-19%';
update results_doubles_staging set season='2017-18' where season like '2017-18%';
update results_doubles_staging set season='2016-17' where season like '2016-17%';
update results_doubles_staging set season='2015-16' where season like '2015-16%';
update results_doubles_staging set season='2014-15' where season like '2014-15%';
update results_doubles_staging set season='2013-14' where season like '2013-14%';
update results_doubles_staging set season='2012-13' where season like '2012-13%';
update results_doubles_staging set season='2011-12' where season like '2011-12%';
update results_doubles_staging set season='2010-11' where season like '2010-11%';
update results_doubles_staging set season='2009-10' where season like '2009-10%';
update results_doubles_staging set season='2008-9' where season like '2008-9%';
update results_doubles_staging set season='2007-8' where season like '2007-8%';
update results_doubles_staging set season='2006-7' where season like '2006-7%';
update results_doubles_staging set season='2005-6' where season like '2005-6%';
update results_doubles_staging set season='2004-5' where season like '2004-5%';
update results_doubles_staging set season='2003-4' where season like '2003-4%';
update results_doubles_staging set season='2002-3' where season like '2002-3%';
update results_doubles_staging set season='2001-2' where season like '2001-2%';
update results_doubles_staging set season='2000-1' where season like '2000-1%';
update results_doubles_staging set season='1999-00' where season like '1999-00%';
update results_doubles_staging set season='1998-9' where season like '1998-9%';
update results_doubles_staging set season='1997-8' where season like '1997-8%';
update results_doubles_staging set season='1996-7' where season like '1996-7%';
update results_doubles_staging set season='1995-6' where season like '1995-6%';
update results_doubles_staging set season='1994-5' where season like '1994-5%';
update results_doubles_staging set season='1993-4' where season like '1993-4%';
update results_doubles_staging set season='1992-3' where season like '1992-3%';
update results_doubles_staging set season='1991-2' where season like '1991-2%';
update results_doubles_staging set season='1990-1' where season like '1990-1%';
update results_doubles_staging set season='1989-90' where season like '1989-90%';
update results_doubles_staging set season='1988-9' where season like '1988-9%';
update results_doubles_staging set season='1987-8' where season like '1987-8%';
update results_doubles_staging set season='1986-7' where season like '1986-7%';
update results_doubles_staging set season='1985-6' where season like '1985-6%';
update results_doubles_staging set season='1984-5' where season like '1984-5%';
update results_doubles_staging set season='1983-4' where season like '1983-4%';
update results_doubles_staging set season='1982-3' where season like '1982-3%';
update results_doubles_staging set season='1981-2' where season like '1981-2%';
update results_doubles_staging set season='1980-1' where season like '1980-1%';
update results_doubles_staging set season='1979-80' where season like '1979-80%';
update results_doubles_staging set season='1978-9' where season like '1978-9%';
update results_doubles_staging set season='1977-8' where season like '1977-8%';
update results_doubles_staging set season='1976-7' where season like '1976-7%';
update results_doubles_staging set season='1975-6' where season like '1975-6%';
update results_doubles_staging set season='1974-5' where season like '1974-5%';
update results_doubles_staging set season='1973-4' where season like '1973-4%';


select * from results_doubles_staging;

-- create table results_doubles_20210210 as select * from results_doubles;
-- create table tourneys_doubles_20210210 as select * from tourneys_doubles;

insert into results_doubles select * from results_doubles_staging;
commit;

-- Main insert query for non-grand slams; change N to Y for a Grand Slam
insert into tourneys_doubles (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'N' from results_doubles_staging;

-- select * from tourneys_doubles order by season asc;
-- update tourneys_doubles set major_flag='Y' where season < '1980';



load data local infile 'c:/temp/irt_siouxfalls2025_doubles_seeding.csv' into table seedings_doubles_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

-- load data local infile 'E:/Dropbox/z rball/IRT/irt_doubles_seedings.csv' into table seedings_doubles_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

-- load data local infile 'C:/Users/tboss/Dropbox/z rball/IRT/temp working files/irt_portland17_doublesresults_seedings.csv' into table seedings_doubles_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\r\n';


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


select * from banner;


delete from banner;
insert into banner values ('IRT Singles Database updated to Sarasota; season complete.  IRT Doubles updated to Denver: season complete','5/7/18');
commit;


-- now post to meetandplay, twitter

St. Louis IRT #racquetball event entered into database; @KingKaneRB over @RockyCarsonRB in 3-gam final win.  http://proracquetballstats.com .

IRT database archive results; found full 128 on archive.org for 1998 US Open and uploaded with 

