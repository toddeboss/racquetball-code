/* 1/23/18: this work cleans up different sources for data, then updates the previously truncated source
field in the IRT results table */

desc results;

create table results_20180123 as select * from results;

ALTER TABLE results MODIFY source VARCHAR(500);

drop table results_staging;

create table results_staging as select * from results where 1=2;

truncate table results_staging;

-- do a one-time load of the whole results xls

load data local infile 'C:/Users/tboss/Dropbox/z rball/IRT/irt_results.csv' into table results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

update results_staging set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

select * from results_staging;

drop table results_staging_distinct;

create table results_staging_distinct as 
select distinct event, date, tmp_date, source from results_staging order by tmp_date;

select * from results_staging_distinct where tmp_date >= '2003-01-01' order by tmp_date;

select event,tmp_date,count(*) from results_staging_distinct
group by event,tmp_date having count(*) > 1
order by tmp_date;



-- 17 places where the data does not match; manually clean up.
delete from results_staging_distinct where tmp_date='1983-12-11' and source='IR 2,5 P22';
update results_staging_distinct set source='IR 2,1 P31, IR 2,5 P22' where tmp_date='1983-12-11';

delete from results_staging_distinct where tmp_date='1984-11-01' and source='Scott Hirsch';
update results_staging_distinct set source='IR 3,1 P32 plus Scott Hirsch input' where tmp_date='1984-11-01';

delete from results_staging_distinct where tmp_date='1990-09-30' and source='John Mercante';
update results_staging_distinct set source='Killshot Aug 91 v1n1 plus John Mercante input' where tmp_date='1990-09-30';

delete from results_staging_distinct where tmp_date='1990-10-21' and source='Killshot Aug 91 v1n1';
update results_staging_distinct set source='Killshot Aug 91 v1n1, Racquetball USA Nov-dec 90 v1 n2' where tmp_date='1990-10-21';

delete from results_staging_distinct where tmp_date='1991-02-01' and source='Killshot Aug 91 v1n1';
update results_staging_distinct set source='Killshot Aug 91 v1n1, RM May-Jun 91 v2 n3' where tmp_date='1991-02-01';

delete from results_staging_distinct where tmp_date='1992-01-13' and source='Killshot Jan/Feb/Mar 91 v2n1';
update results_staging_distinct set source='Killshot Jan/Feb/Mar 91 v2n1, RM v3 n3' where tmp_date='1992-01-13';

delete from results_staging_distinct where tmp_date='1992-01-01' and source='RM v3 n3';
update results_staging_distinct set source='Killshot Sept/Oct 92 v2n2, RM v3 n3' where tmp_date='1992-01-01';

delete from results_staging_distinct where tmp_date='1996-11-17' and source='Racquetball Magazine Jan/Feb 97 v8n1';
update results_staging_distinct set 
  source = 'Racquetball Magazine Jan/Feb 97 v8n1, http://lindamojer.com/04web_bkup/racqmag/1997/9701/971open.htm' 
    where tmp_date = '1996-11-17';
    
delete from results_staging_distinct where tmp_date='1998-05-09' and source='Brian Simpson printouts/archive.org';
update results_staging_distinct set 
  source = 'Racquetball Magazine July-Aug 1998 v9n4, archive.org, Brian Simpson printouts'  where tmp_date = '1998-05-09';    

delete from results_staging_distinct where tmp_date='1998-06-07' and source='Racquetball Magazine Sept/Oct 98 v9n5';
update results_staging_distinct set 
  source = 'Racquetball Magazine Sept/Oct 98 v9n5, archive.org'  where tmp_date = '1998-06-07';    

delete from results_staging_distinct where tmp_date='1998-10-11' and source='Racquetball Magazine Jan/Feb 99 v10n1';
update results_staging_distinct set 
  source = 'Racquetball Magazine Jan/Feb 99 v10n1, archive.org'  where tmp_date = '1998-10-11';  
  
delete from results_staging_distinct where tmp_date='1998-11-15' and source='Racquetball Magazine Jan/Feb 99 v10n1';
update results_staging_distinct set 
  source = 'Racquetball Magazine Jan/Feb 99 v10n1, http://web.archive.org/web/19990429044115/http://www.racqmag.com/racqmag/news98/98open2.htm' 
  where tmp_date = '1998-11-15';    
  
delete from results_staging_distinct where tmp_date='1999-01-17' and source='Racquetball Magazine Mar/Arp 99 v10n2';
update results_staging_distinct set 
  source = 'Racquetball Magazine Mar/Arp 99 v10n2, archive.org' 
  where tmp_date = '1999-01-17';     
  
delete from results_staging_distinct where tmp_date='2000-11-19' and source='IRT Web Page';
update results_staging_distinct set 
  source = 'IRT Web Page at the time plus Jeff Oliver Tennis information printouts for qualifiers' 
  where tmp_date = '2000-11-19';     
  
delete from results_staging_distinct where tmp_date='2001-11-20' and source='Tennisinformation.com';
update results_staging_distinct set 
  source = 'Tennisinformation.com at the time plus Jeff Oliver Tennis information printouts for qualifiers' 
  where tmp_date = '2001-11-20';     
  
delete from results_staging_distinct where tmp_date='2002-11-24' and source='US Open Web Page';
update results_staging_distinct set 
  source = 'US Open Web Page at the time plus Jeff Oliver Tennis information printouts for qualifiers' 
  where tmp_date = '2002-11-24';        
  
  
delete from results_staging_distinct where tmp_date='2003-11-23' and source='IRT Web Page';
update results_staging_distinct set 
  source = 'IRT Web Page at the time plus Jeff Oliver Tennis information printouts for qualifiers' 
  where tmp_date = '2003-11-23';   

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