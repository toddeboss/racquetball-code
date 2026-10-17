-- Mar 2025: generating medal counts in IRF for Jim Hiser's World Games project.-- Mar 2025: generating medal counts in IRF for Jim Hiser's World Games project.

select r.*, p.country
from results r right join cp30725_prs.player_profile p on  r.winner = p.player
where 1=1
and round='2' and 
(event like '%World Championships%' 
 or event like '%World Racquetball Championship%'
or event like '%Pan American Championships%' 
or event like '%Pan American Racquetball Championships%'
or event like '%Pan American Games%'
or event like '%Pan Am Games%'
or event like '%Tournament of the Americas%'
or event like '%World Games%')
and event like '% - Womens Open%'
order by season desc, tmp_date desc, event asc;

drop table irf_major_medals_singles;

truncate table irf_major_medals_singles;

create table irf_major_medals_singles
(player varchar(50),
medal varchar(20),
country varchar(50),
total_medals integer);

insert into irf_major_medals_singles 
select player,'Gold',country,count(*) from (
select r.winner as player, p.country 
from results r right join cp30725_prs.player_profile p on  r.winner = p.player
where 1=1
and round='2' and 
(event like '%World Championships%' 
 or event like '%World Racquetball Championship%'
or event like '%Pan American Championships%' 
or event like '%Pan American Racquetball Championships%'
or event like '%Pan American Games%'
or event like '%Pan Am Games%'
or event like '%Tournament of the Americas%'
or event like '%World Games%')
and event like '% - Womens Open%'
order by season desc, tmp_date desc, event asc) t
group by player,country
order by 4 desc;

insert into irf_major_medals_singles
select player,'Silver',country,count(*) from (
select r.loser as player, p.country 
from results r right join cp30725_prs.player_profile p on  r.winner = p.player
where 1=1
and round='2' and 
(event like '%World Championships%' 
 or event like '%World Racquetball Championship%'
or event like '%Pan American Championships%' 
or event like '%Pan American Racquetball Championships%'
or event like '%Pan American Games%'
or event like '%Pan Am Games%'
or event like '%Tournament of the Americas%'
or event like '%World Games%')
and event like '% - Womens Open%'
order by season desc, tmp_date desc, event asc) t
group by player,country
order by 4 desc;

insert into irf_major_medals_singles
select player,'Bronze',country,count(*) from (
select r.loser as player, p.country 
from results r right join cp30725_prs.player_profile p on  r.winner = p.player
where 1=1
and round='4' and 
(event like '%World Championships%' 
 or event like '%World Racquetball Championship%'
or event like '%Pan American Championships%' 
or event like '%Pan American Racquetball Championships%'
or event like '%Pan American Games%'
or event like '%Pan Am Games%'
or event like '%Tournament of the Americas%'
or event like '%World Games%')
and event like '% - Womens Open%'
order by season desc, tmp_date desc, event asc) t
group by player,country
order by 4 desc;

select * from irf_major_medals_singles;

select * from irf_major_medals_singles where medal='Gold' order by 4 desc;


select player,country,sum(total_medals)
from irf_major_medals_singles
group by player,country
order by 3 desc;




/* ========================= */

-- Doubles.

drop table irf_major_medals_doubles;

truncate table irf_major_medals_doubles;

create table irf_major_medals_doubles
(player varchar(50),
medal varchar(20),
country varchar(50),
total_medals integer);


select * from results_doubles;

insert into irf_major_medals_doubles
select player,'Gold',country,count(*) from (
select r.winner_p1 as player, p.country 
from results_doubles r right join cp30725_prs.player_profile p on  r.winner_p1 = p.player
where 1=1
and round='2' and 
(event like '%World Championships%' 
 or event like '%World Racquetball Championship%'
or event like '%Pan American Championships%' 
or event like '%Pan American Racquetball Championships%'
or event like '%Pan American Games%'
or event like '%Pan Am Games%'
or event like '%Tournament of the Americas%'
or event like '%World Games%')
and event like '% - Womens Open%'
order by season desc, tmp_date desc, event asc) t
group by player,country
order by 4 desc;

insert into irf_major_medals_doubles
select player,'Gold',country,count(*) from (
select r.winner_p2 as player, p.country 
from results_doubles r right join cp30725_prs.player_profile p on  r.winner_p2 = p.player
where 1=1
and round='2' and 
(event like '%World Championships%' 
 or event like '%World Racquetball Championship%'
or event like '%Pan American Championships%' 
or event like '%Pan American Racquetball Championships%'
or event like '%Pan American Games%'
or event like '%Pan Am Games%'
or event like '%Tournament of the Americas%'
or event like '%World Games%')
and event like '% - Womens Open%'
order by season desc, tmp_date desc, event asc) t
group by player,country
order by 4 desc;

insert into irf_major_medals_doubles
select player,'Silverd',country,count(*) from (
select r.loser_p1 as player, p.country 
from results_doubles r right join cp30725_prs.player_profile p on  r.loser_p1 = p.player
where 1=1
and round='2' and 
(event like '%World Championships%' 
 or event like '%World Racquetball Championship%'
or event like '%Pan American Championships%' 
or event like '%Pan American Racquetball Championships%'
or event like '%Pan American Games%'
or event like '%Pan Am Games%'
or event like '%Tournament of the Americas%'
or event like '%World Games%')
and event like '% - Womens Open%'
order by season desc, tmp_date desc, event asc) t
group by player,country
order by 4 desc;

insert into irf_major_medals_doubles
select player,'Silverd',country,count(*) from (
select r.loser_p2 as player, p.country 
from results_doubles r right join cp30725_prs.player_profile p on  r.loser_p2 = p.player
where 1=1
and round='2' and 
(event like '%World Championships%' 
 or event like '%World Racquetball Championship%'
or event like '%Pan American Championships%' 
or event like '%Pan American Racquetball Championships%'
or event like '%Pan American Games%'
or event like '%Pan Am Games%'
or event like '%Tournament of the Americas%'
or event like '%World Games%')
and event like '% - Womens Open%'
order by season desc, tmp_date desc, event asc) t
group by player,country
order by 4 desc;

insert into irf_major_medals_doubles
select player,'Bronze',country,count(*) from (
select r.loser_p1 as player, p.country 
from results_doubles r right join cp30725_prs.player_profile p on  r.loser_p1 = p.player
where 1=1
and round='4' and 
(event like '%World Championships%' 
 or event like '%World Racquetball Championship%'
or event like '%Pan American Championships%' 
or event like '%Pan American Racquetball Championships%'
or event like '%Pan American Games%'
or event like '%Pan Am Games%'
or event like '%Tournament of the Americas%'
or event like '%World Games%')
and event like '% - Womens Open%'
order by season desc, tmp_date desc, event asc) t
group by player,country
order by 4 desc;

insert into irf_major_medals_doubles
select player,'Bronze',country,count(*) from (
select r.loser_p2 as player, p.country 
from results_doubles r right join cp30725_prs.player_profile p on  r.loser_p2 = p.player
where 1=1
and round='4' and 
(event like '%World Championships%' 
 or event like '%World Racquetball Championship%'
or event like '%Pan American Championships%' 
or event like '%Pan American Racquetball Championships%'
or event like '%Pan American Games%'
or event like '%Pan Am Games%'
or event like '%Tournament of the Americas%'
or event like '%World Games%')
and event like '% - Womens Open%'
order by season desc, tmp_date desc, event asc) t
group by player,country
order by 4 desc;


select * from irf_major_medals_doubles;

select * from irf_major_medals_doubles where medal='Gold' order by 4 desc;


select player,country,sum(total_medals)
from irf_major_medals_doubles
group by player,country
order by 3 desc;