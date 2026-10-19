-- Fixing Event names from 2025 Mexican Nationals.
-- 8/28/26: issue: all the 2025 mexican junior national event names are 2024 instead of 2025.  need to fix.alter

SET SQL_SAFE_UPDATES = 0;

-- backups first.
create table results_20260828 as select * from results;
create table seedings_20280828 as select * from seedings;
create table tourneys_20260828 as select * from tourneys;

insert into seedings select * from seedings_20280828;

select * from tourneys where date='7/27/2025';

select * from tourneys where event='2024 Mexico Junior Nationals - Boys 21U' and  date='7/27/2025';

update tourneys set event='2025 Mexico Junior Nationals - Boys 21U' where event='2024 Mexico Junior Nationals - Boys 21U' and  date='7/27/2025';
update tourneys set event='2025 Mexico Junior Nationals - Boys 18U' where event='2024 Mexico Junior Nationals - Boys 18U' and  date='7/27/2025';
update tourneys set event='2025 Mexico Junior Nationals - Boys 16U' where event='2024 Mexico Junior Nationals - Boys 16U' and  date='7/27/2025';
update tourneys set event='2025 Mexico Junior Nationals - Boys 14U' where event='2024 Mexico Junior Nationals - Boys 14U' and  date='7/27/2025';
update tourneys set event='2025 Mexico Junior Nationals - Boys 12U' where event='2024 Mexico Junior Nationals - Boys 12U' and  date='7/27/2025';
update tourneys set event='2025 Mexico Junior Nationals - Boys 10U' where event='2024 Mexico Junior Nationals - Boys 10U' and  date='7/27/2025';
update tourneys set event='2025 Mexico Junior Nationals - Boys 10Udb' where event='2024 Mexico Junior Nationals - Boys 10Udb' and  date='7/27/2025';
update tourneys set event='2025 Mexico Junior Nationals - Boys 8U' where event='2024 Mexico Junior Nationals - Boys 8U' and  date='7/27/2025';
update tourneys set event='2025 Mexico Junior Nationals - Boys 8Umb' where event='2024 Mexico Junior Nationals - Boys 8Umb' and  date='7/27/2025';
update tourneys set event='2025 Mexico Junior Nationals - Boys 6Umb' where event='2024 Mexico Junior Nationals - Boys 6Umb' and  date='7/27/2025';
update tourneys set event='2025 Mexico Junior Nationals - Girls 21U' where event='2024 Mexico Junior Nationals - Girls 21U' and  date='7/27/2025';
update tourneys set event='2025 Mexico Junior Nationals - Girls 18U' where event='2024 Mexico Junior Nationals - Girls 18U' and  date='7/27/2025';
update tourneys set event='2025 Mexico Junior Nationals - Girls 16U' where event='2024 Mexico Junior Nationals - Girls 16U' and  date='7/27/2025';
update tourneys set event='2025 Mexico Junior Nationals - Girls 14U' where event='2024 Mexico Junior Nationals - Girls 14U' and  date='7/27/2025';
update tourneys set event='2025 Mexico Junior Nationals - Girls 12U' where event='2024 Mexico Junior Nationals - Girls 12U' and  date='7/27/2025';
update tourneys set event='2025 Mexico Junior Nationals - Girls 10U' where event='2024 Mexico Junior Nationals - Girls 10U' and  date='7/27/2025';
update tourneys set event='2025 Mexico Junior Nationals - Girls 10Udb' where event='2024 Mexico Junior Nationals - Girls 10Udb' and  date='7/27/2025';
update tourneys set event='2025 Mexico Junior Nationals - Girls 8Umb' where event='2024 Mexico Junior Nationals - Girls 8Umb' and  date='7/27/2025';


select * from results where date='7/27/2025';

select * from results where event='2024 Mexico Junior Nationals - Boys 21U' and  date='7/27/2025';

update results set event='2025 Mexico Junior Nationals - Boys 21U' where event='2024 Mexico Junior Nationals - Boys 21U' and  date='7/27/2025';
update results set event='2025 Mexico Junior Nationals - Boys 18U' where event='2024 Mexico Junior Nationals - Boys 18U' and  date='7/27/2025';
update results set event='2025 Mexico Junior Nationals - Boys 16U' where event='2024 Mexico Junior Nationals - Boys 16U' and  date='7/27/2025';
update results set event='2025 Mexico Junior Nationals - Boys 14U' where event='2024 Mexico Junior Nationals - Boys 14U' and  date='7/27/2025';
update results set event='2025 Mexico Junior Nationals - Boys 12U' where event='2024 Mexico Junior Nationals - Boys 12U' and  date='7/27/2025';
update results set event='2025 Mexico Junior Nationals - Boys 10U' where event='2024 Mexico Junior Nationals - Boys 10U' and  date='7/27/2025';
update results set event='2025 Mexico Junior Nationals - Boys 10Udb' where event='2024 Mexico Junior Nationals - Boys 10Udb' and  date='7/27/2025';
update results set event='2025 Mexico Junior Nationals - Boys 8U' where event='2024 Mexico Junior Nationals - Boys 8U' and  date='7/27/2025';
update results set event='2025 Mexico Junior Nationals - Boys 8Umb' where event='2024 Mexico Junior Nationals - Boys 8Umb' and  date='7/27/2025';
update results set event='2025 Mexico Junior Nationals - Boys 6Umb' where event='2024 Mexico Junior Nationals - Boys 6Umb' and  date='7/27/2025';
update results set event='2025 Mexico Junior Nationals - Girls 21U' where event='2024 Mexico Junior Nationals - Girls 21U' and  date='7/27/2025';
update results set event='2025 Mexico Junior Nationals - Girls 18U' where event='2024 Mexico Junior Nationals - Girls 18U' and  date='7/27/2025';
update results set event='2025 Mexico Junior Nationals - Girls 16U' where event='2024 Mexico Junior Nationals - Girls 16U' and  date='7/27/2025';
update results set event='2025 Mexico Junior Nationals - Girls 14U' where event='2024 Mexico Junior Nationals - Girls 14U' and  date='7/27/2025';
update results set event='2025 Mexico Junior Nationals - Girls 12U' where event='2024 Mexico Junior Nationals - Girls 12U' and  date='7/27/2025';
update results set event='2025 Mexico Junior Nationals - Girls 10U' where event='2024 Mexico Junior Nationals - Girls 10U' and  date='7/27/2025';
update results set event='2025 Mexico Junior Nationals - Girls 10Udb' where event='2024 Mexico Junior Nationals - Girls 10Udb' and  date='7/27/2025';
update results set event='2025 Mexico Junior Nationals - Girls 8Umb' where event='2024 Mexico Junior Nationals - Girls 8Umb' and  date='7/27/2025';

-- seedings is more problematic: can't do this via sql, have to do it by re-loading the raw data.
select * from seedings where event='2025 Mexico Junior Nationals - Boys 21U' order by seeding;

-- first we have to delete all the 2024 data, which has duplicates

delete from seedings where event='2024 Mexico Junior Nationals - Boys 21U';
delete from seedings where event='2024 Mexico Junior Nationals - Boys 18U';
delete from seedings where event='2024 Mexico Junior Nationals - Boys 16U';
delete from seedings where event='2024 Mexico Junior Nationals - Boys 14U';
delete from seedings where event='2024 Mexico Junior Nationals - Boys 12U';
delete from seedings where event='2024 Mexico Junior Nationals - Boys 10U';
delete from seedings where event='2024 Mexico Junior Nationals - Boys 10Udb';
delete from seedings where event='2024 Mexico Junior Nationals - Boys 8U';
delete from seedings where event='2024 Mexico Junior Nationals - Boys 8Umb';
delete from seedings where event='2024 Mexico Junior Nationals - Boys 6Umb';
delete from seedings where event='2024 Mexico Junior Nationals - Girls 21U';
delete from seedings where event='2024 Mexico Junior Nationals - Girls 18U';
delete from seedings where event='2024 Mexico Junior Nationals - Girls 16U';
delete from seedings where event='2024 Mexico Junior Nationals - Girls 14U';
delete from seedings where event='2024 Mexico Junior Nationals - Girls 12U';
delete from seedings where event='2024 Mexico Junior Nationals - Girls 10U';
delete from seedings where event='2024 Mexico Junior Nationals - Girls 10Udb';
delete from seedings where event='2024 Mexico Junior Nationals - Girls 8Umb';

-- now reload 2024's seeding

truncate table seedings_staging;

load data local infile 'c:/Dropbox/z IT/temp/juniors_2024mexico_seeding.csv' into table seedings_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

select * from seedings_staging order by seeding;

insert into seedings select * from seedings_staging;
commit;

-- now, edit the 2025 file and correct it; changed all 2024 to 2025 in file.

delete from seedings where event='2025 Mexico Junior Nationals - Boys 21U';
delete from seedings where event='2025 Mexico Junior Nationals - Boys 18U';
delete from seedings where event='2025 Mexico Junior Nationals - Boys 16U';
delete from seedings where event='2025 Mexico Junior Nationals - Boys 14U';
delete from seedings where event='2025 Mexico Junior Nationals - Boys 12U';
delete from seedings where event='2025 Mexico Junior Nationals - Boys 10U';
delete from seedings where event='2025 Mexico Junior Nationals - Boys 10Udb';
delete from seedings where event='2025 Mexico Junior Nationals - Boys 8U';
delete from seedings where event='2025 Mexico Junior Nationals - Boys 8Umb';
delete from seedings where event='2025 Mexico Junior Nationals - Boys 6Umb';
delete from seedings where event='2025 Mexico Junior Nationals - Girls 21U';
delete from seedings where event='2025 Mexico Junior Nationals - Girls 18U';
delete from seedings where event='2025 Mexico Junior Nationals - Girls 16U';
delete from seedings where event='2025 Mexico Junior Nationals - Girls 14U';
delete from seedings where event='2025 Mexico Junior Nationals - Girls 12U';
delete from seedings where event='2025 Mexico Junior Nationals - Girls 10U';
delete from seedings where event='2025 Mexico Junior Nationals - Girls 10Udb';
delete from seedings where event='2025 Mexico Junior Nationals - Girls 8Umb';



truncate table seedings_staging;

load data local infile 'c:/Dropbox/z IT/temp/juniors_2025mexico_seedings.csv' into table seedings_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

select * from seedings_staging order by seeding;

insert into seedings select * from seedings_staging;
commit;




-- qa

select * from seedings where event='2025 Mexico Junior Nationals - Boys 21U' order by seeding;

select * from seedings where event='2024 Mexico Junior Nationals - Boys 21U' order by seeding;


-- looks good!