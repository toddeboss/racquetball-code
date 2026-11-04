-- player_profile working and ongoing loading

use cp30725_prs;

SET SQL_SAFE_UPDATES = 0;

create table player_profile_20240703 as select * from player_profile;

truncate table cp30725_prs.player_profile;

load data local infile 'E:/Dropbox/z rball/Player Profile/master_player_profile.csv' into table cp30725_prs.player_profile
fields terminated by ',' enclosed by '"' lines terminated by '\n';

select count(*) from player_profile;

delete from cp30725_prs.player_profile where player='Player';

update cp30725_prs.player_profile set dob=null where dob='';

update cp30725_prs.player_profile set tmp_dob=STR_TO_DATE(dob, '%m/%d/%Y');


-- who has trailing spaces
select * from cp30725_prs.player_profile where right(player,1)=' ';

-- need to trim trailing spaces out of players
update cp30725_prs.player_profile set player=rtrim(player);


commit;


select * from cp30725_prs.player_profile;

-- any duplicates?
select player from  cp30725_prs.player_profile
group by player
having count(*) > 1; 


-- Now run name clean up!

 
/* this is all done dymaically now in code each time
create table players_all (player varchar(50));

truncate table players_all;

insert into players_all
select distinct winner as name from results 
union 
select distinct loser as name from results order by name;

select * from players_all;

*/



/*****************************************************/
-- here down is just diagnosis code used to make report.


select * from player_profile where dob='';

select * from player_profile order by tourney_wins desc, total_wins desc;

select player,l_r_flag,hometown,current_residence,height,weight,college,sponsor,dob,tmp_dob from player_profile order by player asc;

select distinct dob from player_profile where dob <> '' order by dob;

select distinct(winner) from results where round=2;

-- first appearances
select dob, (select min(tmp_date) from results where loser='Swain, Cliff') as first_app from player_profile where player='Swain, Cliff';
select dob, (select min(tmp_date) from results where loser='Waselenchuk, Kane') as first_app from player_profile where player='Waselenchuk, Kane';
select dob, (select min(tmp_date) from results where loser='Monchik, Sudsy') as first_app from player_profile where player='Monchik, Sudsy';
select dob, (select min(tmp_date) from results where loser='Hogan, Marty') as first_app from player_profile where player='Hogan, Marty';
select dob, (select min(tmp_date) from results where loser='Harnett, Brett') as first_app from player_profile where player='Harnett, Brett';

-- first tour win
select dob, (select min(tmp_date) from results where winner='Swain, Cliff' and round=2) as first_win from player_profile where player='Swain, Cliff';
select dob, (select min(tmp_date) from results where winner='Waselenchuk, Kane' and round=2) as first_win from player_profile where player='Waselenchuk, Kane';
select dob, (select min(tmp_date) from results where winner='Monchik, Sudsy' and round=2) as first_win from player_profile where player='Monchik, Sudsy';
select dob, (select min(tmp_date) from results where winner='Hogan, Marty' and round=2) as first_win from player_profile where player='Hogan, Marty';
select dob, (select min(tmp_date) from results where winner='Harnett, Brett' and round=2) as first_win from player_profile where player='Harnett, Brett';
select dob, (select min(tmp_date) from results where winner='Mannino, Jason' and round=2) as first_win from player_profile where player='Mannino, Jason';
select dob, (select min(tmp_date) from results where winner='Huczek, Jack' and round=2) as first_win from player_profile where player='Huczek, Jack';

-- this works in oracle
select to_date('9/1/1983') - to_date('3/21/1966') from dual;

select to_days('1983-01-01') - to_days('1966-03-21') from dual;

select to_days(sysdate()) from dual

select sysdate() from dual;

select to_days(sysdate()) - to_days('1957-01-01') from dual;


select max(date) from 
(select max(tmp_date) from results where loser='Waselenchuk, Kane'
union
select max(tmp_date) from results where winner='Waselenchuk, Kane' and round=2)





select * from player_profile;

update player_profile set current_age=null where current_age=109;




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

