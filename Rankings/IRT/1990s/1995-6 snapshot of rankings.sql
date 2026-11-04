-- Updateing 95-96 rankings for magazine data

select * from rankings where season='1995-6';

SET SQL_SAFE_UPDATES = 0;

delete from rankings where season='1995-6';

insert into rankings (season,rank,player,points) values ('1995-6',1,'Monchik, Sudsy',2148);
insert into rankings (season,rank,player,points) values ('1995-6',2,'Swain, Cliff',2138);
insert into rankings (season,rank,player,points) values ('1995-6',3,'Roberts, Andy',1967);
insert into rankings (season,rank,player,points) values ('1995-6',4,'Ray, Mike',1567);
insert into rankings (season,rank,player,points) values ('1995-6',5,'Ellis, John',1409);
insert into rankings (season,rank,player,points) values ('1995-6',6,'Guidry, Mike',1375);
insert into rankings (season,rank,player,points) values ('1995-6',7,'Mannino, Jason',1138);
insert into rankings (season,rank,player,points) values ('1995-6',8,'Kachtik, Drew',1030);
insert into rankings (season,rank,player,points) values ('1995-6',9,'Jelso, Tony',883);
insert into rankings (season,rank,player,points) values ('1995-6',10,'Fowler, Dan',846);
insert into rankings (season,rank,player,points) values ('1995-6',11,'Vogel, Luis',818);
insert into rankings (season,rank,player,points) values ('1995-6',12,'Karp, Adam',801);
insert into rankings (season,rank,player,points) values ('1995-6',13,'Engel, Mike',769);
insert into rankings (season,rank,player,points) values ('1995-6',14,'Rankin, Brian',547);
insert into rankings (season,rank,player,points) values ('1995-6',15,'Clouse, Woody',522);
insert into rankings (season,rank,player,points) values ('1995-6',16,'Robinson, Derek',476);
insert into rankings (season,rank,player,points) values ('1995-6',17,'Doyle, Tim',358);
insert into rankings (season,rank,player,points) values ('1995-6',18,'Schenck, Darrin',332);
insert into rankings (season,rank,player,points) values ('1995-6',19,'Messina, Josh',306);
insert into rankings (season,rank,player,points) values ('1995-6',20,'Gonzalez, Ruben',305);
insert into rankings (season,rank,player,points) values ('1995-6',21,'Gelhaus, Kelly',286);
insert into rankings (season,rank,player,points) values ('1995-6',22,'Sable, Dave',260);
insert into rankings (season,rank,player,points) values ('1995-6',23,'Reiff, Scott',259);
insert into rankings (season,rank,player,points) values ('1995-6',24,'Ceresia, Mike',248);

select * from rankings_source where season='1995-6';

update rankings_source set source='Updated Jan 2017 from screenshot of RM Jul/Aug 1996' where season='1995-6';