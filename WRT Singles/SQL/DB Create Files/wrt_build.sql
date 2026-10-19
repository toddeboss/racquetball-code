-- Initial WRT Data Laod

use cp30725_wrt;

SET SQL_SAFE_UPDATES = 0;

delete from results_staging;

delete from seedings_staging;

load data local infile 'd:/Dropbox/z rball/WRT/wrt_results.csv' into table results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

select * from results_staging;

delete from results_staging where winner='Winner';

select distinct(date) from results_staging; -- copy this off to an xls, make the following update statements

update results_staging set tmp_date='2012-10-28' where date='10/28/2012';
update results_staging set tmp_date='2013-5-26' where date='5/26/2013';
update results_staging set tmp_date='2013-6-9' where date='6/9/2013';
update results_staging set tmp_date='2013-6-23' where date='6/23/2013';
update results_staging set tmp_date='2013-12-14' where date='12/14/2013';
update results_staging set tmp_date='2014-3-3' where date='3/3/2014';
update results_staging set tmp_date='2014-7-13' where date='7/13/2014';
update results_staging set tmp_date='2014-8-24' where date='8/24/2014';
update results_staging set tmp_date='2014-8-31' where date='8/31/2014';
update results_staging set tmp_date='2014-9-7' where date='9/7/2014';
update results_staging set tmp_date='2014-10-5' where date='10/5/2014';
update results_staging set tmp_date='2014-11-30' where date='11/30/2014';
update results_staging set tmp_date='2014-12-7' where date='12/7/2014';
update results_staging set tmp_date='2015-1-18' where date='1/18/2015';
update results_staging set tmp_date='2015-1-25' where date='1/25/2015';
update results_staging set tmp_date='2015-2-22' where date='2/22/2015';
update results_staging set tmp_date='2015-3-1' where date='3/1/2015';
update results_staging set tmp_date='2015-5-3' where date='5/3/2015';
update results_staging set tmp_date='2015-5-9' where date='5/9/2015';
update results_staging set tmp_date='2015-6-21' where date='6/21/2015';
update results_staging set tmp_date='2015-8-16' where date='8/16/2015';
update results_staging set tmp_date='2015-9-13' where date='9/13/2015';
update results_staging set tmp_date='2015-9-20' where date='9/20/2015';
update results_staging set tmp_date='2015-11-1' where date='11/1/2015';
update results_staging set tmp_date='2015-11-8' where date='11/8/2015';
update results_staging set tmp_date='2015-11-22' where date='11/22/2015';
update results_staging set tmp_date='2015-12-6' where date='12/6/2015';
update results_staging set tmp_date='2015-12-13' where date='12/13/2015';
update results_staging set tmp_date='2016-1-17' where date='1/17/2016';
update results_staging set tmp_date='2016-2-21' where date='2/21/2016';
update results_staging set tmp_date='2016-4-24' where date='4/24/2016';
update results_staging set tmp_date='2016-5-15' where date='5/15/2016';
update results_staging set tmp_date='2016-9-18' where date='9/18/2016';
update results_staging set tmp_date='2016-10-30' where date='10/30/2016';
update results_staging set tmp_date='2016-11-6' where date='11/6/2016';

select distinct(season) from results_staging;

update results_staging set season='2016-17' where season='2016-17';

insert into results select * from results_staging;
commit;

----------------------

load data local infile 'd:/Dropbox/z rball/WRT/wrt_seedings.csv' into table seedings_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

select * from seedings_staging;

delete from seedings_staging where event='Tourney';

insert into seedings select * from seedings_staging;
commit;


------------

-- Main insert query for non-grand slams; change N to Y for a Grand Slam
insert into tourneys (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'N' from results;

------------------

delete from wins;
insert into wins
select winner, count(winner) as wins
from results
group by winner;
commit;


-------------------


-- Data entry issues.

select * from results where score='(13)8,1';

update results set score='(13),8,1' where score='(13)8,1';

commit;