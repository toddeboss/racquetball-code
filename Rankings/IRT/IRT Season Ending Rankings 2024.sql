-- 2024 rankings manipulation 12/30/24

use cp30725_men;

SET SQL_SAFE_UPDATES = 0;

select * from rankings where season='2024' order by convert(rank,unsigned integer);

create table rankings_20241230 as select * from rankings;

create table rankings_source_20241230 as select * from rankings_source;

select * from rankings_source order by season desc;

delete from rankings where season='2024';

delete from rankings_source where season='2024';

insert into rankings_source (season,source) values ('2024','12/30/24 irttour.com end of season rankings as of 12/19/24/end of season');

insert into rankings_source (season,source) values ('2025','In progress');

select * from rankings_source order by season desc;

commit;

-- now load rankings from working XLS

insert into rankings (season, `rank`, player, points) values ('2024',1,'Waselenchuk, Kane',2212.01);
insert into rankings (season, `rank`, player, points) values ('2024',2,'Montoya, Rodrigo',1400.76);
insert into rankings (season, `rank`, player, points) values ('2024',3,'Manilla, Adam',1242);
insert into rankings (season, `rank`, player, points) values ('2024',4,'Moscoso, Conrrado',1222.15);
insert into rankings (season, `rank`, player, points) values ('2024',5,'Parrilla, Andree',1148.02);
insert into rankings (season, `rank`, player, points) values ('2024',6,'Acuna, Andres',1054.75);
insert into rankings (season, `rank`, player, points) values ('2024',7,'Trujillo, Erick',955);
insert into rankings (season, `rank`, player, points) values ('2024',8,'Natera, Alan',893);
insert into rankings (season, `rank`, player, points) values ('2024',9,'Bredenbeck, Jake',773.81);
insert into rankings (season, `rank`, player, points) values ('2024',10,'Carter, Thomas',671.8);
insert into rankings (season, `rank`, player, points) values ('2024',10,'Martell, Jaime',671.8);
insert into rankings (season, `rank`, player, points) values ('2024',12,'Alonso, Jordy',656.01);
insert into rankings (season, `rank`, player, points) values ('2024',13,'Ramirez, Carlos',493.82);
insert into rankings (season, `rank`, player, points) values ('2024',14,'Mar, Javier',475.82);
insert into rankings (season, `rank`, player, points) values ('2024',15,'Portillo, Eduardo',464.01);
insert into rankings (season, `rank`, player, points) values ('2024',16,'Collins, Robert',462.32);
insert into rankings (season, `rank`, player, points) values ('2024',17,'Gastelum, Diego',439.82);
insert into rankings (season, `rank`, player, points) values ('2024',18,'Murray, Samuel',400.14);
insert into rankings (season, `rank`, player, points) values ('2024',19,'Carrasco, Kadim',349.52);
insert into rankings (season, `rank`, player, points) values ('2024',20,'Sendrey, Cole',311.33);
insert into rankings (season, `rank`, player, points) values ('2024',21,'Cuevas, Erick',261.52);
insert into rankings (season, `rank`, player, points) values ('2024',22,'Bredenbeck, Sam',241.01);
insert into rankings (season, `rank`, player, points) values ('2024',23,'Carson, Rocky',225);
insert into rankings (season, `rank`, player, points) values ('2024',24,'Goth, John',211.01);
insert into rankings (season, `rank`, player, points) values ('2024',25,'Douglas, Jim',209.41);
insert into rankings (season, `rank`, player, points) values ('2024',26,'Flores, Jhonatan',183.01);
insert into rankings (season, `rank`, player, points) values ('2024',27,'Elkins, Cody',162.9);
insert into rankings (season, `rank`, player, points) values ('2024',28,'Gatica, Rafael',152.02);
insert into rankings (season, `rank`, player, points) values ('2024',29,'Gatica, Diego',139.54);
insert into rankings (season, `rank`, player, points) values ('2024',30,'Galicia, Edwin',135.53);
insert into rankings (season, `rank`, player, points) values ('2024',31,'Salvatierra, Juan',112.53);
insert into rankings (season, `rank`, player, points) values ('2024',32,'Garcia, Diego',112.37);
insert into rankings (season, `rank`, player, points) values ('2024',33,'Connell, Lee',99.87);
insert into rankings (season, `rank`, player, points) values ('2024',34,'Wolfe, John',99.86);
insert into rankings (season, `rank`, player, points) values ('2024',35,'Zera, Blase',97.52);
insert into rankings (season, `rank`, player, points) values ('2024',36,'Cardona, Alejandro',93.03);
insert into rankings (season, `rank`, player, points) values ('2024',36,'Zelada, Mauricio',93.03);
insert into rankings (season, `rank`, player, points) values ('2024',38,'De La Rosa, Daniel',90);
insert into rankings (season, `rank`, player, points) values ('2024',39,'Cueva, Juan Francisco',88);
insert into rankings (season, `rank`, player, points) values ('2024',40,'Mansilla, Jaime',87.02);
insert into rankings (season, `rank`, player, points) values ('2024',41,'Antone Iv, Wayne',85.37);
insert into rankings (season, `rank`, player, points) values ('2024',42,'Ugalde, Jose Daniel',77.52);
insert into rankings (season, `rank`, player, points) values ('2024',42,'Gomez, Andres',77.52);
insert into rankings (season, `rank`, player, points) values ('2024',42,'Mendoza, Dj',77.52);
insert into rankings (season, `rank`, player, points) values ('2024',45,'Miranda, Gerson',71.51);
insert into rankings (season, `rank`, player, points) values ('2024',46,'Kosetty, Kalyan',69.99);
insert into rankings (season, `rank`, player, points) values ('2024',47,'Barrios, Hector',62.02);
insert into rankings (season, `rank`, player, points) values ('2024',47,'Chevaile, Sebastian',62.02);
insert into rankings (season, `rank`, player, points) values ('2024',47,'Terrazas, Sebastian',62.02);
insert into rankings (season, `rank`, player, points) values ('2024',50,'Sutherland, Gatlin',58.86);
insert into rankings (season, `rank`, player, points) values ('2024',51,'Nieto, Elias',56.01);
insert into rankings (season, `rank`, player, points) values ('2024',52,'Pocsai, Christian',53.01);
insert into rankings (season, `rank`, player, points) values ('2024',53,'Arteaga, Miguel Angel',51.01);
insert into rankings (season, `rank`, player, points) values ('2024',54,'Lagos, Pablo',46.51);
insert into rankings (season, `rank`, player, points) values ('2024',55,'Haller, Roman',45);
insert into rankings (season, `rank`, player, points) values ('2024',55,'Hernandez, Sebastian',40);
insert into rankings (season, `rank`, player, points) values ('2024',56,'Prentice, Tanner',40);
insert into rankings (season, `rank`, player, points) values ('2024',56,'Shepard, James',38.86);
insert into rankings (season, `rank`, player, points) values ('2024',58,'Pesqueira, Luis',38.86);
insert into rankings (season, `rank`, player, points) values ('2024',58,'Nieto Valadez, Oscar',33.01);
insert into rankings (season, `rank`, player, points) values ('2024',60,'Iwaasa, Coby',33.01);
insert into rankings (season, `rank`, player, points) values ('2024',60,'Reque, Esteban',31.99);
insert into rankings (season, `rank`, player, points) values ('2024',62,'Segundo, Anduari',31.99);
insert into rankings (season, `rank`, player, points) values ('2024',62,'Ruelas, Sebastian Alejandro',31.99);
insert into rankings (season, `rank`, player, points) values ('2024',62,'Aguilar, Luis',31.01);
insert into rankings (season, `rank`, player, points) values ('2024',65,'Cubillos, Set',31.01);
insert into rankings (season, `rank`, player, points) values ('2024',65,'Beltran, Alvaro',31.01);
insert into rankings (season, `rank`, player, points) values ('2024',65,'Cullen, Kurtis',31.01);
insert into rankings (season, `rank`, player, points) values ('2024',65,'Clement Jr., Craig',29.99);
insert into rankings (season, `rank`, player, points) values ('2024',69,'Keita, Yacouba',29.99);
insert into rankings (season, `rank`, player, points) values ('2024',69,'Farfane, Javier',29.99);
insert into rankings (season, `rank`, player, points) values ('2024',69,'Arnez, Matias',29.99);
insert into rankings (season, `rank`, player, points) values ('2024',69,'Rita, Jesse',29.99);
insert into rankings (season, `rank`, player, points) values ('2024',74,'Salgado, Rodrigo',25);
insert into rankings (season, `rank`, player, points) values ('2024',75,'Migliore, Victor',22);
insert into rankings (season, `rank`, player, points) values ('2024',75,'Caceres, Jose',22);
insert into rankings (season, `rank`, player, points) values ('2024',77,'Steadman-Shockley, Homer',20);
insert into rankings (season, `rank`, player, points) values ('2024',77,'Bear, Alejandro',20);
insert into rankings (season, `rank`, player, points) values ('2024',77,'Rocabado, Leonardo',20);
insert into rankings (season, `rank`, player, points) values ('2024',77,'Wer, Christian',20);
insert into rankings (season, `rank`, player, points) values ('2024',77,'Usher, Gavin',20);
insert into rankings (season, `rank`, player, points) values ('2024',77,'Thielen, Tyler',20);
insert into rankings (season, `rank`, player, points) values ('2024',77,'Uribe, Humberto',20);
insert into rankings (season, `rank`, player, points) values ('2024',77,'Levine, Bradley',20);
insert into rankings (season, `rank`, player, points) values ('2024',77,'Black, James',20);
insert into rankings (season, `rank`, player, points) values ('2024',77,'Matteucci, Cody',20);
insert into rankings (season, `rank`, player, points) values ('2024',77,'Kost, Mitch',20);
insert into rankings (season, `rank`, player, points) values ('2024',77,'Cole, Conrad',20);


select count(*) from rankings where season='2024';

select * from rankings where season='2024' order by convert(`rank`,unsigned integer) asc;


select player,count(*) from rankings where season='2024' group by player having count(*) > 1;

-- Roman Haller = duplicate folrf 2024; emailed Ryan, consolidated manually for now.


-- now run name cleanup.  




-- Now Run Season Summary report to see which players have results but names mismatch the rankings

-- just one missing player: Sifuentes, Phillip who no-showed for only result so in DB, no points.

call sp_fixname('Rocabado, Leonardo','Rocobado, Leonardo');



-- that's it all done