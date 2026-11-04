-- player_profile working

select * from player_profile;

select r.winner,p1.country, r.loser,p2.country,r.score,r.city,r.event,r.date 
from results r, player_profile p1, player_profile p2
where r.winner = p1.player
and r.loser = p2.player
           and r.round='2' order by r.tmp_date;
           
select r.loser, p1.country from results r,player_profile p1 where r.loser = p1.player and r.round='4';       

select r.loser, p1.country 
              from results r,player_profile p1 
              where r.loser = p1.player and r.round='8' and r.event='2nd Red Swain Memorial 2004';  
              
           
              
              
select r.loser, p1.country 
               from results r left join player_profile p1 on r.loser = p1.player 
               where r.round='8' and r.event='NRC DP/Leach Nationals' and date='6/1/1976';
               
select * from results r where r.event='NRC DP/Leach Nationals' and date='6/1/1976';
               
               
select * from results where event='2015 16th Annual Ghost of Georgetown KC IRT Pro-Am';          

create table results_20180121 as select * from results;
     
               
update results set round=16 where event='Ralphs Grocery Pro-Am' and winner='Swain, Cliff' and loser='Green, Mike';
               
               
select * from player_profile where player like 'Rogers%';    

delete from player_profile where player='Bowman, Jeff' and l_r_flag='R';           

delete from player_profile where player='Rogers, Bradley' and hometown='Lenexa, KS';   

call sp_fixname('Thurman, Bill','Thurman,B');


select * from player_profile group by player having count(*) > 1;

