-- Enson Inoue fixing in database.


-- mistakenly gave all Enson's results to Egan.


create table results_20190510 as select * from results;
truncate table results;

insert into results select * from results_20190510 ;


select * from results where event='Tulsa Open 87' and loser like 'Inoue%';

update results set loser='Inoue, Enson' where event='Tulsa Open 87' and round=32 and winner='Hilecher, Jerry';

select * from results where event='Beaverton 87' and loser like 'Inoue%';

update results set loser='Inoue, Enson' where event='Beaverton 87' and round=32 and winner='Sell, Bill';

select * from results where event='Burnsville 87' and loser like 'Inoue%';

update results set loser='Inoue, Enson' where event='Burnsville 87' and round=32 and winner='Price, Gerry';

select * from results where event='Arnie May Canadian Open Pro-Am' and loser like 'Inoue%';

update results set loser='Inoue, Enson' where event='Arnie May Canadian Open Pro-Am' and round=32 and winner='Brysman, Corey';


select * from results where event='ETU Trucking Pro-Am' and loser like 'Inoue%';

update results set loser='Inoue, Enson' where event='ETU Trucking Pro-Am' and round=32 and winner='Brysman, Corey';


select * from results where event='1988 CityFed Grand Nationals' and loser like 'Inoue%';

update results set loser='Inoue, Enson' where event='1988 CityFed Grand Nationals' and round=32 and winner='Obremski, Dan';

