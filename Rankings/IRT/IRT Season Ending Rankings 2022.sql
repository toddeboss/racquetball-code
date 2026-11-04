-- 2022 rankings manipulation

use cp30725_men;

SET SQL_SAFE_UPDATES = 0;

select * from rankings where season='2022' order by convert(rank,unsigned integer);

create table rankings_20221226 as select * from rankings;

create table rankings_source_20221226 as select * from rankings_source;

select * from rankings_source order by season desc;

delete from rankings where season='2022';

delete from rankings_source where season='2022';

insert into rankings_source (season,source) values ('2022','12/26/22 irttour.com end of season rankings as of 12/06/22 (last event of season');

insert into rankings_source (season,source) values ('2023','In progress');

select * from rankings_source order by season desc;


commit;

-- now load rankings from working XLS

insert into rankings (season, rank, player, points) values ('2022',1,'De La Rosa, Daniel',2933.51);
insert into rankings (season, rank, player, points) values ('2022',2,'Parrilla, Andree',2696.25);
insert into rankings (season, rank, player, points) values ('2022',3,'Moscoso, Conrrado',2652.51);
insert into rankings (season, rank, player, points) values ('2022',4,'Portillo Torres, Eduardo',2425.16);
insert into rankings (season, rank, player, points) values ('2022',5,'Landa, Alejandro',2121.05);
insert into rankings (season, rank, player, points) values ('2022',6,'Murray, Samuel',1951.04);
insert into rankings (season, rank, player, points) values ('2022',7,'Bredenbeck, Jake',1936.14);
insert into rankings (season, rank, player, points) values ('2022',8,'Waselenchuk, Kane',1792.16);
insert into rankings (season, rank, player, points) values ('2022',9,'Carson I I I, Rocky',1741.01);
insert into rankings (season, rank, player, points) values ('2022',10,'Mercado, Mario',1689.15);
insert into rankings (season, rank, player, points) values ('2022',11,'Montoya, Rodrigo',1547);
insert into rankings (season, rank, player, points) values ('2022',12,'Manilla, Adam',1388);
insert into rankings (season, rank, player, points) values ('2022',13,'Acuna, Andres',1230.52);
insert into rankings (season, rank, player, points) values ('2022',14,'Keller Vargas, Carlos',949);
insert into rankings (season, rank, player, points) values ('2022',15,'Franco, Sebastian',894.55);
insert into rankings (season, rank, player, points) values ('2022',16,'Carter, Thomas',893.03);
insert into rankings (season, rank, player, points) values ('2022',17,'Fernandez, Sebastian',772.53);
insert into rankings (season, rank, player, points) values ('2022',18,'Garay, Eduardo',730.04);
insert into rankings (season, rank, player, points) values ('2022',19,'Mar, Javier',655.02);
insert into rankings (season, rank, player, points) values ('2022',20,'Beltran, Alvaro',649.03);
insert into rankings (season, rank, player, points) values ('2022',21,'Trujillo, Erick',566.03);
insert into rankings (season, rank, player, points) values ('2022',22,'Collins, Robert',452.06);
insert into rankings (season, rank, player, points) values ('2022',23,'Carrasco, Kadim',446.56);
insert into rankings (season, rank, player, points) values ('2022',24,'Martell, Jaime',416.03);
insert into rankings (season, rank, player, points) values ('2022',25,'Natera, Alan',413.04);
insert into rankings (season, rank, player, points) values ('2022',26,'Cuevas Fernandez, Erick',386.56);
insert into rankings (season, rank, player, points) values ('2022',27,'Alonso, Jordy',361.51);
insert into rankings (season, rank, player, points) values ('2022',28,'Bredenbeck, Sam',347.52);
insert into rankings (season, rank, player, points) values ('2022',29,'Zelada, Mauricio',342.51);
insert into rankings (season, rank, player, points) values ('2022',30,'Salvatierra, Juan',307.03);
insert into rankings (season, rank, player, points) values ('2022',31,'Garcia, Diego',285);
insert into rankings (season, rank, player, points) values ('2022',32,'Galicia, Edwin',255.53);
insert into rankings (season, rank, player, points) values ('2022',33,'Mendoza, Rodrigo',242.01);
insert into rankings (season, rank, player, points) values ('2022',34,'Wer Llerena, Christian',207.01);
insert into rankings (season, rank, player, points) values ('2022',35,'Rodriguez, Rodrigo',201.55);
insert into rankings (season, rank, player, points) values ('2022',36,'Horn, David',195);
insert into rankings (season, rank, player, points) values ('2022',37,'Barrios, Hector',167.52);
insert into rankings (season, rank, player, points) values ('2022',38,'Ortega Jr, Guillermo Jesus',166.5);
insert into rankings (season, rank, player, points) values ('2022',39,'Douglas, Jim',162.04);
insert into rankings (season, rank, player, points) values ('2022',40,'Rodriguez, Juan Pablo',162.02);
insert into rankings (season, rank, player, points) values ('2022',41,'Kelley, Joe',161.52);
insert into rankings (season, rank, player, points) values ('2022',42,'Leduc, Michael',157.02);
insert into rankings (season, rank, player, points) values ('2022',43,'Cubillos, Set',144.02);
insert into rankings (season, rank, player, points) values ('2022',44,'Pratt, Charles',138.51);
insert into rankings (season, rank, player, points) values ('2022',45,'Camacho, Felipe',136.99);
insert into rankings (season, rank, player, points) values ('2022',46,'Sendrey, Cole',130);
insert into rankings (season, rank, player, points) values ('2022',47,'Subieta, Ezequiel',120.01);
insert into rankings (season, rank, player, points) values ('2022',48,'Cunningham, Austin',116.5);
insert into rankings (season, rank, player, points) values ('2022',49,'Pruitt, Dylan',115);
insert into rankings (season, rank, player, points) values ('2022',50,'Shea, Josh',113.51);
insert into rankings (season, rank, player, points) values ('2022',51,'Cardona, Alejandro',110);
insert into rankings (season, rank, player, points) values ('2022',52,'Riffel, Nicholas',109.52);
insert into rankings (season, rank, player, points) values ('2022',53,'Miller, Maurice',108.49);
insert into rankings (season, rank, player, points) values ('2022',54,'Martin, Anthony',103.04);
insert into rankings (season, rank, player, points) values ('2022',55,'Martinez, Javier',100.01);
insert into rankings (season, rank, player, points) values ('2022',56,'Arteaga Guzman, Miguel Angel',98.52);
insert into rankings (season, rank, player, points) values ('2022',57,'Gomez, Andres',93.99);
insert into rankings (season, rank, player, points) values ('2022',58,'Zamudio, Alex',91.99);
insert into rankings (season, rank, player, points) values ('2022',59,'Mendoza, Geovani',87);
insert into rankings (season, rank, player, points) values ('2022',60,'Kelley, Samuel',74.04);
insert into rankings (season, rank, player, points) values ('2022',61,'Warigon, Troy',73.53);
insert into rankings (season, rank, player, points) values ('2022',62,'Goth, John',70);
insert into rankings (season, rank, player, points) values ('2022',62,'Gleason, Andrew',70);
insert into rankings (season, rank, player, points) values ('2022',64,'Horner, Benjamin',65.01);
insert into rankings (season, rank, player, points) values ('2022',65,'Izzi, Derek',65);
insert into rankings (season, rank, player, points) values ('2022',65,'Samson, Ferd',65);
insert into rankings (season, rank, player, points) values ('2022',67,'Flores, Jr., Jose',61.98);
insert into rankings (season, rank, player, points) values ('2022',68,'Pena, Abraham',61.52);
insert into rankings (season, rank, player, points) values ('2022',69,'Reque, Esteban',61.02);
insert into rankings (season, rank, player, points) values ('2022',70,'Migliore, Victor',60);
insert into rankings (season, rank, player, points) values ('2022',70,'Davenport, Matthew',60);
insert into rankings (season, rank, player, points) values ('2022',72,'Behm, John',60);
insert into rankings (season, rank, player, points) values ('2022',73,'Manzuri, Shai',59.98);
insert into rankings (season, rank, player, points) values ('2022',74,'Herrera, Alejandro',58.52);
insert into rankings (season, rank, player, points) values ('2022',75,'Wolfe, John',55.01);
insert into rankings (season, rank, player, points) values ('2022',76,'Jackson, Bob',54.99);
insert into rankings (season, rank, player, points) values ('2022',77,'Keller, Roland',52.01);
insert into rankings (season, rank, player, points) values ('2022',78,'Ulliman, Kyle',51.01);
insert into rankings (season, rank, player, points) values ('2022',79,'Cardenas, Abraham1',50.01);
insert into rankings (season, rank, player, points) values ('2022',80,'Hansen, Blake',50);
insert into rankings (season, rank, player, points) values ('2022',80,'Gastelum, Diego',50);
insert into rankings (season, rank, player, points) values ('2022',82,'McClellan, Scott',47.02);
insert into rankings (season, rank, player, points) values ('2022',83,'Barth, Jordan',46.51);
insert into rankings (season, rank, player, points) values ('2022',83,'Delgadillo, Mauricio',46.51);
insert into rankings (season, rank, player, points) values ('2022',83,'Nieto Valadez, Oscar Elias',46.51);
insert into rankings (season, rank, player, points) values ('2022',86,'Tapia Zuniga, Juan Jose',45);
insert into rankings (season, rank, player, points) values ('2022',86,'Austin, David',45);
insert into rankings (season, rank, player, points) values ('2022',88,'Elkins, Cody',42.02);
insert into rankings (season, rank, player, points) values ('2022',89,'Lazenby, Alex',40);
insert into rankings (season, rank, player, points) values ('2022',89,'Dowell, John',40);
insert into rankings (season, rank, player, points) values ('2022',89,'McDonald, Floyd',40);
insert into rankings (season, rank, player, points) values ('2022',92,'Flores, Jhonatan',37.01);
insert into rankings (season, rank, player, points) values ('2022',92,'Bleyer, Ben',37.01);
insert into rankings (season, rank, player, points) values ('2022',94,'Cruz, Julian',35.01);
insert into rankings (season, rank, player, points) values ('2022',94,'Baron, Ben',35.01);
insert into rankings (season, rank, player, points) values ('2022',96,'Coggins, Guy',35);
insert into rankings (season, rank, player, points) values ('2022',97,'Majxner, Matthew',33.01);
insert into rankings (season, rank, player, points) values ('2022',98,'Swain, Cliff',31.99);
insert into rankings (season, rank, player, points) values ('2022',99,'Ugalde, Jose Daniel',31.01);
insert into rankings (season, rank, player, points) values ('2022',99,'Iwaasa, Coby',31.01);
insert into rankings (season, rank, player, points) values ('2022',99,'Jimenez, Noslen',31.01);
insert into rankings (season, rank, player, points) values ('2022',99,'Thomas, Jorge Carlos',31.01);
insert into rankings (season, rank, player, points) values ('2022',99,'Laffey, Connor',31.01);
insert into rankings (season, rank, player, points) values ('2022',99,'Spencer, Sunji',31.01);
insert into rankings (season, rank, player, points) values ('2022',99,'Longoria, Christian',31.01);
insert into rankings (season, rank, player, points) values ('2022',99,'Hedalen, Ty',31.01);
insert into rankings (season, rank, player, points) values ('2022',107,'Arnez, Matias',30.02);
insert into rankings (season, rank, player, points) values ('2022',108,'Schulze, Samuel',30);
insert into rankings (season, rank, player, points) values ('2022',108,'Quinlan, Patrick',30);
insert into rankings (season, rank, player, points) values ('2022',108,'Arenas, Felipe',30);
insert into rankings (season, rank, player, points) values ('2022',108,'Julbes, Paul',30);
insert into rankings (season, rank, player, points) values ('2022',108,'Meinerz, Lee',30);
insert into rankings (season, rank, player, points) values ('2022',108,'Eisemann, Richard',30);
insert into rankings (season, rank, player, points) values ('2022',114,'Black, James',29.99);
insert into rankings (season, rank, player, points) values ('2022',114,'Burns, Jonathan',29.99);
insert into rankings (season, rank, player, points) values ('2022',114,'Gomez Reyes, Francisco',29.99);
insert into rankings (season, rank, player, points) values ('2022',114,'Loreto, Juan',29.99);
insert into rankings (season, rank, player, points) values ('2022',114,'Kingsford, Jacob',29.99);
insert into rankings (season, rank, player, points) values ('2022',114,'Meeks, Bailey',29.99);
insert into rankings (season, rank, player, points) values ('2022',114,'Bear, Alejandro',29.99);
insert into rankings (season, rank, player, points) values ('2022',121,'Cuesta, Fabian',27.02);
insert into rankings (season, rank, player, points) values ('2022',122,'Robles, Bruce',27.01);
insert into rankings (season, rank, player, points) values ('2022',123,'Shahin, Majeed',25.02);
insert into rankings (season, rank, player, points) values ('2022',123,'Jennings, Brennen',25.02);
insert into rankings (season, rank, player, points) values ('2022',123,'Ramirez, Carlos',25.02);
insert into rankings (season, rank, player, points) values ('2022',126,'Meguerditchian, Garin',25.01);
insert into rankings (season, rank, player, points) values ('2022',127,'Mueller, Drew',25);
insert into rankings (season, rank, player, points) values ('2022',127,'Midkiff, Alex',25);
insert into rankings (season, rank, player, points) values ('2022',127,'Lazenby, Zack',25);
insert into rankings (season, rank, player, points) values ('2022',130,'Vargas, Marcelo',22);
insert into rankings (season, rank, player, points) values ('2022',131,'Mendoza, Dj',20.02);
insert into rankings (season, rank, player, points) values ('2022',132,'Galvez, Carlos Jose',20.01);
insert into rankings (season, rank, player, points) values ('2022',132,'Pujari, Maneesh',20.01);
insert into rankings (season, rank, player, points) values ('2022',134,'Williams, Zachary',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Sanders, C J',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Cohen, Doug',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Neumann, Ryan',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Zera, Blase',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Rykhus, Nathan',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Gutierrez Ortiz, Jorge',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Arntz, Nicholas',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Hernandez, Sebastian',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Healy, Matthew',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Everhart, Destry',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Garcia, Gabriel',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Martinez, Luis',20);
insert into rankings (season, rank, player, points) values ('2022',134,'OBrien, Mike',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Turnquest, Bradnado',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Clement Jr., Craig',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Vanbemmelen, Troy',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Gutierrez, Polo',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Schotik, Ronald',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Antone Iv, Wayne',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Gerhardt, Thomas',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Cueva, Juan Francisco',20);
insert into rankings (season, rank, player, points) values ('2022',134,'McLain, Kerry',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Mijares, Marco',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Hogan, Marty',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Ramos Jr., Walter',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Atwell, Kipp',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Wiegand, Andy',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Manilla, Erika',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Koshiol, Steven',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Prince, Darrin',20);
insert into rankings (season, rank, player, points) values ('2022',134,'Salamone, Dan',20);
insert into rankings (season, rank, player, points) values ('2022',166,'Rankin, Charles',17.01);
insert into rankings (season, rank, player, points) values ('2022',167,'Allin, Patrick',15.01);
insert into rankings (season, rank, player, points) values ('2022',167,'Sullivan, Seth',15.01);
insert into rankings (season, rank, player, points) values ('2022',167,'Siles Gonzales, Vladimir',15.01);
insert into rankings (season, rank, player, points) values ('2022',167,'Cuellar, Alejandro',15.01);
insert into rankings (season, rank, player, points) values ('2022',167,'Jaldin Lobo, Adrian',15.01);
insert into rankings (season, rank, player, points) values ('2022',167,'Aguilar, Luis',15.01);
insert into rankings (season, rank, player, points) values ('2022',167,'Slamko, Cole',15.01);
insert into rankings (season, rank, player, points) values ('2022',167,'Dineros, Rennie',15.01);
insert into rankings (season, rank, player, points) values ('2022',167,'Moore, Troy',15.01);
insert into rankings (season, rank, player, points) values ('2022',167,'Moreno, Javier',15.01);
insert into rankings (season, rank, player, points) values ('2022',167,'Barojas, Axel',15.01);
insert into rankings (season, rank, player, points) values ('2022',178,'Kukoyi, Bolaji',15);
insert into rankings (season, rank, player, points) values ('2022',178,'Giljum, Brendan',15);
insert into rankings (season, rank, player, points) values ('2022',178,'Sotomayor, Veronica',15);
insert into rankings (season, rank, player, points) values ('2022',178,'Svabek, Ladislav',15);
insert into rankings (season, rank, player, points) values ('2022',178,'Paul, Josh',15);
insert into rankings (season, rank, player, points) values ('2022',178,'Witt, Dan',15);
insert into rankings (season, rank, player, points) values ('2022',184,'Levine, Bradley',12.01);
insert into rankings (season, rank, player, points) values ('2022',184,'Diaz, Jose',12.01);
insert into rankings (season, rank, player, points) values ('2022',184,'Adler, Joel',12.01);
insert into rankings (season, rank, player, points) values ('2022',184,'Young, Stacey (sly)',12.01);
insert into rankings (season, rank, player, points) values ('2022',184,'Fontana, Matt',12.01);
insert into rankings (season, rank, player, points) values ('2022',189,'Castro, Pedro',10.01);
insert into rankings (season, rank, player, points) values ('2022',189,'Andres-Beck, Lincoln',10.01);
insert into rankings (season, rank, player, points) values ('2022',189,'Puggioni, Tony',10.01);
insert into rankings (season, rank, player, points) values ('2022',189,'Mercado, Abraham',10.01);
insert into rankings (season, rank, player, points) values ('2022',189,'Rivero, Luis',10.01);
insert into rankings (season, rank, player, points) values ('2022',189,'Kosetty, Kalyan',10.01);
insert into rankings (season, rank, player, points) values ('2022',189,'Bautista, Daniel',10.01);
insert into rankings (season, rank, player, points) values ('2022',189,'Ellis, Julius',10.01);
insert into rankings (season, rank, player, points) values ('2022',189,'Salgado Jr., Rodrigo',10.01);
insert into rankings (season, rank, player, points) values ('2022',189,'Sullivan, Brendan',10.01);
insert into rankings (season, rank, player, points) values ('2022',189,'Dunn, Iain',10.01);
insert into rankings (season, rank, player, points) values ('2022',189,'Gatica, Rafael',10.01);
insert into rankings (season, rank, player, points) values ('2022',189,'Perez, Jose',10.01);
insert into rankings (season, rank, player, points) values ('2022',189,'Subieta, Roger',10.01);
insert into rankings (season, rank, player, points) values ('2022',189,'Lopez Sosa Erikson, David',10.01);
insert into rankings (season, rank, player, points) values ('2022',189,'Perez, Armando',10.01);
insert into rankings (season, rank, player, points) values ('2022',189,'Martinez, Hanzel',10.01);
insert into rankings (season, rank, player, points) values ('2022',189,'Lopez, Eridson',10.01);
insert into rankings (season, rank, player, points) values ('2022',189,'Perdomo, Josue',10.01);
insert into rankings (season, rank, player, points) values ('2022',208,'Lazcano Ramirez, Samuel',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Tito, Ariel',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Boykin, Jonathan',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Laime, Brenda',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Willingham, Charlie',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Simpson, Justin',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Reyes, Carlos',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Lyons, Gregory',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Hale, Lance',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Semones, Steve',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Perez, Michael',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Armanuse, Anthony',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Farmer, Hayden',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Farmer, Stephen',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Alvendia, Ted',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Hudson, John',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Beckwith, Lee',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Beaudry, Danny',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Watkins, Tim',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Melster, Matt',10);
insert into rankings (season, rank, player, points) values ('2022',208,'Coyle, Eugene',10);
insert into rankings (season, rank, player, points) values ('2022',229,'Chambers, Cliff',5);
insert into rankings (season, rank, player, points) values ('2022',229,'Justice, Jonathan',5);
insert into rankings (season, rank, player, points) values ('2022',229,'Rupp, Leland',5);
insert into rankings (season, rank, player, points) values ('2022',229,'Johnson, Jack',5);
insert into rankings (season, rank, player, points) values ('2022',229,'Arredondo, Luis',5);
insert into rankings (season, rank, player, points) values ('2022',229,'Buchanan, Kooper',5);
insert into rankings (season, rank, player, points) values ('2022',229,'Greenberg, Johnny',5);
insert into rankings (season, rank, player, points) values ('2022',229,'McClure, Dan',5);
insert into rankings (season, rank, player, points) values ('2022',229,'Peterson, Tyler',5);
insert into rankings (season, rank, player, points) values ('2022',229,'Buren, Charlie',5);
insert into rankings (season, rank, player, points) values ('2022',229,'Davis, Thomas',5);
insert into rankings (season, rank, player, points) values ('2022',229,'Kenkel, Jared',5);
insert into rankings (season, rank, player, points) values ('2022',229,'Zeleny, Chad',5);
insert into rankings (season, rank, player, points) values ('2022',229,'Storgion, James',5);
insert into rankings (season, rank, player, points) values ('2022',229,'Tata, Sudheer',5);
insert into rankings (season, rank, player, points) values ('2022',229,'Miller, Edwin',5);
insert into rankings (season, rank, player, points) values ('2022',229,'Lopez, Eridson',5);





select count(*) from rankings where season='2022';

select * from rankings where season='2022' order by convert(rank,unsigned integer) asc;


select player,count(*) from rankings where season='2022' group by player having count(*) > 1;

-- 2022 issue: Eridson Lopez listed twice

/* one time
-- use this time to clean up results that use the old season method

update results set season='2021' where season='2020-21';
update tourneys set season='2021' where season='2020-21';
update results_doubles set season='2021' where season='2020-21';
update tourneys_doubles set season='2021' where season='2020-21';
*/

-- now run name cleanup.  and test online to see if any name fixes need to be done.  Run Season Summary report to see
-- which players have results but names mismatch the rankings

-- Look for Players with latino names and special characters in their name

select * from rankings where season='2022' and player like '%Abraham%';
delete from rankings where season='2022' and rank=68;
insert into rankings (season, rank, player, points) values ('2022',68,'Pena, Abraham',61.52);

select * from rankings where season='2022' and player like '%Ramos%';
select * from results where loser like '%Ramos%';
call sp_fixname('Ramos, Walter','Ramos Jr., Walter');

select * from rankings where season='2022' and player like '%Young%';
call sp_fixname('Young, Stacey','Young, Stacey (sly)');

select * from rankings where season='2022' and player like '%Sosa%';
call sp_fixname('Sosa, David Lopez','Lopez Sosa Erikson, David');

select * from rankings where season='2022' and player like '%Levine%';
call sp_fixname('Levine, Brad','Levine, Bradley');

/* What remains from Season Summary report for 2022?
- none.  all fixed

*/


