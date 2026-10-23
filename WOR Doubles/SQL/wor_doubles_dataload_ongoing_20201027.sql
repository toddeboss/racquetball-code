-- 9/15/13: modifying this for new season, new site

/* Process:
- start Bitvise ssh client
- login to 3essentials site
- minimize window
- start Mysql workbench as normal

*/



/* -------------------------------------------------------- */
-- simple instructions

use cp30725_wor;

SET SQL_SAFE_UPDATES = 0;

create table results_doubles_20201022 as select * from results_doubles;
create table seedings_doubles_20201022 as select * from seedings_doubles;
create table tourneys_doubles_20201022 as select * from tourneys_doubles;

delete from results_doubles_staging;

delete from seedings_doubles_staging;


load data local infile 'c:/temp/wor_doublesfinals_placeholders.csv' into table results_doubles_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

-- load data local infile 'E:/Dropbox/z rball/WOR Doubles/wor_doubles_results.csv' into table results_doubles_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\n';

-- load data local infile 'C:/Users/tboss/Dropbox/z rball/IRT/temp working files/irt_portland17_doublesresults.csv' into table results_doubles_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\n';


select * from results_doubles_staging;

delete from results_doubles_staging where winner_p1='Winner Player 1';

-- update results_staging set tmp_date='2016-11-19';

update results_doubles_staging set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

-- this gets trailing space embedded in the xls data entry.

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
update results_doubles_staging set season='2008-09' where season like '2008-09%';
update results_doubles_staging set season='2007-08' where season like '2007-08%';
update results_doubles_staging set season='2006-07' where season like '2006-07%';
update results_doubles_staging set season='2005-06' where season like '2005-06%';
update results_doubles_staging set season='2004-05' where season like '2004-05%';
update results_doubles_staging set season='2003-04' where season like '2003-04%';
update results_doubles_staging set season='2002-03' where season like '2002-03%';
update results_doubles_staging set season='2001-02' where season like '2001-02%';
update results_doubles_staging set season='2000-01' where season like '2000-01%';
update results_doubles_staging set season='1999-00' where season like '1999-00%';
update results_doubles_staging set season='1998-99' where season like '1998-99%';
update results_doubles_staging set season='1997-98' where season like '1997-98%';
update results_doubles_staging set season='1996-97' where season like '1996-97%';
update results_doubles_staging set season='1995-96' where season like '1995-96%';
update results_doubles_staging set season='1994-95' where season like '1994-95%';
update results_doubles_staging set season='1993-94' where season like '1993-94%';
update results_doubles_staging set season='1992-93' where season like '1992-93%';
update results_doubles_staging set season='1991-92' where season like '1991-92%';
update results_doubles_staging set season='1990-91' where season like '1990-91%';
update results_doubles_staging set season='1989-90' where season like '1989-90%';
update results_doubles_staging set season='1988-89' where season like '1988-89%';
update results_doubles_staging set season='1987-88' where season like '1987-88%';
update results_doubles_staging set season='1986-87' where season like '1986-87%';
update results_doubles_staging set season='1985-86' where season like '1985-86%';
update results_doubles_staging set season='1984-85' where season like '1984-85%';
update results_doubles_staging set season='1983-84' where season like '1983-84%';
update results_doubles_staging set season='1982-83' where season like '1982-83%';
update results_doubles_staging set season='1981-82' where season like '1981-82%';
update results_doubles_staging set season='1980-81' where season like '1980-81%';
update results_doubles_staging set season='1979-80' where season like '1979-80%';
update results_doubles_staging set season='1978-79' where season like '1978-79%';
update results_doubles_staging set season='1977-78' where season like '1977-78%';
update results_doubles_staging set season='1976-77' where season like '1976-77%';
update results_doubles_staging set season='1975-76' where season like '1975-76%';
update results_doubles_staging set season='1974-75' where season like '1974-75%';


update results_doubles_staging set round=99 where round=0;

update results_doubles_staging set round=99 where round='RR';

select * from results_doubles_staging;



insert into results_doubles select * from results_doubles_staging;
commit;





-- Main insert query for non-grand slams; change N to Y for a Grand Slam
insert into tourneys_doubles (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'Y' from results_doubles_staging;

-- no preview/wrap-up links in doubles.  duh
select * from tourneys_doubles order by tmp_date desc;

-- http://blog.proracquetballstats.com/index.php/2019/07/12/2019-wor-outdoor-championships-preview/
-- http://blog.proracquetballstats.com/index.php/2019/07/15/wor-outdoor-nationals-wrap-up/



load data local infile 'c:/temp/wor_vegas17_doubles_seeding.csv' into table seedings_doubles_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

-- load data local infile 'E:/Dropbox/z rball/WOR Doubles/wor_doubles_seedings.csv' into table seedings_doubles_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

-- load data local infile 'C:/Users/tboss/Dropbox/z rball/IRT/temp working files/irt_portland17_doublesresults_seedings.csv' into table seedings_doubles_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\r\n';


select * from seedings_doubles_staging order by seeding;

delete from seedings_doubles_staging where event='Event';

select * from seedings_doubles_staging where player1='?';

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
insert into banner values ('2019 WOR Outdoor Nationals updated.','7/15/19');
commit;


-- now post to meetandplay, twitter


