-- 12/5/16: duplicate round of 256 for 2010 us open somehow; here is cleanup.


use cp30725_men;

SET SQL_SAFE_UPDATES = 0;

create table results_pre15thUSOpenfix as select * from results;

select * from results where event='15th Annual US Open' and round=256 order by winner;

select distinct winner,loser, round,score,tour,city,event,date,source,season,notes,tmp_date from results where event='15th Annual US Open' and round=256 order by winner;

create table uniq256 as 
select distinct winner,loser, round,score,tour,city,event,date,source,season,notes,tmp_date from results where event='15th Annual US Open' and round=256 order by winner;

delete from results where event='15th Annual US Open' and round=256;

insert into results select * from uniq256;

commit;

select * from results where event='15th Annual US Open' and round=256 order by winner;

drop table uniq256;