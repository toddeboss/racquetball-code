/* 1/23/18: this work cleans up different sources for data, then updates the previously truncated source
field in the IRT doubles results table */

desc results_doubles;

SET SQL_SAFE_UPDATES = 0;

drop table results_doubles_20180124 ;

create table results_doubles_20180124 as select * from results_doubles;

ALTER TABLE results_doubles MODIFY source VARCHAR(500);

drop table results_doubles_staging;

create table results_doubles_staging as select * from results_doubles where 1=2;

truncate table results_doubles_staging;

-- do a one-time load of the whole results xls

load data local infile 'E:/Dropbox/z rball/WRT Doubles/wrt_doubles_results.csv' into table results_doubles_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

update results_doubles_staging set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

delete from results_doubles_staging where winner_p1='Winner Player 1';

select * from results_doubles_staging;


drop table results_doubles_staging_distinct;

create table results_doubles_staging_distinct as 
select distinct event, date, tmp_date, source from results_doubles_staging order by tmp_date;

select * from results_doubles_staging_distinct 
-- where tmp_date >= '2003-01-01'  
order by tmp_date;

select event,tmp_date,count(*) from results_doubles_staging_distinct
group by event,tmp_date having count(*) > 1
order by tmp_date;


-- no double entries in doubles data ...
  


select * from results_doubles_staging_distinct;


create table results_doubles_tmp as select * from results_doubles;


update results_doubles_tmp r, results_doubles_staging_distinct rd
set r.source=rd.source
where r.event=rd.event
and r.tmp_date=rd.tmp_date;


-- did it work?

select * from results_doubles_tmp;

drop table results_tmp;

-- this is the main update!
update results_doubles r, results_doubles_staging_distinct rd
set r.source=rd.source
where r.event=rd.event
and r.tmp_date=rd.tmp_date;

commit;

-- it worked!!


select source from results_doubles;