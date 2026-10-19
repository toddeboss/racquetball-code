-- on going working junior data

create table results_20171115 as select * from results;

create table seedings_20171115 as select * from seedings;

create table tourneys_20171115 as select * from tourneys;



select * from tourneys;

select event,date,city,season,tour from results where round='2' order by tmp_date desc,event;


select * from results where event='2017 Canadian Junior Nationals - Boys 16U';

update results set round=99 where round=0;

select * from results where winner='Iwaasa, Alexis';

update results set round=2 where winner='Iwaasa, Alexis' and loser='Fisher, Annie';

select * from results where winner='Prentice, Cassie';

update results set round=2 where winner='Prentice, Cassie' and loser='Wilscam, Camila';

----

select distinct event from results;

All Boys 18U;

select winner,loser,score,city,event,date,season from results 
           where round='2' and event like '%USA Junior Nationals - Boys 18U%' 
           order by season desc, tmp_date desc;


select *  from results where score='5,912),7';

update results set score='5,(12),7' where score='5,912),7';

select * from results where score='(7),7,109';

update results set score='(7),7,10' where score='(7),7,109';


select * from results where event like '2016 Mexico Junior Nationals%';

create table results_20171117 as select * from results;

create table seeding_20171117 as select * from seedings;

create table tourneys_20171117 as select * from tourneys;

SET SQL_SAFE_UPDATES = 0;

delete from results where event like '2016 Mexico Junior Nationals%';

delete from seedings where event like '2016 Mexico Junior Nationals%';

