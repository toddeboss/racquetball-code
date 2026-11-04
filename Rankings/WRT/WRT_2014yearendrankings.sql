
/* 1/16/19: 2013 WRT year end rankings */


use cp30725_wrt;

SET SQL_SAFE_UPDATES = 0;


create table rankings_source_20190116 as select * from rankings_source;

create table rankings_20190116 as select * from rankings;

delete from rankings_source where season='2014';

insert into rankings_source (season,source) values ('2014','WRT Rankings 2016.xls from Pablo Fajre');


insert into rankings (season, rank, player, points) values ('2014','1','Gutierrez, Polo',6840);
insert into rankings (season, rank, player, points) values ('2014','2','Cardona, Alex',6800);
insert into rankings (season, rank, player, points) values ('2014','3','Bredenbeck, Jake',6700);
insert into rankings (season, rank, player, points) values ('2014','4','Landa, Alex',5100);
insert into rankings (season, rank, player, points) values ('2014','5','Horn, Bobby',4325);
insert into rankings (season, rank, player, points) values ('2014','6','Iwaasa, Coby',3225);
insert into rankings (season, rank, player, points) values ('2014','7','Moreno, Javier',3200);
insert into rankings (season, rank, player, points) values ('2014','8','Herrera, Anthony',2700);
insert into rankings (season, rank, player, points) values ('2014','9','Martell, Jaime',2140);
insert into rankings (season, rank, player, points) values ('2014','10','Guevara, Gerardo',1800);
insert into rankings (season, rank, player, points) values ('2014','11','Franco, Sebastian',1760);
insert into rankings (season, rank, player, points) values ('2014','12','Rios, Fernando',1600);
insert into rankings (season, rank, player, points) values ('2014','13','Almada, Alejandro',1500);
insert into rankings (season, rank, player, points) values ('2014','13','Rojas, Marco',1500);
insert into rankings (season, rank, player, points) values ('2014','15','Lavely, Daniel',1440);
insert into rankings (season, rank, player, points) values ('2014','16','Mejia, Gil',1400);
insert into rankings (season, rank, player, points) values ('2014','16','Sandoval, Erick',1400);
insert into rankings (season, rank, player, points) values ('2014','16','Longoria, Cristian',1400);
insert into rankings (season, rank, player, points) values ('2014','19','Troncoso, Francisco',1380);
insert into rankings (season, rank, player, points) values ('2014','20','Camacho, Felipe',1200);
insert into rankings (season, rank, player, points) values ('2014','20','Cocco, Alexi',1200);
insert into rankings (season, rank, player, points) values ('2014','20','Parrilla, Andree',1200);
insert into rankings (season, rank, player, points) values ('2014','23','Diaz, Jose',1000);
insert into rankings (season, rank, player, points) values ('2014','24','Kwon, Daeyong',840);
insert into rankings (season, rank, player, points) values ('2014','24','Keller, Roland',840);
insert into rankings (season, rank, player, points) values ('2014','26','Salgado, Rodrigo',720);
insert into rankings (season, rank, player, points) values ('2014','27','Kurzbard, Pablo',700);
insert into rankings (season, rank, player, points) values ('2014','28','Kurzbard, Fernando',680);
insert into rankings (season, rank, player, points) values ('2014','28','Collins, Robert',680);
insert into rankings (season, rank, player, points) values ('2014','30','Carrasco, Kadim',660);
insert into rankings (season, rank, player, points) values ('2014','30','Ugalde, Jose Daniel',660);
insert into rankings (season, rank, player, points) values ('2014','32','Neri, Daniel',600);
insert into rankings (season, rank, player, points) values ('2014','32','Castillo, Cesar',600);
insert into rankings (season, rank, player, points) values ('2014','32','Martinez, Edson',600);
insert into rankings (season, rank, player, points) values ('2014','32','Mar, Javier',600);
insert into rankings (season, rank, player, points) values ('2014','36','Perez, Luis',540);
insert into rankings (season, rank, player, points) values ('2014','37','Franco, Gerardo',480);
insert into rankings (season, rank, player, points) values ('2014','37','Mendez, Miguel',480);
insert into rankings (season, rank, player, points) values ('2014','39','Filippini, Rafael',440);
insert into rankings (season, rank, player, points) values ('2014','39','Cullen, Kurtis',440);
insert into rankings (season, rank, player, points) values ('2014','41','Alvarez, Jose Daniel',400);
insert into rankings (season, rank, player, points) values ('2014','42','De Leon, Ramon',360);
insert into rankings (season, rank, player, points) values ('2014','42','Urquidi, Hector',360);
insert into rankings (season, rank, player, points) values ('2014','44','Miramontes, Nicolai',325);
insert into rankings (season, rank, player, points) values ('2014','44','Kirch, Bradley',325);
insert into rankings (season, rank, player, points) values ('2014','46','Clarke, Andrew',320);
insert into rankings (season, rank, player, points) values ('2014','46','Escobedo, Miguel',320);
insert into rankings (season, rank, player, points) values ('2014','46','Oliver, Jimmy',320);
insert into rankings (season, rank, player, points) values ('2014','46','Lloyd, Sawyer',320);
insert into rankings (season, rank, player, points) values ('2014','50','Herrera, Juan',300);
insert into rankings (season, rank, player, points) values ('2014','50','Sandoval, Manolo',300);
insert into rankings (season, rank, player, points) values ('2014','50','Knoth, Taylor',300);
insert into rankings (season, rank, player, points) values ('2014','53','Natera, Alan',280);
insert into rankings (season, rank, player, points) values ('2014','53','Palomino, Alan',280);
insert into rankings (season, rank, player, points) values ('2014','53','Tellez, Enrique',280);
insert into rankings (season, rank, player, points) values ('2014','53','Rodriguez, Junior',280);
insert into rankings (season, rank, player, points) values ('2014','57','Gardea, Miguel',240);
insert into rankings (season, rank, player, points) values ('2014','57','Guevara, Alejandro',240);
insert into rankings (season, rank, player, points) values ('2014','57','Portillo, Eduardo',240);
insert into rankings (season, rank, player, points) values ('2014','57','Alonso, Alan',240);
insert into rankings (season, rank, player, points) values ('2014','57','Loreto, Juan',240);
insert into rankings (season, rank, player, points) values ('2014','57','Hojat, Sam',240);
insert into rankings (season, rank, player, points) values ('2014','57','Gonzalez, Pedro',240);
insert into rankings (season, rank, player, points) values ('2014','57','Zamorano, Martin',240);
insert into rankings (season, rank, player, points) values ('2014','65','Martinez, Jose',200);
insert into rankings (season, rank, player, points) values ('2014','65','Rojas, Daniel',200);
insert into rankings (season, rank, player, points) values ('2014','65','Sada, Eddie',200);
insert into rankings (season, rank, player, points) values ('2014','65','Keller, Carlos',200);
insert into rankings (season, rank, player, points) values ('2014','65','Esparza, Rodolfo',200);
insert into rankings (season, rank, player, points) values ('2014','65','Robison, Chase',200);
insert into rankings (season, rank, player, points) values ('2014','65','Mercado, Mario',200);
insert into rankings (season, rank, player, points) values ('2014','65','Zelada, Mauricio',200);
insert into rankings (season, rank, player, points) values ('2014','65','Garcia, Erick',200);
insert into rankings (season, rank, player, points) values ('2014','65','Goldblatt, Geoff',200);
insert into rankings (season, rank, player, points) values ('2014','65','Leija, Missael',200);
insert into rankings (season, rank, player, points) values ('2014','76','Marquez, Alan',160);
insert into rankings (season, rank, player, points) values ('2014','76','Hidalgo, Mario',160);
insert into rankings (season, rank, player, points) values ('2014','76','Barragan, Cesar',160);
insert into rankings (season, rank, player, points) values ('2014','76','Delgado, Julio',160);
insert into rankings (season, rank, player, points) values ('2014','76','Martinez, Mike',160);
insert into rankings (season, rank, player, points) values ('2014','76','Maldonado, Alvaro',160);
insert into rankings (season, rank, player, points) values ('2014','76','Ramos, Pepe',160);
insert into rankings (season, rank, player, points) values ('2014','76','Ramos, Roman',160);
insert into rankings (season, rank, player, points) values ('2014','76','Guerrero, Alejandro',160);
insert into rankings (season, rank, player, points) values ('2014','76','Chiver, Michael',160);
insert into rankings (season, rank, player, points) values ('2014','86','Canedo, Santiago',120);
insert into rankings (season, rank, player, points) values ('2014','86','Morales, Rafael',120);
insert into rankings (season, rank, player, points) values ('2014','86','Alvidrez, Jose',120);
insert into rankings (season, rank, player, points) values ('2014','86','Castro, Pedro',120);
insert into rankings (season, rank, player, points) values ('2014','86','Rodriguez, Daniel',120);
insert into rankings (season, rank, player, points) values ('2014','86','Parrilla, Fabian',120);
insert into rankings (season, rank, player, points) values ('2014','86','Burruel, Arturo',120);
insert into rankings (season, rank, player, points) values ('2014','86','Suarez, Mauricio',120);
insert into rankings (season, rank, player, points) values ('2014','86','Medina, Rogelio',120);
insert into rankings (season, rank, player, points) values ('2014','86','Silva, Diego',120);
insert into rankings (season, rank, player, points) values ('2014','86','McGlothing, Jeremy',120);
insert into rankings (season, rank, player, points) values ('2014','86','Vasquez, Armando',120);
insert into rankings (season, rank, player, points) values ('2014','86','Rodriguez, Erick',120);
insert into rankings (season, rank, player, points) values ('2014','86','Pesqueira, Luis',120);
insert into rankings (season, rank, player, points) values ('2014','86','Zamora, Mario',120);
insert into rankings (season, rank, player, points) values ('2014','86','Yanez, Ramon',120);
insert into rankings (season, rank, player, points) values ('2014','86','Mendoza, David',120);
insert into rankings (season, rank, player, points) values ('2014','86','Delgado, Cesar',120);
insert into rankings (season, rank, player, points) values ('2014','86','Ochoa, Ernesto',120);
insert into rankings (season, rank, player, points) values ('2014','86','Castro, Cesar',120);
insert into rankings (season, rank, player, points) values ('2014','86','Green, Kenny',120);
insert into rankings (season, rank, player, points) values ('2014','86','Werth, Dima',120);
insert into rankings (season, rank, player, points) values ('2014','86','Severns, Kyle',120);
insert into rankings (season, rank, player, points) values ('2014','86','Abidi, Fahd',120);
insert into rankings (season, rank, player, points) values ('2014','86','Jabbary, Amir',120);
insert into rankings (season, rank, player, points) values ('2014','86','Ernst, Joel',120);
insert into rankings (season, rank, player, points) values ('2014','86','Young, Cameron',120);
insert into rankings (season, rank, player, points) values ('2014','86','Baca, Alfred',120);
insert into rankings (season, rank, player, points) values ('2014','86','Gutierrez, Oscar',120);
insert into rankings (season, rank, player, points) values ('2014','86','Stanley, Charles',120);
insert into rankings (season, rank, player, points) values ('2014','86','Gonzalez, Julian',120);
insert into rankings (season, rank, player, points) values ('2014','86','Crowe, Michael',120);
insert into rankings (season, rank, player, points) values ('2014','86','Robles, Bruce',120);
insert into rankings (season, rank, player, points) values ('2014','86','Riddle, Nathan',120);
insert into rankings (season, rank, player, points) values ('2014','86','Rivera, Fernando',120);
insert into rankings (season, rank, player, points) values ('2014','86','Ortiz, Jorge',120);
insert into rankings (season, rank, player, points) values ('2014','86','Landeryou, Tim',120);
insert into rankings (season, rank, player, points) values ('2014','86','Martinez, Juan',120);
insert into rankings (season, rank, player, points) values ('2014','86','Archer, Zach',120);
insert into rankings (season, rank, player, points) values ('2014','86','Espinoza, Wilden',120);
insert into rankings (season, rank, player, points) values ('2014','86','Gonzalez, Miguel',120);
insert into rankings (season, rank, player, points) values ('2014','86','Perez, Edgardo',120);
insert into rankings (season, rank, player, points) values ('2014','86','Garcia, Santiago',120);
insert into rankings (season, rank, player, points) values ('2014','86','Jaquez, Luis',120);
insert into rankings (season, rank, player, points) values ('2014','86','Tristan, Agustin',120);
insert into rankings (season, rank, player, points) values ('2014','86','Mc Carthy, Nicolas',120);
insert into rankings (season, rank, player, points) values ('2014','86','Galicia, Edwin',120);
insert into rankings (season, rank, player, points) values ('2014','86','Delgado, Rodrigo',120);
insert into rankings (season, rank, player, points) values ('2014','86','Vargas, Mauricio',120);
insert into rankings (season, rank, player, points) values ('2014','86','Capandegui, Franco',120);
insert into rankings (season, rank, player, points) values ('2014','86','Gutierrez, Rey',120);
insert into rankings (season, rank, player, points) values ('2014','86','Macias, Oscar',120);
insert into rankings (season, rank, player, points) values ('2014','86','Ainslie, Enrique',120);
insert into rankings (season, rank, player, points) values ('2014','86','Hagopian, Claude',120);



commit;

-- now run names cleanup

select count(*) from rankings where season='2012';