-- 9/15/13: modifying this for new season, new site

/* Process:
- start Bitvise ssh client
- login to 3essentials site
- minimize window
- start Mysql workbench as normal

*/



/* -------------------------------------------------------- */
-- simple instructions

use cp30725_junior;

SET SQL_SAFE_UPDATES = 0;

create table results_20260629 as select * from results;
create table seedings_20260629 as select * from seedings;
create table tourneys_20260629 as select * from tourneys;

delete from results_staging;

delete from seedings_staging;


load data local infile 'c:/Dropbox/z IT/temp/juniors_2026_usa_singles.csv' into table results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

/*
load data local infile 'C:/Users/tboss/Dropbox/z IT/incoming/rball/backup copies/juniors20162015_results.csv' into table results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'C:/Users/tboss/Dropbox/z rball/Juniors/Tourney Research/juniors_2013-2014_results.csv' into table results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';
*/

select * from results_staging;

-- if double elimination and no RRS ... can do this:

-- delete from results_staging where round=0;


select * from results_staging;


-- sometimes there's round robins in amateurs.
update results_staging set round=99 where round=0;

update results_staging set round=99 where round='RR';

delete from results_staging where winner=' ';

-- update results_staging set tmp_date='2016-11-19';

update results_staging set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

update results_staging set season='2026' where season like '2026%';

update results_staging set season='2020' where season like '2020%';
update results_staging set season='2019' where season like '2019%';
update results_staging set season='2018' where season like '2018%';
update results_staging set season='2017' where season like '2017%';
update results_staging set season='2016' where season like '2016%';
update results_staging set season='2015' where season like '2015%';
update results_staging set season='2014' where season like '2014%';
update results_staging set season='2013' where season like '2013%';
update results_staging set season='2012' where season like '2012%';
update results_staging set season='2011' where season like '2011%';
update results_staging set season='2010' where season like '2010%';
update results_staging set season='2009' where season like '2009%';
update results_staging set season='2008' where season like '2008%';
update results_staging set season='2007' where season like '2007%';
update results_staging set season='2006' where season like '2006%';
update results_staging set season='2005' where season like '2005%';
update results_staging set season='2004' where season like '2004%';
update results_staging set season='2003' where season like '2003%';
update results_staging set season='2002' where season like '2002%';
update results_staging set season='2001' where season like '2001%';
update results_staging set season='2000' where season like '2000%';
update results_staging set season='1999' where season like '1999%';
update results_staging set season='1998' where season like '1998%';
update results_staging set season='1997' where season like '1997%';
update results_staging set season='1996' where season like '1996%';
update results_staging set season='1995' where season like '1995%';
update results_staging set season='1994' where season like '1994%';
update results_staging set season='1993' where season like '1993%';
update results_staging set season='1992' where season like '1992%';
update results_staging set season='1991' where season like '1991%';
update results_staging set season='1990' where season like '1990%';
update results_staging set season='1989' where season like '1989%';
update results_staging set season='1988' where season like '1988%';
update results_staging set season='1987' where season like '1987%';
update results_staging set season='1986' where season like '1986%';
update results_staging set season='1985' where season like '1985%';
update results_staging set season='1984' where season like '1984%';
update results_staging set season='1983' where season like '1983%';
update results_staging set season='1982' where season like '1982%';
update results_staging set season='1981' where season like '1981%';
update results_staging set season='1980' where season like '1980%';
update results_staging set season='1979' where season like '1979%';
update results_staging set season='1978' where season like '1978%';
update results_staging set season='1977' where season like '1977%';
update results_staging set season='1976' where season like '1976%';
update results_staging set season='1975' where season like '1975%';
update results_staging set season='1974' where season like '1974%';
update results_staging set season='1973' where season like '1973%';
update results_staging set season='1972' where season like '1972%';
update results_staging set season='1971' where season like '1971%';

-- create table results_20181120 as select * from results;

select * from results_staging;

insert into results select * from results_staging;
commit;

-- Main insert query for non-grand slams; change N to Y for a Grand Slam
insert into tourneys (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'N' from results_staging;


SET SQL_SAFE_UPDATES = 0;

select * from tourneys order by tmp_date desc;

-- select * from tourneys where event like '2019 USA Junior%';

SET SQL_SAFE_UPDATES = 0;

update tourneys set preview_url='xxx' 
 where event like '2021 USA Junior%';

update tourneys set wrapup_url='https://blog.proracquetballstats.com/index.php/2024/12/16/2024-irf-junior-worlds-recap/'
 where event like '2024 Junior World Championships%';





load data local infile 'c:/Dropbox/z IT/temp/juniors_2026_usa_singles_seeding.csv' into table seedings_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

/*
load data local infile 'C:/Users/tboss/Dropbox/z IT/incoming/rball/backup copies/juniors20162015_results_seedings.csv' into table seedings_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
load data local infile 'C:/Users/tboss/Dropbox/z rball/Juniors/Tourney Research/juniors_2013-2014_results_seedings.csv' into table seedings_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
*/

select * from seedings_staging order by seeding;

delete from seedings_staging where event='Event';

delete from seedings_staging where event=' ';


-- select * from seedings where event like '2019 Mexic%';

insert into seedings select * from seedings_staging;
commit;


-- do doubles load

-- do name cleanup





delete from wins;
insert into wins
select winner, count(winner) as wins
from results
group by winner;
commit;


delete from banner;
insert into banner values ('2026 USA Junior Nationals loaded','6/29/26');
commit;

select * from banner;


-- now post to meetandplay, twitter, reddit, FB, etc


