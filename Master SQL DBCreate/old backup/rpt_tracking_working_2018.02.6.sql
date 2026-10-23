-- rpt_tracking working sql

use cp30725_prs;

SET SQL_SAFE_UPDATES = 0;

desc results;

select now() from dual;

select * from rpt_tracking;

-- truncate table rpt_tracking;



select * from cp30725_prs.rpt_tracking 
-- where player <> '0'
-- where event <> '0'
-- where season <> '0'
-- order by query
order by rpt_date desc
;


-- per query
select query,count(*) from cp30725_prs.rpt_tracking group by query 
-- order by 2 desc
order by query
;

-- per player
select player,count(*) from cp30725_prs.rpt_tracking 
where player not in ('0','?')
group by player 
-- order by 2 desc
order by 1
;


-- per tour DB: 11 dbs right now.
select tour,count(*) from cp30725_prs.rpt_tracking 
group by tour 
-- order by 2 desc
order by 1
;


select * from player_profile;

-- per player with join to player profiles

select p.player,pp.picture_flag, count(*) 
from cp30725_prs.rpt_tracking  p left join cp30725_prs.player_profile pp
on p.player = pp.player
where p.player not in ('0','?')
group by p.player 
-- order by 2 desc
order by 1
;