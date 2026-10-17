-- amateur working sql

select * from tourneys_doubles where (event like '%USA%' or event like '%USRA' or event like '%US %') order by tmp_date asc;

select * from tourneys where city like 'St. Louis%' order by tmp_date asc;


select * from results where winner like '%forfeit%';

call sp_fixname ('Nieto, Oscar','Nieto, Elias');




select winner_p1, winner_p2, s1.seeding as winnerp1_seed, s2.seeding as winnerp2_seed, loser_p1, loser_p2, s3.seeding as loserp1_seed,s4.seeding as loserp2_seed, round,score from results_doubles r left join seedings_doubles s1 on r.winner_p1 = s1.player1 and s1.event=r.event left join seedings_doubles s2 on r.winner_p2 = s2.player2 and s2.event=r.event left join seedings_doubles s3 on r.loser_p1 = s3.player1 and s3.event=r.event left join seedings_doubles s4 on r.loser_p2 = s4.player2 and s4.event=r.event where r.event='2020 USA Racquetball National Doubles Championships - Mens Open' and r.date='2/9/2020' and (winner_p1 in (select player from cp30725_prs.team_rydf) or winner_p2 in (select player from cp30725_prs.team_rydf) or loser_p1 in (select player from cp30725_prs.team_rydf) or loser_p2 in (select player from cp30725_prs.team_rydf)) order by r.tmp_date,r.round desc;

select winner_p1, winner_p2, s1.seeding as winnerp1_seed, s2.seeding as winnerp2_seed, p1.country as winner_country, loser_p1, loser_p2, s3.seeding as loserp1_seed,s4.seeding as loserp2_seed, p2.country as loser_country, round,score 
from results_doubles r left join seedings_doubles s1 on r.winner_p1 = s1.player1 and s1.event=r.event left join seedings_doubles s2 on r.winner_p2 = s2.player2 and s2.event=r.event left join seedings_doubles s3 on r.loser_p1 = s3.player1 and s3.event=r.event left join seedings_doubles s4 on r.loser_p2 = s4.player2 and s4.event=r.event where r.event='2020 USA Racquetball National Doubles Championships - Mens Open' and r.date='2/9/2020' and (winner_p1 in (select player from cp30725_prs.team_rydf) or winner_p2 in (select player from cp30725_prs.team_rydf) or loser_p1 in (select player from cp30725_prs.team_rydf) or loser_p2 in (select player from cp30725_prs.team_rydf)) order by r.tmp_date,r.round desc;


select winner,loser,round,score,tour,city,event,date,season,tmp_date 
                 from results where 
                 winner='Landa, Alejandro' or loser='Landa, Alejandro' order by tmp_date,event,round desc;
                 
                 
select * from entrants;                 

select count(*) from results where event='2019-20 Racquetball Canada National Team Selection Event #2 - Womens Open' and date='2/9/2020';

select count(distinct(loser)) from results where event='2019-20 Racquetball Canada National Team Selection Event #2 - Womens Open' and date='2/9/2020';


select winner,loser,score,city,event,date,season from results 
where round='2' and (city not like '%MEX' and city not like '%CAN') and event like '%- Mens%' and event not like '%Qualifying Event%'
order by season desc, tmp_date desc, event asc;


select count(*) from results where winner='Murray, Samuel' and round=2;


select count(*) from results where winner='Murray, Samuel' and round=2 and 
((event not like '%Selection Event%') and (event not like '%Qualifying Event%'));


select winner,count(winner) as 'wins' from results where round=2 
 and ((event not like '%Selection Event%') and (event not like '%Qualifying Event%') and (event not like '%Primera Fuerza%'))
 group by winner order by wins desc;
 
 
select r.winner,p.country, count(r.winner) as 'wins' 
from results r, cp30725_prs.player_profile p
where r.winner = p.player
and r.round=2 
group by r.winner order by wins desc; 

select r.winner,p.country, count(r.winner) as 'wins' 
from results r
left outer join cp30725_prs.player_profile p on r.winner = p.player
where r.round=2 
group by r.winner order by wins desc; 

select winner,count(winner) as 'wins' from results where round=2 
              group by winner order by wins desc;
              
              
select * from cp30725_prs.player_profile where player like 'Law%';

update cp30725_prs.player_profile set player='Lawrence (Bailey), Kelani' where player='Lawence (Bailey), Kelani';

commit;



select * from wins where wins >=5;


select * from season_summary_rpt;


select * from seedings where event like '2017 Campeonato%';


update results set event='2017 Campeonato Nacional Mexicano de Raquetbol Selectivo (Mexican Nationals Selection Event) - Mens Open'
where event = '2017 Campeonato Nacional Mexicano de Raquetbol Selectivo - Mens Open';

update results set event='2017 Campeonato Nacional Mexicano de Raquetbol Selectivo (Mexican Nationals Selection Event) - Womens Open'
where event = '2017 Campeonato Nacional Mexicano de Raquetbol Selectivo - Womens Open';



select * from results_doubles where event='Copa Mexico 2020 Campeonato Nacional Selectivo de Raquetbol - Mens Open';

update results_doubles set winner_p1='Montoya, Rodrigo', winner_p2='Mar, Javier'
where event='Copa Mexico 2020 Campeonato Nacional Selectivo de Raquetbol - Mens Open' and round=2;

update results_doubles set loser_p1='De La Rosa, Daniel', loser_p2='Beltran, Alvaro'
where event='Copa Mexico 2020 Campeonato Nacional Selectivo de Raquetbol - Mens Open' and round=2;

commit;



select * from results_doubles where event='1968 1st US National Doubles Championships - Mens Open';

update results_doubles set loser_p1='Trost, Dan', loser_p2='Glinberg, Dave', score='(14),11,9'
where event='1968 1st US National Doubles Championships - Mens Open' and round=2;

select * from results_doubles where event='1973 6th US National Doubles Championships - Mens Open';


select * from seedings_doubles where event='1973 6th US National Doubles Championships - Mens Open';


select * from results where event='1973 USA Racquetball National Singles Championships - Mens Open';

-- delete from results where event='1973 USA Racquetball National Singles Championships - Mens Open';

commit;



select * from results where event='1996 USA Racquetball National Singles Championships - Mens Open';

update results set loser='Oneil, Todd' where round=2 and event='1996 USA Racquetball National Singles Championships - Mens Open';

commit;


select * from results_doubles where city like 'Los Al%';

update results_doubles set city='Los Alamitos, CA' where city='Los Alimitos, CA';

update tourneys_doubles set city='Los Alamitos, CA' where city='Los Alimitos, CA';

commit;
