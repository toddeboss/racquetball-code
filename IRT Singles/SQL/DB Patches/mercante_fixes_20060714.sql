use wwwbossconsultingcom;

select * from results where loser like 'Campbell%';
select * from results where winner is null;

update results set loser='Mercante, John' where loser='Mercante,J';
update results set loser='Evans, Jeff' where loser='Evans, ?';
update results set loser='Campbell, Darin' where loser='Campbell, ?';

update results set loser='Mercante, John' where winner='Gonzalez, Ruben' and event='TransCostal Grand Nationals' and round=32;
update results set loser='Mercante, John' where winner='Yellen, Mike' and event='5th TransCostal Grand Nationals (GS #3)' and round=32;
update results set loser='Mercante, John' where winner='Roberts, Andy' and event='TransCostal Tournament of Champions (GS #4)' and round=16;
update results set loser='Mercante, John' where winner='Yellen, Mike' and event='VCI Challenger Cup Series #1' and round=32;

insert into results values ('Hogan, Marty','Mercante, John',32,' ','IRT','Seattle, WA','Seattle 1990 (Grand Nationals?)','5/1/1990','John Mercante','1989-90',' ','1990-0505');
update results set tmp_date='1990-05-05' where loser='Mercante, John' and event='Seattle 1990 (Grand Nationals?)';

insert into results values ('Newman, Jack','Mercante, John',32,' ','MPRA','Salem, OR','Chelseas Pro-Am','9/30/1990','John Mercante','1990-1',' ','1990-09-30');




