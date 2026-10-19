
use cp30725_wrt;

SET SQL_SAFE_UPDATES = 0;

create table results_20170106 as select * from results;

select * from results where event='2014 WRT Port City Shootout';

update results set loser='Diaz, Jose' where event='2014 WRT Port City Shootout' and round=2;

select * from seedings where event='2014 WRT Port City Shootout';

create seedings_20170106 as select * from seedings;

update seedings set player='Diaz, Jose' where event='2014 WRT Port City Shootout' and seeding=21;

select * from seedings where event='2014 WRT Port City Shootout';

select * from results where tmp_date like '2017%';

update results set season='2017' where tmp_date like '2017%';

select * from tour_champions;

select count(*) from results;

select * from results where event='2013 Flagstaff Open' and winner = 'Gutierrez, Polo';

select winner,loser,round,score,tour,city,event,date,season,tmp_date 
         from results where 
         winner='Landa, Alejandro' or loser='Landa, Alejandro'
order by winner, score;         

create table results_20170123 as select * from results;

create table tourneys_20170123 as select * from tourneys;

SET SQL_SAFE_UPDATES = 0;


delete from results where event='2014 Juarez Open';
delete from results where event='2013 Juarez Open';
delete from results where event='2013 San Diego Open';

delete from tourneys where event='2014 Juarez Open';
delete from tourneys where event='2013 Juarez Open';
delete from tourneys where event='2013 San Diego Open';


