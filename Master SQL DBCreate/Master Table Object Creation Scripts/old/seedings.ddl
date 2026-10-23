use wwwbossconsultingcom;

drop table seedings;

create table seedings
(event varchar(255),
seeding integer,
player varchar(50)
);

truncate table seedings;

-- initial load
load data local infile 'c:/z rball/irt/irt_seedings.csv' into table seedings
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

-- ongoing load
load data local infile 'c:/temp/irt_kc2010_seedings.csv' into table seedings
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

delete from seedings where event="event";
delete from seedings where seeding=0;

select * from seedings;


select tour,city,date,source,season from results 
where event='2010 Kansas City Pro/Am' and round='2' and date='9/12/2010';

select winner, s1.seeding as winner_seed,loser, s2.seeding as loser_seed,round,score 
from results r, seedings s1, seedings s2
where r.winner = s1.player
and r.loser = s2.player
and s1.event=r.event
and s2.event=r.event
and r.event='2010 Kansas City Pro/Am' and r.date='9/12/2010' order by r.tmp_date,r.round desc;


select winner, s1.seeding as winner_seed,loser, s2.seeding as loser_seed,round,score 
from results r
left join seedings s1 on r.winner = s1.player and s1.event=r.event
left join seedings s2 on r.loser = s2.player and s2.event=r.event 
where r.event='2010 IRT Mexico Open'
and r.date='4/18/2010' 
order by r.tmp_date,r.round desc;


and s1.event='2010 IRT Mexico Open'
and s2.event='2010 IRT Mexico Open'


------------------------------

create table seedings_staging as select * from seedings;

