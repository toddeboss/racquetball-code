/* 1/24/18: this work cleans up different sources for data, then updates the previously truncated source
field in the IRT results table */

desc results;

SET SQL_SAFE_UPDATES = 0;

create table results_20180124 as select * from results;

ALTER TABLE results MODIFY source VARCHAR(500);

drop table results_staging;

create table results_staging as select * from results where 1=2;

truncate table results_staging;

-- do a one-time load of the whole results xls

load data local infile 'e:/Dropbox/z rball/LPRT/lpra_results.csv' into table results_staging
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



-- 5 places in LPRT data where the data does not match; manually clean up.
delete from results_staging_distinct where tmp_date='1996-11-17' and source='http://lindamojer.com/04web_bkup/racqmag/1997/9701/971open.htm';
update results_staging_distinct set source='http://lindamojer.com/04web_bkup/racqmag/1997/9701/971open.htm, http://web.archive.org/web/19970130232709/http://www.irt-tour.com/96wstop4.html' where tmp_date='1996-11-17';

delete from results_staging_distinct where tmp_date='2002-11-24' and source='http://lindamojer.com/04web_bkup/ladiesproracquetball/events/2000/alb_draw.htm';

delete from results_staging_distinct where tmp_date='2006-11-19' and source='Evan Pritchard Research & Data entry';

delete from results_staging_distinct where tmp_date='2008-01-27' and source='Evan Pritchard Research & Data entry';

delete from results_staging_distinct where tmp_date='2008-10-26' and source='Evan Pritchard Research & Data entry';


 

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