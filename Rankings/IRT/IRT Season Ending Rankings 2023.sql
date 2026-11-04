-- 2023 rankings manipulation 12/29/23

use cp30725_men;

SET SQL_SAFE_UPDATES = 0;

select * from rankings where season='2023' order by convert(rank,unsigned integer);

create table rankings_20231229 as select * from rankings;

create table rankings_source_20231226 as select * from rankings_source;

select * from rankings_source order by season desc;

delete from rankings where season='2023';

delete from rankings_source where season='2023';

insert into rankings_source (season,source) values ('2023','12/29/23 irttour.com end of season rankings as of 12/13/23 (last event of season');

insert into rankings_source (season,source) values ('2024','In progress');

select * from rankings_source order by season desc;


commit;

-- now load rankings from working XLS


insert into rankings (season, rank, player, points) values ('2023',1,'De La Rosa, Daniel',3046.51);
insert into rankings (season, rank, player, points) values ('2023',2,'Moscoso, Conrrado',2780.57);
insert into rankings (season, rank, player, points) values ('2023',3,'Bredenbeck, Jake',2640.18);
insert into rankings (season, rank, player, points) values ('2023',4,'Montoya, Rodrigo',2139.18);
insert into rankings (season, rank, player, points) values ('2023',5,'Parrilla, Andree',1760.15);
insert into rankings (season, rank, player, points) values ('2023',6,'Manilla, Adam',1401);
insert into rankings (season, rank, player, points) values ('2023',7,'Portillo Torres, Eduardo',1276.04);
insert into rankings (season, rank, player, points) values ('2023',8,'Acuna, Andres',1192.01);
insert into rankings (season, rank, player, points) values ('2023',9,'Natera, Alan',1069);
insert into rankings (season, rank, player, points) values ('2023',10,'Murray, Samuel',989.01);
insert into rankings (season, rank, player, points) values ('2023',11,'Landa, Alejandro',930.01);
insert into rankings (season, rank, player, points) values ('2023',12,'Carter, Thomas',924.01);
insert into rankings (season, rank, player, points) values ('2023',13,'Mar, Javier',673.02);
insert into rankings (season, rank, player, points) values ('2023',14,'Collins, Robert',661.04);
insert into rankings (season, rank, player, points) values ('2023',15,'Martell, Jaime',626.01);
insert into rankings (season, rank, player, points) values ('2023',16,'Trujillo, Erick',617.52);
insert into rankings (season, rank, player, points) values ('2023',17,'Cuevas Fernandez, Erick',548.01);
insert into rankings (season, rank, player, points) values ('2023',18,'Carrasco, Kadim',512.53);
insert into rankings (season, rank, player, points) values ('2023',19,'Bredenbeck, Sam',381.02);
insert into rankings (season, rank, player, points) values ('2023',20,'Carson I I I, Rocky',330);
insert into rankings (season, rank, player, points) values ('2023',21,'Ramirez, Carlos',320.55);
insert into rankings (season, rank, player, points) values ('2023',22,'Waselenchuk, Kane',314.01);
insert into rankings (season, rank, player, points) values ('2023',23,'Salvatierra, Juan',278.01);
insert into rankings (season, rank, player, points) values ('2023',24,'Garcia, Diego',273.01);
insert into rankings (season, rank, player, points) values ('2023',25,'Franco, Sebastian',225);
insert into rankings (season, rank, player, points) values ('2023',26,'Gatica, Rafael',186.01);
insert into rankings (season, rank, player, points) values ('2023',27,'Mercado, Mario',180);
insert into rankings (season, rank, player, points) values ('2023',28,'Douglas, Jim',175.05);
insert into rankings (season, rank, player, points) values ('2023',29,'Martin, Anthony',174.02);
insert into rankings (season, rank, player, points) values ('2023',30,'Mendoza, Rodrigo',172.02);
insert into rankings (season, rank, player, points) values ('2023',31,'Ugalde, Jose Daniel',166.01);
insert into rankings (season, rank, player, points) values ('2023',32,'Elkins, Cody',159.54);
insert into rankings (season, rank, player, points) values ('2023',33,'Keller Vargas, Carlos',150);
insert into rankings (season, rank, player, points) values ('2023',34,'Barojas, Axel',143.01);
insert into rankings (season, rank, player, points) values ('2023',35,'Gatica, Diego',139.54);
insert into rankings (season, rank, player, points) values ('2023',36,'Cueva, Juan Francisco',138.51);
insert into rankings (season, rank, player, points) values ('2023',37,'Galicia, Edwin',121.52);
insert into rankings (season, rank, player, points) values ('2023',38,'Goth, John',121.01);
insert into rankings (season, rank, player, points) values ('2023',39,'Nieto, Elias',114);
insert into rankings (season, rank, player, points) values ('2023',40,'Sendrey, Cole',113.03);
insert into rankings (season, rank, player, points) values ('2023',41,'Salgado Jr., Rodrigo',108.53);
insert into rankings (season, rank, player, points) values ('2023',42,'Gastelum, Diego',102.02);
insert into rankings (season, rank, player, points) values ('2023',43,'Mendoza, Dj',97.52);
insert into rankings (season, rank, player, points) values ('2023',44,'Riffel, Nicholas',92.02);
insert into rankings (season, rank, player, points) values ('2023',45,'Beltran, Alvaro',90);
insert into rankings (season, rank, player, points) values ('2023',45,'Flores, Jr., Jose',90);
insert into rankings (season, rank, player, points) values ('2023',47,'Evans, Stephen',86.51);
insert into rankings (season, rank, player, points) values ('2023',48,'Garcia, Erik',80);
insert into rankings (season, rank, player, points) values ('2023',49,'Ortega Jr, Guillermo Jesus',79.52);
insert into rankings (season, rank, player, points) values ('2023',50,'Gomez, Andres',76.01);
insert into rankings (season, rank, player, points) values ('2023',50,'Rogers, Bradly',76.01);
insert into rankings (season, rank, player, points) values ('2023',50,'Connell, Lee',76.01);
insert into rankings (season, rank, player, points) values ('2023',53,'Hedalen, Ty',65);
insert into rankings (season, rank, player, points) values ('2023',54,'Miranda Martinez, Gerson',64.02);
insert into rankings (season, rank, player, points) values ('2023',55,'Cullen, Kurtis',62.02);
insert into rankings (season, rank, player, points) values ('2023',56,'Horner, Benjamin',61.01);
insert into rankings (season, rank, player, points) values ('2023',57,'Miller, Maurice',60);
insert into rankings (season, rank, player, points) values ('2023',58,'Antone Iv, Wayne',56.01);
insert into rankings (season, rank, player, points) values ('2023',59,'Cardona, Alejandro',51.01);
insert into rankings (season, rank, player, points) values ('2023',59,'Wer Llerena, Christian',51.01);
insert into rankings (season, rank, player, points) values ('2023',59,'Wolfe, John',51.01);
insert into rankings (season, rank, player, points) values ('2023',62,'Prentice, Tanner',50);
insert into rankings (season, rank, player, points) values ('2023',62,'Majxner, Matthew',50);
insert into rankings (season, rank, player, points) values ('2023',64,'Fontana, Matt',46.51);
insert into rankings (season, rank, player, points) values ('2023',64,'Mercado, Abraham',46.51);
insert into rankings (season, rank, player, points) values ('2023',64,'Andres-Beck, Lincoln',46.51);
insert into rankings (season, rank, player, points) values ('2023',64,'Castro, Roberto',46.51);
insert into rankings (season, rank, player, points) values ('2023',68,'Chevaile S,, Sebastian',40.01);
insert into rankings (season, rank, player, points) values ('2023',69,'Zera, Blase',40);
insert into rankings (season, rank, player, points) values ('2023',70,'Nieto Valadez, Oscar E.',33.01);
insert into rankings (season, rank, player, points) values ('2023',70,'Fernandez, Sebastian',33.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Ramos, Jose Carlos',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Ott, Derek',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Cubillos, Set',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Cardenas, Abraham1',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Flores, Alan',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Lam, Michael',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Longoria, Christian',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Migliore, Victor',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Schulze, Samuel',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Sanchez, Cristhian',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Kingsford, Jacob',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Rodriguez, Rodrigo',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Sanchez Rico, Cristhian',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Ruelas Reza, Sebastian A.',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Horn, David',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Mehta, Alok',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Levine, Bradley',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Kosetty, Kalyan',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Shimizu, Hiroshi',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Hansen, Blake',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Ulliman, Kyle',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Dixon, Jeremy',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Barth, Jordan',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Meinerz, Lee',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Cole, Conrad',31.01);
insert into rankings (season, rank, player, points) values ('2023',72,'Purcell, Alexxander',31.01);
insert into rankings (season, rank, player, points) values ('2023',98,'Brayley, Mitch',30);
insert into rankings (season, rank, player, points) values ('2023',98,'Yelverton, Brady',30);
insert into rankings (season, rank, player, points) values ('2023',100,'Carson, Tony',25);
insert into rankings (season, rank, player, points) values ('2023',100,'Herrera, Alejandro',25);
insert into rankings (season, rank, player, points) values ('2023',100,'Spencer, Sunji',25);
insert into rankings (season, rank, player, points) values ('2023',100,'Pratt, Charles',25);
insert into rankings (season, rank, player, points) values ('2023',104,'Black, James',22);
insert into rankings (season, rank, player, points) values ('2023',104,'Gross, Tanner',22);
insert into rankings (season, rank, player, points) values ('2023',104,'Kurzbard, Fernando',22);
insert into rankings (season, rank, player, points) values ('2023',104,'Pruitt, Dylan',22);
insert into rankings (season, rank, player, points) values ('2023',108,'Peterson, Tyler',20);
insert into rankings (season, rank, player, points) values ('2023',108,'Thielen, Tyler',20);
insert into rankings (season, rank, player, points) values ('2023',108,'Jennings, Brennen',20);
insert into rankings (season, rank, player, points) values ('2023',108,'Sanders, C J',20);
insert into rankings (season, rank, player, points) values ('2023',108,'Angove, David',20);
insert into rankings (season, rank, player, points) values ('2023',108,'Rykhus, Nathan',20);
insert into rankings (season, rank, player, points) values ('2023',108,'De Janon, Esteban',20);
insert into rankings (season, rank, player, points) values ('2023',108,'Gleason, Andrew',20);
insert into rankings (season, rank, player, points) values ('2023',108,'Lopez Kim, Samuel',20);
insert into rankings (season, rank, player, points) values ('2023',108,'Keller, Roland',20);
insert into rankings (season, rank, player, points) values ('2023',108,'Mehta, Clint',20);
insert into rankings (season, rank, player, points) values ('2023',108,'Knowles, Brian',20);
insert into rankings (season, rank, player, points) values ('2023',108,'Clement Jr., Craig',20);
insert into rankings (season, rank, player, points) values ('2023',108,'Miranda, Justin',20);
insert into rankings (season, rank, player, points) values ('2023',108,'Dale, Kaleb',20);
insert into rankings (season, rank, player, points) values ('2023',108,'Manilla, Erika',20);
insert into rankings (season, rank, player, points) values ('2023',108,'Matteucci, Cody',20);
insert into rankings (season, rank, player, points) values ('2023',125,'Romano, Diego',12.01);
insert into rankings (season, rank, player, points) values ('2023',126,'Lopez, Eridson',10.01);
insert into rankings (season, rank, player, points) values ('2023',126,'Perdomo, Josue',10.01);
insert into rankings (season, rank, player, points) values ('2023',126,'Arnez, Matias',10.01);
insert into rankings (season, rank, player, points) values ('2023',126,'Gauri, Naman',10.01);
insert into rankings (season, rank, player, points) values ('2023',126,'Samson, Ferd',10.01);
insert into rankings (season, rank, player, points) values ('2023',126,'Castro, Pedro',10.01);
insert into rankings (season, rank, player, points) values ('2023',126,'Cheshire, Ken',10.01);
insert into rankings (season, rank, player, points) values ('2023',126,'McClellan, Scott',10.01);





select count(*) from rankings where season='2023';

select * from rankings where season='2023' order by convert(rank,unsigned integer) asc;


select player,count(*) from rankings where season='2023' group by player having count(*) > 1;

-- no duplicate players in 2023


-- now run name cleanup.  

-- Now Run Season Summary report to see which players have results but names mismatch the rankings

-- Jack Goldberg: no ranking but appeared twice.  both wbf-no shows, so zero points/no ranking

-- Ruelas missing: in r2 as Ruelas Reza, Sebastian A. .  Add to player cleanup

call sp_fixname('Ruelas, Sebastian Alejandro','Ruelas Reza, Sebastian A.');

-- Eduardo garay; one result, no show, no points.

-- Zelada, Mauricio: 2 results, 2 no shows

call sp_fixname('Lopez, Sam','Lopez Kim, Samuel');

call sp_fixname('Lopez, Samuel','Lopez, Sam');


call sp_fixname('Chevaile, Sebastian','Chevaile Sanchez, Sebastian');
call sp_fixname('Chevaile, Sebastian','Sanchez, Sebastian Chevaile');
call sp_fixname('Chevaile, Sebastian','Chevaile S,, Sebastian');


-- mansilla: one result, no show

-- that's it all done