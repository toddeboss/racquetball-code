-- 1/26/24: todo; need to fix these duplicate results records

select loser,event,round,count(*) from results 
where loser <> '?'
group by loser,event,round having count(*) > 1;

select winner,event,round,count(*) from results 
where winner <> '?'
group by winner,event,round having count(*) > 1;

-- 1/26/24: cleared out all duplicate players in seeding
select player,event,count(*) from seedings group by player,event having count(*) > 1;

select  * from seedings where event='Choice Hotels 9th US Open' 
and player='Gutierrez, Polo'
;

SET SQL_SAFE_UPDATES = 0;

update seedings set player='Gutierrez, ?' 
where event='Choice Hotels 9th US Open' 
and seeding=76;
