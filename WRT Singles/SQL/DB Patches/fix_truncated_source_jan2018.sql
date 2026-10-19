/* 1/24/18: this work cleans up different sources for data, then updates the previously truncated source
field in the results table */

desc results;


SET SQL_SAFE_UPDATES = 0;

create table results_20180124 as select * from results;

ALTER TABLE results MODIFY source VARCHAR(500);


drop table results_staging;

create table results_staging as select * from results where 1=2;

truncate table results_staging;

-- do a one-time load of the whole results xls

load data local infile 'e:/Dropbox/z rball/WRT/wrt_results.csv' into table results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

update results_staging set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

delete from results_staging where winner='Winner';

select * from results_staging;

drop table results_staging_distinct;

create table results_staging_distinct as 
select distinct event, date, tmp_date, source from results_staging order by tmp_date;

select * from results_staging_distinct 
where tmp_date >= '2008-01-01' 
order by tmp_date;

select event,tmp_date,count(*) from results_staging_distinct
group by event,tmp_date having count(*) > 1
order by tmp_date;


-- zero places in WRT data with dups.


commit;

select * from results_staging_distinct;


create table results_tmp as select * from results;


update results_tmp r, results_staging_distinct rd
set r.source=rd.source
where r.event=rd.event
and r.tmp_date=rd.tmp_date;


-- did it work?

select * from results_tmp where tmp_date='2003-11-23';

drop table results_tmp;

-- this is the main update!
update results r, results_staging_distinct rd
set r.source=rd.source
where r.event=rd.event
and r.tmp_date=rd.tmp_date;

commit;

-- it worked!!