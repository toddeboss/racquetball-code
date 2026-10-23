-- 10/16/17: quick temp table to hold list of all players in DB for player profile query.

desc results;

create table players_all (player varchar(50));

insert into players_all
select distinct winner as name from results 
union 
select distinct loser as name from results order by name;

select * from players_all;


select p.player,p.l_r_flag,p.hometown,p.current_residence,p.height,p.weight,p.college,p.sponsor,p.dob,p.tmp_dob 
from player_profile p, players_all a
where p.player = a.player
order by p.player asc;
           
           

            