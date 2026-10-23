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

delete from results_staging;

delete from seedings_staging;

create table results_20210712 as select * from results;
create table seedings_20210712 as select * from seedings;
create table tourneys_20210712 as select * from tourneys;


load data local infile 'c:/temp/wor_vegas23_singles.csv' into table results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

-- load data local infile 'E:/Dropbox/z rball/WOR/wor_results.csv' into table results_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\n';

select * from results_staging;

delete from results_staging where winner='';

-- sometimes t here's round robins in amateurs.
update results_staging set round=99 where round=0;

update results_staging set round=99 where round='RR';


-- update results_staging set tmp_date='2016-11-19';

update results_staging set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

update results_staging set season='2023' where season like '2023%';

update results_staging set season='2019-20' where season like '2019-20%';
update results_staging set season='2018-19' where season like '2018-19%';
update results_staging set season='2017-18' where season like '2017-18%';
update results_staging set season='2016-17' where season like '2016-17%';
update results_staging set season='2015-16' where season like '2015-16%';
update results_staging set season='2014-15' where season like '2014-15%';
update results_staging set season='2013-14' where season like '2013-14%';
update results_staging set season='2012-13' where season like '2012-13%';
update results_staging set season='2011-12' where season like '2011-12%';
update results_staging set season='2010-11' where season like '2010-11%';
update results_staging set season='2009-10' where season like '2009-10%';
update results_staging set season='2008-09' where season like '2008-09%';
update results_staging set season='2007-08' where season like '2007-08%';
update results_staging set season='2006-07' where season like '2006-07%';
update results_staging set season='2005-06' where season like '2005-06%';
update results_staging set season='2004-05' where season like '2004-05%';
update results_staging set season='2003-04' where season like '2003-04%';
update results_staging set season='2002-03' where season like '2002-03%';
update results_staging set season='2001-02' where season like '2001-02%';
update results_staging set season='2000-01' where season like '2000-01%';
update results_staging set season='1999-00' where season like '1999-00%';
update results_staging set season='1998-99' where season like '1998-99%';
update results_staging set season='1997-98' where season like '1997-98%';
update results_staging set season='1996-97' where season like '1996-97%';
update results_staging set season='1995-96' where season like '1995-96%';
update results_staging set season='1994-95' where season like '1994-95%';
update results_staging set season='1993-94' where season like '1993-94%';
update results_staging set season='1992-93' where season like '1992-93%';
update results_staging set season='1991-92' where season like '1991-92%';
update results_staging set season='1990-91' where season like '1990-91%';
update results_staging set season='1989-90' where season like '1989-90%';
update results_staging set season='1988-89' where season like '1988-89%';
update results_staging set season='1987-88' where season like '1987-88%';
update results_staging set season='1986-87' where season like '1986-87%';
update results_staging set season='1985-86' where season like '1985-86%';
update results_staging set season='1984-85' where season like '1984-85%';
update results_staging set season='1983-84' where season like '1983-84%';
update results_staging set season='1982-83' where season like '1982-83%';
update results_staging set season='1981-82' where season like '1981-82%';
update results_staging set season='1980-81' where season like '1980-81%';
update results_staging set season='1979-80' where season like '1979-80%';
update results_staging set season='1978-79' where season like '1978-79%';
update results_staging set season='1977-78' where season like '1977-78%';
update results_staging set season='1976-77' where season like '1976-77%';
update results_staging set season='1975-76' where season like '1975-76%';
update results_staging set season='1974-75' where season like '1974-75%';


select * from results_staging;

insert into results select * from results_staging;
commit;

-- Main insert query for non-grand slams; change N to Y for a Grand Slam
-- ALL WOR events are majors
insert into tourneys (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'Y' from results_staging;

SET SQL_SAFE_UPDATES = 0;

select * from tourneys order by tmp_date desc;

update tourneys set preview_url='https://https://blog.proracquetballstats.com/index.php/2023/10/03/2023-kwm-gutterman-3wallball-preview/' 
 where event like 'KWM Gutterman 2023 3WallBall World Championships%';

update tourneys set wrapup_url='https://blog.proracquetballstats.com/index.php/2023/07/18/49th-outdoor-nationals-recap/'
 where event like '2023 49th Annual Outdoor Nationals%';


load data local infile 'c:/temp/wor_vegas23_singles_seeding.csv' into table seedings_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

-- load data local infile 'C:/Users/tboss/Dropbox/z IT/incoming/rball/backup copies/irt_1999usopen_results_seedings.csv' into table seedings_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

-- load data local infile 'E:/Dropbox/z rball/WOR/wor_seedings.csv' into table seedings_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

-- delete from seedings_staging where event='Event';

select * from seedings_staging order by seeding;

insert into seedings select * from seedings_staging;
commit;

-- no load all doubles, then do ...

-- do name cleanup

delete from wins;
insert into wins
select winner, count(winner) as wins
from results
group by winner;
commit;


select * from banner;

delete from banner;
insert into banner values ('Updated to 2023 3WB Vegas','10/1/23');
commit;


-- now post to meetandplay, twitter


