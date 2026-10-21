/* 10/31/08: Creating tourneys table to do joins based on "major_flag" */

use wwwbossconsultingcom;

--desc results;

drop table tourneys;

create table tourneys
(tourney_pk integer,
 city varchar(30),
 event varchar(255),
 date varchar(20),
 tmp_date date,
 season varchar(10),
 major_flag varchar(1));

--truncate table tourneys;

insert into tourneys (city,event,date,tmp_date,season)
select distinct city, event, date, tmp_date,season from results order by tmp_date;

select * from tourneys order by tmp_date;

-- Start by setting all tournesy to No.
update tourneys set major_flag='N';

select city,event,tmp_date from tourneys 
where (event like '%National%'  
       or event like '%Tournament of Champ%' 
       or event like '%US Open%'
       or event = 'Motorola 2007 World Racquetball Championships'
       or event='2008 Motorola IRT World Championships'
       or event='2004 Chicago Open')
and event <> 'Canadian Nationals'
and event not like '%International%'
and event not like 'Richcraft%'
and event not like 'Kunnan%'
and event not like 'VCI%'
order by tmp_date;

update tourneys set major_flag='Y' where 
(event like '%National%'  
       or event like '%Tournament of Champ%' 
       or event like '%US Open%'
       or event = 'Motorola 2007 World Racquetball Championships'
       or event='2008 Motorola IRT World Championships'
       or event='2004 Chicago Open')
and event <> 'Canadian Nationals'
and event not like '%International%'
and event not like 'Richcraft%'
and event not like 'Kunnan%'
and event not like 'VCI%';

commit;

-- changed mind on Tournament of Champions events


select * from tourneys where major_flag='Y' and event like '%Tournament of%'
update tourneys set major_flag='N' where event like '%Tournament of%';

/* ------------------------------------------------- */

-- list of all major winners in database.  Missing 4th usopen, some "majors" from late 80s early 90s.
select results.winner, results.loser, tourneys.city, tourneys.event, results.tmp_date, tourneys.season
from results, tourneys
where results.event = tourneys.event
and results.season=tourneys.season
and tourneys.major_flag='Y'
and results.round='2'
order by results.tmp_date;


/* ------------------------------------------------- */
-- 1/09 foward; manually put in tourneys from here on out.
-- pk, city, event,date, tmp_date,season, major_flag

insert into tourneys values
(null,'Chihuahua, MEX','2008 Juarez Open Racquetball Championships','11/16/2008','2008-11-16','2008-9','N');

insert into tourneys values 
(null,'Canoga Park, CA','2009 California Open','1/12/2009','2009-01-11','2008-9','N');


