/* ongoing irt data load */

use wwwbossconsultingcom;
delete from results_staging;

load data local infile 'c:/temp/irt_dallas.csv' into table results_staging
--load data local infile 'Pro_Results_new.csv' into table results
fields terminated by ',' enclosed by '"' lines terminated by '\n';

select * from results_staging;
delete from results_staging where winner='';
delete from results_staging where winner='winner';

select distinct(date) from results_staging;
update results_staging set tmp_date='1997-06-08' where date='6/8/1997'
update results_staging set tmp_date='1998-05-09' where date='5/9/1998'
update results_staging set tmp_date='1994-11-06' where date='11/6/2004'
update results_staging set date='11/6/1994' where date='11/6/2004'

update results_staging set tmp_date='1995-04-30' where date='4/30/1995'

update results_staging set tmp_date='2005-05-01';

update results_staging set round='8' where round='Q';
update results_staging set round='4' where round='S';
update results_staging set round='2' where round='F';

select distinct(season) from results_staging;
update results_staging set season='1996-7' where season like '1996%';
update results_staging set season='1997-8' where season like '1997%';
update results_staging set season='1994-5' where season like '1994%';

update results_staging set season='2004-5';

insert into results select * from results_staging;
commit;

delete from results_staging;