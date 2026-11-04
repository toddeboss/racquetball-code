use cp30725_prs;

select * from team_rydf order by player;

select * from team_rydf where gender='M' order by player;


select * from player_profile where player like '%Kelani%';

select t.player, t.email, t.phone, t.prefer, 
p.twitter, p.facebook, p.gender, p.country, p.hometown, p.current_residence, 
p.college, p.sponsor, p.dob, p.l_r_flag
from team_rydf t, player_profile p
where t.player = p.player
-- and p.facebook = ''
order by t.player;


select p.player,p.l_r_flag,p.hometown,p.current_residence,p.height,p.weight,p.college,p.sponsor,p.dob,p.tmp_dob,p.country,p.twitter,p.facebook 
from cp30725_prs.player_profile p, team_rydf t where p.player = t.player order by p.player asc;


select * from cp30725_prs.team_rydf where player not in (select player from cp_30725_prs.player_profile);

grant select on cp30725_prs.team_rydf to cp30725_irt;

use cp30725_men;

select * from cp30725_prs.team_rydf;

select * from cp30725_prs.player_profile;


select winner, s1.seeding as winner_seed,loser, s2.seeding as loser_seed,round,score 
           from results r
           left join seedings s1 on r.winner = s1.player and s1.event=r.event
           left join seedings s2 on r.loser = s2.player and s2.event=r.event 
           where r.event='2018 23rd UnitedHealthcare US Open'
           and r.date='10/7/2018'
           and (winner in (select player from cp30725_prs.team_rydf) 
			or loser in (select player from cp30725_prs.team_rydf))
           order by r.tmp_date,r.round desc;
           
select count(*) from cp30725_prs.team_rydf where player='Czempisz, Marcel';

select count(*) from cp30725_prs.team_rydf where player='Czempisz, Marcel';         

select count(*) from cp30725_prs.team_rydf where player='Miller, Maurice';


select * from cp30725_prs.team_rydf;


select p.player,p.l_r_flag,p.hometown,p.current_residence,p.height,p.weight,p.college,p.sponsor,p.dob,p.tmp_dob,p.country,p.twitter,p.facebook,p.instagram
              from cp30725_prs.player_profile p, cp30725_prs.team_rydf t
              where p.player = t.player
              order by p.gender, p.player asc;
              
select winner_p1, winner_p2, s1.seeding as winnerp1_seed, s2.seeding as winnerp2_seed,
                 loser_p1, loser_p2, s3.seeding as loserp1_seed,s4.seeding as loserp2_seed, round,score 
           from results_doubles r
           left join seedings_doubles s1 on r.winner_p1 = s1.player1 and s1.event=r.event
           left join seedings_doubles s2 on r.winner_p2 = s2.player2 and s2.event=r.event 
           left join seedings_doubles s3 on r.loser_p1 = s3.player1 and s3.event=r.event            
           left join seedings_doubles s4 on r.loser_p2 = s4.player2 and s4.event=r.event   
           where r.event='2018 23rd UnitedHealthcare US Open'
           and r.date='10/7/2018'
           and (winner_p1 in (select player from cp30725_prs.team_rydf) 
			 or winner_p2 in (select player from cp30725_prs.team_rydf)
             or loser_p1 in (select player from cp30725_prs.team_rydf) 
			 or loser_p2 in (select player from cp30725_prs.team_rydf))			   
           order by r.tmp_date,r.round desc;
           
           
           
select winner, s1.seeding as winner_seed,loser, s2.seeding as loser_seed,round,score 
           from results r
           left join seedings s1 on r.winner = s1.player and s1.event=r.event
           left join seedings s2 on r.loser = s2.player and s2.event=r.event 
           where r.event='2018 23rd UnitedHealthcare US Open'
           and r.date='10/7/2018'
           and (winner in (select player from cp30725_prs.team_rydf) 
			or loser in (select player from cp30725_prs.team_rydf))
           order by r.tmp_date,r.round desc;           
           
           
select event, min(round) from results r where 
(winner='boss, Jose' or loser='boss, Jose')
               -- (winner in (select player from cp30725_prs.team_rydf)
               -- or loser in (select player from cp30725_prs.team_rydf))
           and r.event='2018 23rd UnitedHealthcare US Open'
           and r.date='10/7/2018';
           
              
         
            
select player from cp30725_prs.team_rydf order by player;   




select * from team_rydf order by player;


select * from player_profile where player like '%Kelani%';

select t.player, t.email, t.phone, t.prefer, 
p.twitter, p.facebook, p.gender, p.country, p.hometown, p.current_residence, 
p.college, p.sponsor, p.dob, p.l_r_flag
from team_rydf t, player_profile p
where t.player = p.player
-- and p.facebook = ''
order by t.player;


select p.player,p.l_r_flag,p.hometown,p.current_residence,p.height,p.weight,p.college,p.sponsor,p.dob,p.tmp_dob,p.country,p.twitter,p.facebook 
from cp30725_prs.player_profile p, team_rydf t where p.player = t.player order by p.player asc;


select * from cp30725_prs.team_rydf where player not in (select player from cp_30725_prs.player_profile);

grant select on cp30725_prs.team_rydf to cp30725_irt;

use cp30725_men;

select * from cp30725_prs.team_rydf;

select * from cp30725_prs.player_profile;


select winner, s1.seeding as winner_seed,loser, s2.seeding as loser_seed,round,score 
           from results r
           left join seedings s1 on r.winner = s1.player and s1.event=r.event
           left join seedings s2 on r.loser = s2.player and s2.event=r.event 
           where r.event='2018 23rd UnitedHealthcare US Open'
           and r.date='10/7/2018'
           and (winner in (select player from cp30725_prs.team_rydf) 
			or loser in (select player from cp30725_prs.team_rydf))
           order by r.tmp_date,r.round desc;
           
select count(*) from cp30725_prs.team_rydf where player='Czempisz, Marcel';

select count(*) from cp30725_prs.team_rydf where player='Czempisz, Marcel';         

select count(*) from cp30725_prs.team_rydf where player='Miller, Maurice';


select * from cp30725_prs.team_rydf;


select p.player,p.l_r_flag,p.hometown,p.current_residence,p.height,p.weight,p.college,p.sponsor,p.dob,p.tmp_dob,p.country,p.twitter,p.facebook,p.instagram
              from cp30725_prs.player_profile p, cp30725_prs.team_rydf t
              where p.player = t.player
              order by p.gender, p.player asc;
              
select winner_p1, winner_p2, s1.seeding as winnerp1_seed, s2.seeding as winnerp2_seed,
                 loser_p1, loser_p2, s3.seeding as loserp1_seed,s4.seeding as loserp2_seed, round,score 
           from results_doubles r
           left join seedings_doubles s1 on r.winner_p1 = s1.player1 and s1.event=r.event
           left join seedings_doubles s2 on r.winner_p2 = s2.player2 and s2.event=r.event 
           left join seedings_doubles s3 on r.loser_p1 = s3.player1 and s3.event=r.event            
           left join seedings_doubles s4 on r.loser_p2 = s4.player2 and s4.event=r.event   
           where r.event='$event'
           and r.date='$date'
           and (winner in (select player from cp30725_prs.team_rydf) 
			or loser in (select player from cp30725_prs.team_rydf))			   
           order by r.tmp_date,r.round desc;               
           
           
           
create table team_rydf_20210429 as select * from team_rydf;

insert into cp30725_prs.team_rydf (player,gender) values ('Diaz, Shane','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Slutzky, Erin','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Wargo, Graciana','F');

commit;