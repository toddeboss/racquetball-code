-- rpt_tracking working sql

use cp30725_men;

use cp30725_prs;

SET SQL_SAFE_UPDATES = 0;

desc results;

select now() from dual;

-- total reports run since Jan 2018: 1M plus but at least 10% from a SQL injection attack in Mar 2020
select count(*) from cp30725_prs.rpt_tracking;

-- truncate table rpt_tracking;

-- overall count; tracking started 1/29/18
select count(*) from cp30725_prs.rpt_tracking 
-- where rpt_date < '2019-01-01'
;



-- breakdown by year
select year(rpt_date), count(*) from cp30725_prs.rpt_tracking 
group by year(rpt_date)
order by 1,2;
-- order by 3 desc
;

-- Breakdown by month and year
select year(rpt_date), month(rpt_date), count(*) from cp30725_prs.rpt_tracking 
group by year(rpt_date), month(rpt_date)
order by 1,2;
-- order by 3 desc
;

-- What happened in Mar 2020?  207k reports run that month, 10x volume of most months
-- 3/27/20: 114k reports: sql injection attack
-- 3/2/20: another 40k same thing.
select year(rpt_date), month(rpt_date), day(rpt_date),count(*) 
from cp30725_prs.rpt_tracking 
-- where year(rpt_date) = '2020' and month(rpt_date) = '3'
where year(rpt_date) = '2019' and month(rpt_date) = '11'
group by year(rpt_date), month(rpt_date), day(rpt_date)
order by 1,2;
-- order by 3 desc
;

-- 3/27/20 breakdown; player_profile_individual was run 136k times.  wtf?  Ah; sql injection attack
select count(*) from cp30725_prs.rpt_tracking
-- where rpt_date > '2020-03-26' and rpt_date < '2020-03-28';
where rpt_date > '2020-03-01' and rpt_date < '2020-03-03';

select query,count(*) from cp30725_prs.rpt_tracking
-- where rpt_date > '2020-03-26' and rpt_date < '2020-03-28'
-- where rpt_date > '2020-03-01' and rpt_date < '2020-03-03'
where rpt_date > '2019-11-25' and rpt_date < '2019-11-27'
group by query order by 2 desc;

select * from cp30725_prs.rpt_tracking 
-- where rpt_date > '2020-03-26' and rpt_date < '2020-03-28'
-- where rpt_date > '2020-03-01' and rpt_date < '2020-03-03'
where rpt_date > '2019-11-25' and rpt_date < '2019-11-27'
-- and query='player_profile_individual'
order by rpt_date asc;



select * from cp30725_prs.rpt_tracking 
-- where player <> '0'
-- where event <> '0'
-- where season <> '0'
-- order by query
order by rpt_date desc
-- limit 20
;


-- count per query
select query,count(*) from cp30725_prs.rpt_tracking group by query 
order by 2 desc
-- order by query
;

-- here, 1 = zero times called
select a.query,count(*) 
from cp30725_prs.all_reports a left join cp30725_prs.rpt_tracking r on a.query=r.query
group by a.query 
order by 2 asc
-- order by query
;



-- what queries have yet to be run
select * from cp30725_prs.all_reports where query not in 
(select query from cp30725_prs.rpt_tracking)
order by query;


-- per player
select player,count(*) from cp30725_prs.rpt_tracking 
where player not in ('0','?','$player1','')
group by player 
order by 2 desc
-- order by 1
;


-- per tour DB: 17 dbs right now with addition of Jr Dbls and Pickleball
select tour,count(*) from cp30725_prs.rpt_tracking 
group by tour 
order by 2 desc
-- order by 1
;

-- per Category
select category,count(*) from cp30725_prs.rpt_tracking 
where category not in ('','0')
group by category
order by 2 desc
-- order by 1
;

-- per Division
select division,count(*) from cp30725_prs.rpt_tracking 
where division not in ('','0')
group by division
order by 2 desc
-- order by 1
;

-- per subroutine; t his is the actual per subroutine name
select subroutine,count(*) from cp30725_prs.rpt_tracking 
group by subroutine
order by 2 desc
-- order by 1
;

-- per sum_event
select sum_event,count(*) from cp30725_prs.rpt_tracking 
group by sum_event
order by 2 desc
-- order by 1
;

-- per season
select season,count(*) from cp30725_prs.rpt_tracking 
where season not in ('','0')
group by season
order by 2 desc
-- order by 1
;

select count(*) from cp30725_prs.player_profile;

select count(distinct(loser)) from cp30725_women.results;


update cp30725_prs.player_profile set picture_flag='Yes' where player in 
('Garay, Eduardo','Garay, Rodrigo','Landeryou, James','Gonzalez, Ximena','Irvine, Nick','Myers, Lindsay','Negrete, Dave',
'Reiff, Scott','Richardson, Christine','Negrete, Dave');


-- per player with join to player profiles
select p.player,pp.picture_flag, count(*) 
from cp30725_prs.rpt_tracking  p left join cp30725_prs.player_profile pp
on p.player = pp.player
where p.player not in ('0','?')
and pp.picture_flag <> 'Yes'
group by p.player 
order by 3 desc
-- order by 1
;