-- 10/13/17: amateur ongoing data load file

/* Process:
- start Bitvise ssh client
- login to 3essentials site
- minimize window
- start Mysql workbench as normal

*/


/* -------------------------------------------------------- */
-- simple instructions

use cp30725_amateur;

SET SQL_SAFE_UPDATES = 0;

select  * from results_staging;

delete from results_staging;

delete from seedings_staging;

create table results_20220404 as select * from results;
create table tourneys_20220404 as select * from tourneys;
create table seedings_20220404 as select * from seedings;

load data local infile 'c:/temp/mexico_2022_singles.csv' into table results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

-- load data local infile 'e:/Dropbox/z rball/Amateur/mexico_2018nationals_results.csv' into table results_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\n';

-- load data local infile 'C:/Users/tboss/Dropbox/z rball/Amateurs/Tourney Research/amateur_canada1995-1981nationals_results.csv' into table results_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\n';


select * from results_staging;

-- delete from results_staging where round=0;

-- update results_staging set tmp_date='2016-11-19';


update results_staging set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');


update results_staging set season='2022' where season like '2022%';

update results_staging set season='2021' where season like '2021%';
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
update results_staging set season='1991' where season like '1992%';
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

update results_staging set season='1973' where season like '1973%';


-- sometimes there's round robins in amateurs.
update results_staging set round=99 where round=0;

select * from results_staging;


insert into results select * from results_staging;
commit;

-- Main insert query for non-grand slams; change N to Y for a Grand Slam
insert into tourneys (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'N' from results_staging;

SET SQL_SAFE_UPDATES = 0;

select * from tourneys order by tmp_date desc;

update tourneys set preview_url='https://blog.proracquetballstats.com/index.php/2022/03/30/campeonato-nacional-selectivo-mexico-2022-preview-part-1-singles/' 
 where event like '2022 Campeonato Nacional%';

update tourneys set wrapup_url='https://blog.proracquetballstats.com/index.php/2022/04/04/mexican-nationals-recap/'
 where event like '2022 Campeonato Nacional%';



-- Now Seeding



load data local infile 'c:/temp/mexico_2022_singles_seeding.csv' into table seedings_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

-- load data local infile 'e:/Dropbox/z rball/Amateur/mexico_2018nationals_results_seedings.csv' into table seedings_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

-- load data local infile 'C:/Users/tboss/Dropbox/z rball/Amateurs/Tourney Research/amateur_canada2001-1996nationals_results_seedings.csv' into table seedings_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\r\n';


select * from seedings_staging order by seeding;

-- delete from seedings_staging where event='Event';

insert into seedings select * from seedings_staging;
commit;

-- now run doubles

-- now run names cleansing



delete from wins;
insert into wins
select winner, count(winner) as wins
from results
group by winner;
commit;




delete from banner;
insert into banner values ('Latest update: Mexican Nationals 2022 loaded','4/4/22');
commit;


-- select count(*) from results;

-- now post to meetandplay, twitter, Facebook groups, 40x20, reddit, wherever


