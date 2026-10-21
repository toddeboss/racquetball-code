-- Various IRT data updates Dec 2016 - Jan 2017.

-- Also includes diagnostic code while doing development and bug fixing in report code.


use cp30725_men;

SET SQL_SAFE_UPDATES = 0;

select * from rankings where player like 'Soto%';

select * from results where event='12th Annual Holiday Pro-Am';

select * from tourneys where event='12th Annual Holiday Pro-Am';


select * from results where event='CityFed Grand Nationals' and date='5/1/1988';

select * from results where event='Promus Hotels 3rd US Open';

create table results_20161230 as select * from results;

delete from results where event='Promus Hotels 3rd US Open';

select * from tourneys where event='Promus Hotels 3rd US Open';


select * from results where city like 'Tijuana%';

select * from results where loser='Scott, Charlie';

update results set loser='Scott, John' where loser='Scott, Charlie';

select count(*) from results;

select * from results where round=4 and winner='Swain, Cliff' order by tmp_date;

select * from results where event='21st United Healthcare US Open';

update results set score='(8),1,5,wbf-inj' where event='21st United Healthcare US Open' and round=8 and winner='De La Rosa, Daniel';

call sp_fixname('Rojas, Daniel (Mauro)','Rojas, Mauro');

call sp_fixname('Rojas, Daniel (Mauro)','Rojas, David');

call sp_fixname('Rojas, Daniel (Mauro)','Rojas, Daniel');


select * from seedings where event='2017 Coast to Coast California Open';

select * from results where event='Milwaukee 75';

update results set event='1975 Milwaukee Pro-Am' where event='Milwaukee 75';

update tourneys set event='1975 Milwaukee Pro-Am' where event='Milwaukee 75';

update seedings set event='1975 Milwaukee Pro-Am' where event='Milwaukee 75';


select * from results where event='Denver 75';

create table results_20170111 as select * from results;


update results set loser='Banisky, ?' where event='Denver 75' and round=32 and winner='Brumfield, Charlie';



select * from results where event='Tulsa Open';

update results set event='Tulsa Open 85' where event='Tulsa Open' and tmp_date='1985-02-10';

update results set event='Tulsa Open 86' where event='Tulsa Open' and tmp_date='1986-02-01';

update results set event='Tulsa Open 87' where event='Tulsa Open' and tmp_date='1987-02-01';

update seedings set event='Tulsa Open 85' where event='Tulsa Open';

select * from results where event='Halloween Classic';

update results set event='Halloween Classic 00' where event='Halloween Classic' and tmp_date='2000-10-29';

update results set event='Halloween Classic 01' where event='Halloween Classic' and tmp_date='2001-10-28';

update results set event='Halloween Classic 02' where event='Halloween Classic' and tmp_date='2002-11-03';

update results set event='Halloween Classic 03' where event='Halloween Classic' and tmp_date='2003-11-02';

update results set event='Halloween Classic 00' where event='Halloween Classic' and tmp_date='2000-10-29';


select * from results where event='Foxwoods Pro-Am';

update results set event='Foxwoods Pro-Am 97' where event='Foxwoods Pro-Am' and tmp_date='1997-11-23';

update results set event='Foxwoods Pro-Am 01' where event='Foxwoods Pro-Am' and tmp_date='2001-02-04';

update results set event='Foxwoods Pro-Am 02' where event='Foxwoods Pro-Am' and tmp_date='2002-01-27';






select winner,event_tmp_date from results where round=2 order by tmp_date;

select winner,loser,score,city,event,date,tmp_date,season from results where round='2' order by season, tmp_date;

select distinct event,tmp_date from results order by event;

select winner,loser,round,score,tour,city,event,date,season,notes 
              from results where winner='Waselenchuk, Kane' and tmp_date='2017-01-08' and event='2017 Coast to Coast California Open' 
              order by round desc;
              
              
select loser, count(loser) from results where winner='Rojas, Jose' group by loser;

select winner, count(winner) from results where loser='Rojas, Jose' group by winner;           

select * from results where winner='Rojas, Jose' and loser='Landa, Alejandro';

select * from results where loser='Rojas, Jose' and winner='Landa, Alejandro';


select winner,loser,round,score,tour,city,event,date,season,notes f
rom results where winner='Waselenchuk, Kane' and tmp_date='2017-01-08' and event='2017 Coast to Coast California Open' order by round desc;

select winner,loser,round,score,tour,city,event,date,season,notes 
from results where winner='Obremski, Dan' and tmp_date='1992-06-07' and event='TransCostal Tournament of Champions (GS #4)' 
order by round desc;

select * from results where event='2013 Party with the Pros' order by round desc;

select winner,loser,score,city,event,date,season from results 
           where round='2' order by season desc, tmp_date desc;
           
select winner,loser,round,score,tour,city,event,date,season,notes from results where winner='Swain, Cliff' and tmp_date='1992-06-21' and event='VCI Challenger Cup Series #3' order by round desc;

           select winner,loser,round,score,tour,city,event,date,season,notes from results where winner='Obremski, Dan' and tmp_date='1992-06-07' and event='TransCostal Tournament of Champions (GS #4)' order by round desc;
           



use cp30725_men;

SET SQL_SAFE_UPDATES = 0;

select count(*) 
-- r.season, r.round, sw.seeding as winner_seeding, r.winner, r.date, r.event, sl.seeding as loser_seeding, r.loser, r.score
from results r, seedings sw, seedings sl
where r.event = sw.event
and r.event = sl.event
and r.winner=sw.player
and r.loser=sl.player
and r.event='2017 Coast to Coast California Open'
and sw.seeding > sl.seeding
and sw.seeding > 8;

select major_flag from tourneys t where event='2017 Coast to Coast California Open';

select count(*) from results r, seedings sw, seedings sl 
where r.event = sw.event and r.event = sl.event and r.winner=sw.player and r.loser=sl.player 
and r.event='2017 Coast to Coast California Open' and sw.seeding > sl.seeding and r.round > 16;

select r.season, r.round, sw.seeding as winner_seeding, r.winner, r.date, r.event, sl.seeding as loser_seeding, r.loser, r.score
 from results r, seedings sw, seedings sl 
where r.event = sw.event and r.event = sl.event and r.winner=sw.player and r.loser=sl.player 
and r.event='2017 Coast to Coast California Open' and sw.seeding > sl.seeding and r.round <= 32;

select r.season, r.round, sw.seeding as winner_seeding, r.winner, r.date, r.event, sl.seeding as loser_seeding, r.loser, r.score
from results r, seedings sw, seedings sl where r.event = sw.event and r.event = sl.event and r.winner=sw.player and r.loser=sl.player 
and r.event='2017 Coast to Coast California Open' and r.round <= 16 and sw.seeding > (16-8);


select * from results where score like '%def%';

select * from tourneys where event like '%US Open%' order by tmp_date desc;


update tourneys set tmp_date='2009-10-25' where event='14th Annual US Open';

select * from results where event='14th Annual US Open';