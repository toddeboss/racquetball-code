-- 3/24/26: Creating a Wor Hall of Fame roster table for joining to for reports.

drop table cp30725_prs.hof_wor_roster;

create table cp30725_prs.hof_wor_roster
(induction_year varchar(5),
name varchar(50),
prs_name varchar(50),
hometown varchar(100),
state varchar(10),
gender varchar(1),
category varchar(100)
);

truncate table cp30725_prs.hof_wor_roster;

load data local infile 'C:/Dropbox/z rball/WOR/WOR Hall of Fame/wor_hof_roster.csv' into table cp30725_prs.hof_wor_roster
fields terminated by ',' enclosed by '"' lines terminated by '\n';

SET SQL_SAFE_UPDATES = 0;

-- delete header row in xls
delete from cp30725_prs.hof_wor_roster where induction_year='Year';

select * from cp30725_prs.hof_wor_roster;




-- Find all players not in the master player profile


select * from cp30725_prs.hof_wor_roster 
where prs_name not in (select player from cp30725_prs.player_profile)
-- and hof_classification_real='Professional'
;

select * from cp30725_prs.player_profile where player like '%Lane%';

