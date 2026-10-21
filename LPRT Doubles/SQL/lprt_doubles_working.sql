-- irt doubles working

select * from tourneys_doubles;

select * from results_doubles;

select * from seedings_doubles;

select winner_p1, winner_p2, s1.seeding as winnerp1_seed, s2.seeding as winnerp2_seed,
      loser_p1, loser_p2, s3.seeding as loserp1_seed,s4.seeding as loserp2_seed,
	  round,score 
           from results_doubles r
           left join seedings_doubles s1 on r.winner_p1 = s1.player1 and s1.event=r.event
           left join seedings_doubles s2 on r.winner_p2 = s2.player2 and s2.event=r.event 
           left join seedings_doubles s3 on r.loser_p1 = s3.player1 and s3.event=r.event            
           left join seedings_doubles s4 on r.loser_p2 = s4.player2 and s4.event=r.event            
           where r.event='2017 22nd UnitedHealthcare US OPEN Racquetball Championships'
           and r.date='10/8/2017'
           order by r.tmp_date,r.round desc;
           
           
select winner_p1, winner_p2, s1.seeding as winnerp1_seed, s2.seeding as winnerp2_seed, loser_p1, loser_p2, s3.seeding as loserp1_seed,s4.seeding as loserp2_seed, round,score from results_doubles r left join seedings_doubles s1 on r.winner_p1 = s1.player1 and s1.event=r.event left join seedings_doubles s2 on r.winner_p2 = s2.player2 and s2.event=r.event left join seedings_doubles s3 on r.loser_p1 = s3.player1 and s3.event=r.event left join seedings_doubles s4 on r.loser_p2 = s4.player2 and s4.event=r.event where r.event='2017 22nd UnitedHealthcare US OPEN Racquetball Championships' and r.date='10/8/2017' order by r.tmp_date,r.round desc;           


select winner_p1, winner_p2,loser_p1, loser_p2,score,city,event,date,season from results_doubles 
           where round='2' and season='2016-17' order by tmp_date;
           
select winner_p1, winner_p2,loser_p1, loser_p2,score,city,event,date,season from results_doubles where round='2' and season='2017-18 ' order by tmp_date;           


select * from results_doubles;

SET SQL_SAFE_UPDATES = 0;

update results_doubles set season='2017-18' where season like '2017-18%';