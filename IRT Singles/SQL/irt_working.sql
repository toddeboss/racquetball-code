/* Working SQL while doing IRT work */


insert into results_tmp select * from results_old

select distinct(season) from results_tmp

delete from results where tmp_date < '1980-1-1'

create table results_tmp as select * from results where 1=2;


/***********************/

load data local infile 'c:/boss/rball/irt/Pro_Results_testing.csv' into table results_tmp
--load data local infile 'Pro_Results_new.csv' into table results
fields terminated by ',' enclosed by '"' lines terminated by '\n';

create table results_old as
select * from results where 1=2;

delete from results_tmp where event <> 'Kentucky Pro-Am';

select * from results_tmp

drop table results_tmp;


delete from boss_date;
create table boss_date (col1 varchar(35) );
insert into boss_date values ('3/7/2002');
insert into boss_date values ('3/21/2004');
insert into boss_date values ('2/29/2004');
insert into boss_date values ('3/7/2002');
insert into boss_date values ('3/7/2002');
insert into boss_date values ('12/7/2002','');

select * from boss_date order by tmp_date;
alter table boss_date modify column tmp_date date;

update boss_date set tmp_date="2004-29-02" where col1="2/29/2004"

alter table results add column tmp_date date;
alter table results_old add column tmp_date date;

alter table boss_date modify column col1 date;
alter table boss_date modify column col1 varchar(35);
show warnings;
alter table boss_date add column tmp_date date;

UPDATE boss_date SET tmp_date = CONCAT(  MID(col1,7,4),'-',   MID(col1,1,2),'-',   MID(col1,4,2));
update boss_date set tmp_date=CONCAT(RIGHT(col1,2),'-',LEFT(col1,2),'-',MID(col1,4,2));
update boss_date set tmp_date=REPLACE(CONCAT(RIGHT(col1, 4), LEFT(col1,5)), '/','');
update boss_date set tmp_date = DATE_FORMAT(col1, '%Y-%m-%d');
update boss_date set tmp_date = DATE_FORMAT(col1, '%d/%m/%Y');
update boss_date set tmp_date = DATE_FORMAT(col1,"%m/%d/%Y") 

update boss_date set tmp_date='';

select date(col1) from boss_date;

select col1, instr(col1,"/"), length(col1), locate('/',col1, (instr(col1,"/")+1)  ),
right(col1, locate('/',col1, (instr(col1,"/")+1)  ) )
from boss_date;

select left(col1, (instr(col1,"/")-1)) from boss_date;
select col1,right(col1, (instr(col1,"/"))) from boss_date;


select * from results_old where season='2003-4'

select concat(

alter table results_tmp rename column date tourney_date;

alter table results_tmp modify column date date;
alter table results_tmp modify column date varchar(20);

desc results;


/* end of maintenance post load */

select count(*) from results where winner ='';

select count(*) from results where season='2000-1'
select count(*) from results where season='2000-1  '


select event,date,city,season from results
where round='F'

select tour,city,date,source,season from results where event='Summer Cooler Pro-Am' and round='2' and date='8/6/2000'
select winner,loser,round,score from results where event='Summer Cooler Pro-Am' and date='8/6/2000' order by round desc
select distinct(season) from results



alter table results modify column round varchar(10);


/* All matches per event */
select * from results
where event='Choice Hotels 8th US Open'

select winner,loser,round,score from results where event='Summer Cooler Pro-Am' and date='8/6/2000'


/* all players */
select distinct winner as name from results 
union
select distinct loser as name from results order by name

/* All finals in database */
select winner,loser,score,city,event,date,season,notes
from results
where round='2'
order by season,date;

/* Finals by season */

select winner,loser,score,city,event,date,notes
from results
where round='F'
and season='2003-4'
order by date;

/* Head to Head records */

select winner,loser,round,score,tour,city,event,date,season,notes
from results
where 
(winner='Monchik, Sudsy' and loser='Swain, Cliff')
or
(loser='Monchik, Sudsy' and winner='Swain, Cliff')
order by season,date;

/* W-L Records for a player */

select count(*), season
from results
where winner='Monchik, Sudsy'
group by season
and season ='2000-1'

select count(*)
from results
where loser='Monchik, Sudsy'
--group by season
and season='2003-4'

/* Complete results for a player */

select winner,loser,round,score,tour,city,event,date,season,notes
from results
where 
winner='Monchik, Sudsy' 
or loser='Monchik, Sudsy'
--order by season,date; 

/* Losses given by a player */
select loser, count(loser) as Losses
from results
where winner='Swain, Cliff'
group by loser;

/* Losses given to a player */
select winner, count(winner) as Wins
from results
where loser='Swain, Cliff'
group by winner;



/* Complete results for a player  for a season */

select winner,loser,round,score,tour,city,event,date,season,notes
from results
where 
(winner='Monchik, Sudsy' 
or loser='Monchik, Sudsy')
and season='2003-4'


/* distinct winners in a season */

select winner, count(winner) as count from results
where round='2'
and season='2002-3'
group by winner
order by count desc

select count(distinct(winner)) from results
where round='2'
and season='2002-3'

select winner,loser,round,score,tour,city,event,date,season from results where event='Kentucky Pro-Am'


select event, min(round)
--winner,loser,round,score,tour,city,event,date,season,notes
from results
where 
(winner='Monchik, Sudsy' 
or loser='Monchik, Sudsy')
and season='2003-4'
group by event

select * from results where event='Kentucky Pro-Am'

select count(distinct(event)) from results where season='2003-4'

select count(*) from results where round='2' and winner='Swain, Cliff';
select count(distinct(date)) from results where (winner='Swain, Cliff' or loser='Swain, Cliff');
select count(distinct(date)) from results;

select count(*) from results where round='2' and winner='Swain, Cliff';
select count(distinct(date)) from results where (winner='Swain, Cliff' or loser='Swain, Cliff';

select * from results_old where event = ''
select * from results_old where city like 'Winn%';
select * from results_old where season='1999-0'

delete from results_old where winner='Winner';
delete from results_old where winner='';

update results_old set round='8' where round='Q';
update results_old set round='4' where round='S';
update results_old set round='2' where round='F';

select distinct(round) from results_old;

select distinct(season) from results_old;


/***********************?


select distinct(date), tmp_date from results;

update results set date='6/1/77', tmp_date='1977-06-01' where city='San Diego' and season='1976-7';

select event,date,city,season,tmp_date from results where round='2' order by tmp_date desc

select * from results where city='Chicago' and season='1990-1'

update results set date='10/21/90', tmp_date='1990-10-21' where city='Chicago' and season='1990-1' and event='Head Halloween Classic'
update results set event='Aurora 78', date='4/1/78', tmp_date='1978-04-01' where city='Aurora' and season='1977-8';

select * from results where city='Tulsa'
update results set date='2/1/87', tmp_date='1987-02-01' where city='Tulsa' and season='1986-7';

select * from results where score like '%70%'

select * from results where score like '%INJ%';

select * from results where date='4/1/86' and round=2 and winner='Hogan, Marty'
update results set score='(8),5,(10),10,10' where date='9/15/85' and round=32 and winner='Newman, Jack'
update results set score='(2),10,(10),9,10' where date='4/1/85' and round=16 and winner='Brysman, Corey'
update results set score='(8),(9),4,10,2' where date='4/1/86' and round=2 and winner='Hogan, Marty'

select * from results where (winner='0' or loser='0');

select winner,loser,round,score from results where event='Louisville 74' and date='10/15/1974' order by date,round desc
update results set date='10/15/1974', tmp_date='1974-10-15' where city='Louisville' and season='1974-5'
select * from results where city='Louisville'

update results set winner='Strom,R' where winner='0';



select distinct winner as name from results 
           union 
select distinct loser as name from results order by name;


select * from results where winner like 'St.onge%' or loser like 'St.onge%';

select * from results where winner like 'Rob' or loser like 'Rob';

select min(tmp_date) from results where loser='Swain, Cliff';
select * from results where tmp_date='1983-09-01' and loser='Swain, Cliff'
select * from results where tmp_date='1983-09-01' and winner='Swain, Cliff'

select min(tmp_date) from results where winner='Swain, Cliff' and round=2;

select count(*) from results where tmp_date >='1983-09-01'
and tmp_date<='1985-02-10'
and round=2;

select * from results where loser='Swain, Cliff'
and tmp_date <='1985-02-10'


select distinct(city) from results order by city;
select * from results where city='New York'


select * from results where score like "%forfeit%";

select * from results 
where score in ("fft","FFT","n/a","N/A","SNA")
or score like "%ret%" 
or score like "%forfeit"
or score like "%?%"
or score like "%fft%"
order by score;




update results set score='0,10,ret' where score='0,10,FORFEIT';
update results set score='(0),3,9,ret' where score='(0),3,9,FORFEIT';
update results set score='5,inj fft' where score='5,INJ FORFEIT';

update results set score='(7),9,7,inj fft' where score='(7),9,7,Inf fft';

select distinct(score) from results order by score




load data local infile 'c:/boss/rball/irt/tmp_load.csv' into table results_staging
--load data local infile 'Pro_Results_new.csv' into table results
fields terminated by ',' enclosed by '"' lines terminated by '\n';

select * from results_staging;

update results_staging set tmp_date='2004-04-04';

update results_staging set round='8' where round='Q';
update results_staging set round='4' where round='S';
update results_staging set round='2' where round='F';

update results_staging set season='2003-4';

insert into results select * from results_staging;

delete from results_staging;

delete from wins;
insert into wins
select winner, count(winner) as wins
from results
group by winner




update results set winner='Derocheres, Eric' where winner='Derouchers, Eric';
update results set loser='Derocheres, Eric' where loser='Derouchers, Eric';

select distinct winner as name from results           union 
           select distinct loser as name from results order by name

update results set winner='O''Brien,?' where winner='O''brien,';
update results set loser='O''Brien,?' where loser='O''brien,';
update results set winner='O''Connor, J' where winner='O''connor,J';
update results set loser='O''Connor, J' where loser='O''connor,J';

update results set winner='Wetherbee, John' where winner='Weatherbee, John';
update results set loser='Wetherbee, John' where loser='Weatherbee, John';



/* ---------------------------------------------------------------------------------- */

/* 11/15/10: irt working SQL */

use wwwbossconsultingcom;


-- Code used to generate Tourney auditing sql
select * from results where round=2 order by season desc, tmp_date asc;

select season,count(*) as count from results where round=2 group by season order by count desc;

select season,event,max(round) from results group by season,event order by season desc, tmp_date asc

select * results order by tmp_date desc;



-- this will find any discrepancies in the Rankings table; names mis-entered or not matching
-- the rest of the results database
select player from rankings where season not in ('2009-10','2008-9') and upper(player) not in 
(select distinct upper(loser) from results) 
order by player;

select * from rankings where season='1983-4' order by cast(rank as unsigned);

select max(rank) from rankings where season='1983-4';

select max(cast(rank as unsigned)) from rankings where season='1983-4';

select * from rankings where rank like '%t';

select * from rankings where player='Llacera, Dan';

select player,rank,points,prizemoney from rankings where player='Llacera, Dan' and season='2003-4' 



select season, count(*) from rankings group by season order by season desc;




delete from wins;
insert into wins
select winner, count(winner) as wins
from results
group by winner;
commit;


/* ---------------------------------------------------------------------------------- */

-- 11/15/11
-- diagnosing nofft query

-- 2011-11-07
select max(tmp_date) from results;

-- kane
select winner from results where round='2' and tmp_date = '2011-11-07';

-- 2009-01-11
select max(tmp_date) from results where loser='Waselenchuk, Kane'
         and score not like '%fft%' and tmp_date < '2011-11-07';
         
select count(*) from results where tmp_date > '2009-01-11' 
and tmp_date <= '2011-11-07' and winner='Waselenchuk, Kane'         
 
 
select * from results where winner='Waselenchuk, Kane' or loser='Waselenchuk, Kane'
order by tmp_date asc, round desc;

select count(*) from results;

/* ---------------------------------------------------------------------------------- */
-- May 2014: creating new queries like the tour depth, oldest/youngest player to and matchup query


use cp30725_men;

select count(*) from (
select distinct(winner) as player from results where season='2013-14'
union
select distinct(loser) as player from results where season='2013-14') a;


select count(distinct(winner)) from results
              where round='2'
              and season='2013-14';

select distinct(winner) from results where round='2'
              and season='2013-14';
              
select * from (
select distinct(winner) as player from results where season='2013-14' and round='4'
union
select distinct(loser) as player from results where season='2013-14' and round='4') a;              


select count(distinct(event)) from results where season='2013-14';

select * from tourneys where season='2013-14' and major_flag='Y';


select distinct winner as name from results where season='2013-14'
           union 
select distinct loser as name from results where season='2013-14' order by name

select * from season_summary_rpt;

select * from all_tables;


select * from results where round not in (128,64,32,16,8,4,2);


create table missed_tourney_rpt
(season varchar(10),
player varchar(100),
missed integer)

select * from missed_tourney_rpt order by player;

truncate table missed_tourney_rpt;

delete from missed_tourney_rpt;


select * from player_profile;

select * from results;


select r.winner, p.dob, r.season, r.event, r.date, r.tmp_date
from results r, player_profile p
where p.player = r.winner
and r.round=2
order by r.tmp_date desc;

select r.winner, 'Winner', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.winner
           and r.round=2
union
select r.loser, 'Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=2
           and p.dob <> ''
union            
select r.loser, 'Semi-Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=4
           and p.dob <> ''           
           
select * from player_profile where dob ='';
           
           
select count(*) from results where round=2;           
           
           
select winner,loser,count(*) from results 
         where loser <> '?'
         group by winner,loser 
         having count(*) > 20
         order by count(*) desc;
         
         
select count(*) from results where winner='Carson, Rocky' and loser='Waselenchuk, Kane';         
         


select * from results where score like '%87%';

update results set score='3,(9),8,7' where score='3,(9),8,87';


select * from seedings where event='2015 Galaxy Custom Printing IRT Pro-Am';

update seedings set player='Herrera, Alejandro' where event='2015 Galaxy Custom Printing IRT Pro-Am'
and seeding=13;

select * from results where event='2015 Galaxy Custom Printing IRT Pro-Am'

update results set loser='Herrera, Alejandro'
where event='2015 Galaxy Custom Printing IRT Pro-Am'
and loser='Herrera, Anthony';


select * from results where winner='Swain, Cliff'
and score='7,(5),2,7';

select * from results where score='7,(5),2,7';


select * from results where event='2016 17th Annual New York City Open';

update results set season='2015-16' where event='2016 17th Annual New York City Open';

select * from results where event='20th United Healthcare US Open'
and loser='Bredenbeck, Jake' and round=16;

update results set winner='Bredenbeck, Jake', loser='Rojas, Marco'
where event='20th United Healthcare US Open'
and loser='Bredenbeck, Jake' and round=16;