
-- cleaning up Boulder 86 scores; they're screwing up logic


use cp30725_men;

SET SQL_SAFE_UPDATES = 0;


select * from results where event='Boulder 86'

select * from results where score='3 GAMES';

update results set score='?,?,?' where score='3 GAMES';

select * from results where score='4 GAMES';

update results set score='?,(?),?,?' where score='4 GAMES';

select * from results where score='5 GAMES';

update results set score='?,(?),?,(?),?' where score='5 GAMES';

-- other misc bad scores during the 3-game era:

select * from results where event='Elmwood Summer Cooler Pro-Am' and date='8/11/1996';

update results set score='1,2,4' where event='Elmwood Summer Cooler Pro-Am' and date='8/11/1996' and score='12,4';

update results set score='10,10,3' where score='10l10,3';

update results set score='5,2,3' where score='5.2,3';

update results set score='9,7,(10),7' where score='9.7.(10),7';

select * from results where event='Promus Hotels 3rd US Open';

update results set score='?,?,3' where score=',3';

------------------
-- also found other inaccuracies screwing up misc_tour_stats logic:

create table results_20190220 as select * from results;


select * from results where event='Seattle 1990 (Grand Nationals?)';

select * from tourneys where event='Seattle 1990 (Grand Nationals?)';

update results set score='' where event='Seattle 1990 (Grand Nationals?)';


select * from results where event='Chelseas Pro-Am';

update results set score='' where event='Chelseas Pro-Am' and loser='Mercante, John' and round=32;

select * from results where event='7th Annual St. Vincents 1st Coast Classic';

update results set score='' where  event='7th Annual St. Vincents 1st Coast Classic' and round=64 and winner='Kulp, Rob';

select * from results where event='Memphis Pro-Am (GS #2)';

update results set score='' where event='Memphis Pro-Am (GS #2)' and round=64 and winner='Kulp, Rob';

select * from results where event='VCI Challenger Cup Series #3';

update results set score='' where event='VCI Challenger Cup Series #3' and round=4;

select * from results where event='Elmwood Summer Cooler' and date='8/23/1992';

update results set score='' where event='Elmwood Summer Cooler' and round=64 and winner='Kulp, Rob' and date='8/23/1992';

select * from results where event='5th Campbells Healthy Request Pro-Am';

update results set score='' where event='5th Campbells Healthy Request Pro-Am' and round=4;

select * from results where event='Coca Cola Holiday Pro-Am';

update results set score='' where event='Coca Cola Holiday Pro-Am' and round=4;

select * from results where event='Spalding IRT Tournament of Champions';

update results set score='' where event='Spalding IRT Tournament of Champions' and round=4;

select * from results where event='Elmwood Summer Cooler' and date='8/9/1998';

update results set score='' where event='Elmwood Summer Cooler' and date='8/9/1998' and round=4 and winner='Swain, Cliff';

select * from results where event='16th Coors Light Pro-Am';

update results set score='' where event='16th Coors Light Pro-Am' and round=4;

select * from results where event='Elmwood Summer Cooler Pro-Am' and date='8/8/1999';

update results set score='' where event='Elmwood Summer Cooler Pro-Am' and date='8/8/1999' and round=4 and winner='Swain, Cliff';

select * from results where event='2005 San Diego Open';

update results set score='' where event='2005 San Diego Open' and round=4 and winner='Swain, Cliff';

select * from results where event='Choice Hotels 10th US Open';



update results set score='2,0,3' where score='2.0.3';

update results set score='9,1,7' where score='9.1.7';

select * from results where score='?';

update results set score='' where score='?';