-- 3/24/26: Creating a Hall of Fame roster table for joining to for reports.

drop table cp30725_prs.hof_roster;

create table cp30725_prs.hof_roster
(induction_year varchar(5),
gender varchar(1),
name varchar(50),
prs_name varchar(50),
city varchar(100),
state varchar(100),
hof_classification varchar(50),
hof_classification_real varchar(50)
-- num_titles varchar(255),
-- compensated varchar(255)
);

truncate table cp30725_prs.hof_roster;


-- IMPORTANT: before loading this, remove the two narrative columns b/c they have embedded commas.

load data local infile 'C:/Dropbox/z rball/USRA/Board of Directors/Committee - Hall of Fame/Hall of Fame/USAR Hall of Fame Roster.csv' into table cp30725_prs.hof_roster
fields terminated by ',' enclosed by '"' lines terminated by '\n';


SET SQL_SAFE_UPDATES = 0;

-- delete header row in xls
delete from cp30725_prs.hof_roster where induction_year='USAR';

select * from cp30725_prs.hof_roster;

/* ------------------------------------------------------------------------------------------------- */
-- working sql below

-- Find all players not in the master player profile

select * from cp30725_prs.player_profile where player like '%Schmid%';

select * from cp30725_prs.hof_roster 
where prs_name not in (select player from cp30725_prs.player_profile)
-- and hof_classification_real='Professional'
;

---
select * from wins;

select * from  cp30725_prs.hof_roster;

select w.winner from wins w, cp30725_prs.hof_roster r where w.winner=r.prs_name and r.hof_classification_real='Professional';

select w.winner from wins w where w.winner not in (select prs_name from cp30725_prs.hof_roster );

select w.winner from wins w where w.winner not in (select prs_name from cp30725_prs.hof_roster ) and wins >= 50 
and w.winner in (select winner from results where round=2);
