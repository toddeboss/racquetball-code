/* ongoing wprodata load */

use wwwbossconsultingcom;
delete from wpro_results_staging;
/* remember local!!! */

--load data local infile 'c:/temp/irt_memphis05.csv' into table wpro_results_staging
--load data local infile 'Pro_wpro_results_new.csv' into table wpro_results
--load data local infile 'irt_nycriverside0506.csv' into table wpro_results_staging
load data local infile 'c:/temp/wpro_catchup.csv' into table wpro_results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

select * from wpro_results_staging;
delete from wpro_results_staging where winner='';
delete from wpro_results_staging where winner='winner';

select distinct(date) from wpro_results_staging;

update wpro_results_staging set tmp_date='2010-04-11' where date='4/11/2010';
update wpro_results_staging set tmp_date='2010-04-25' where date='4/25/2010';
update wpro_results_staging set tmp_date='2010-05-09' where date='5/9/2010';

update wpro_results_staging set tmp_date='2010-03-14';

update wpro_results_staging set round='8' where round='Q';
update wpro_results_staging set round='4' where round='S';
update wpro_results_staging set round='2' where round='F';

select distinct(season) from wpro_results_staging;
update wpro_results_staging set season='1996-7' where season like '1996%';
update wpro_results_staging set season='1997-8' where season like '1997%';
update wpro_results_staging set season='1994-5' where season like '1994%';

update wpro_results_staging set season='2009-10' where season like '2009%';

update wpro_results_staging set season='2009-10';

update wpro_results_staging set source='www.irt-tour.com' where event='2008 Kansas City IRT Pro-Am';

select * from wpro_results_staging;

insert into wpro_results select * from wpro_results_staging;
commit;


select * from wpro_results where tmp_date is not null
order by tmp_date, round desc;

-- New: must populate tourneys table as well.

select * from wpro_tourneys order by tmp_date desc;

insert into wpro_tourneys (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'N' from wpro_results_staging;

-- onetime from new data population
insert into wpro_tourneys (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'N' from wpro_results where date is null
--where tmp_date not in ('2009-09-27','2009-04-26')
where date not null

update wpro_tourneys set major_flag='Y' where event='WPRO Ektelon World Championships 2010';
-- re-populate winners talbe to get updated frequent players.

select * from wpro_wins order by wins desc;

delete from wpro_wins;
insert into wpro_wins
select winner, count(winner) as wins
from wpro_results
group by winner;
commit;



-- last step: clear out wpro_results_staging for next.
delete from wpro_results_staging;