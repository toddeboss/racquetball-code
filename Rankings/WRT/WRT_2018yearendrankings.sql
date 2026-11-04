
use cp30725_wrt;

SET SQL_SAFE_UPDATES = 0;

/* 12/27/18: WRT year end rankings */

create table rankings_source_20181227 as select * from rankings_source;

create table rankings_20181227 as select * from rankings;


insert into rankings_source (season,source) values ('2018','worldracquetballtour.com as of 12/26/18');


insert into rankings (season, rank, player, points) values ('2018','1','Bredenbeck, Jake',3600);
insert into rankings (season, rank, player, points) values ('2018','2','Parrilla, Andree',3108);
insert into rankings (season, rank, player, points) values ('2018','3','Horn, David',3020);
insert into rankings (season, rank, player, points) values ('2018','4','Martell, Jaime',2720);
insert into rankings (season, rank, player, points) values ('2018','5','Iwaasa, Coby',1600);
insert into rankings (season, rank, player, points) values ('2018','6','Franco, Gerardo',1505);
insert into rankings (season, rank, player, points) values ('2018','7','Avila, Luis',1400);
insert into rankings (season, rank, player, points) values ('2018','8','Montoya, Rodrigo',1200);
insert into rankings (season, rank, player, points) values ('2018','9','Cardona, Alejandro',1035);
insert into rankings (season, rank, player, points) values ('2018','10','Longoria, Christian',1008);
insert into rankings (season, rank, player, points) values ('2018','11','Benson, Justus',1005);
insert into rankings (season, rank, player, points) values ('2018','12','Garay, Eduardo',910);
insert into rankings (season, rank, player, points) values ('2018','13','Zelada, Mauricio',900);
insert into rankings (season, rank, player, points) values ('2018','13','Troncoso, Francisco',900);
insert into rankings (season, rank, player, points) values ('2018','15','Portillo, Eduardo',808);
insert into rankings (season, rank, player, points) values ('2018','16','Murray, Samuel',800);
insert into rankings (season, rank, player, points) values ('2018','16','Alonso, Jordy',800);
insert into rankings (season, rank, player, points) values ('2018','18','Vazquez, Kevin',600);
insert into rankings (season, rank, player, points) values ('2018','18','Mar, Javier',600);
insert into rankings (season, rank, player, points) values ('2018','20','Natera, Alan',405);
insert into rankings (season, rank, player, points) values ('2018','21','Landeryou, Tim',400);
insert into rankings (season, rank, player, points) values ('2018','21','Knoth, Taylor',400);
insert into rankings (season, rank, player, points) values ('2018','21','Prentice, Tanner',400);
insert into rankings (season, rank, player, points) values ('2018','24','Carter, Thomas',330);
insert into rankings (season, rank, player, points) values ('2018','25','Cunningham, Austin',320);
insert into rankings (season, rank, player, points) values ('2018','26','Stincer, David',305);
insert into rankings (season, rank, player, points) values ('2018','26','Shimizu, Hiroshi',305);
insert into rankings (season, rank, player, points) values ('2018','28','Manzuri, Shai',300);
insert into rankings (season, rank, player, points) values ('2018','28','Fernandez, Sebastian',300);
insert into rankings (season, rank, player, points) values ('2018','28','Everhart, Destry',300);
insert into rankings (season, rank, player, points) values ('2018','28','Camacho, Victor',300);
insert into rankings (season, rank, player, points) values ('2018','28','Martinez, Edson',300);
insert into rankings (season, rank, player, points) values ('2018','28','Ochoa, Ernesto',300);
insert into rankings (season, rank, player, points) values ('2018','28','Herrera, Daniel',300);
insert into rankings (season, rank, player, points) values ('2018','35','Frattinger, Ian',253);
insert into rankings (season, rank, player, points) values ('2018','36','Buller, Jeff',250);
insert into rankings (season, rank, player, points) values ('2018','36','Cocco Hayes, Alexi David',250);
insert into rankings (season, rank, player, points) values ('2018','36','Connell, Lee',250);
insert into rankings (season, rank, player, points) values ('2018','36','Brayley, Mitch',250);
insert into rankings (season, rank, player, points) values ('2018','36','Bredenbeck, Sam',250);
insert into rankings (season, rank, player, points) values ('2018','36','Acuna, Sergio',250);
insert into rankings (season, rank, player, points) values ('2018','42','Almada, Alejandro',153);
insert into rankings (season, rank, player, points) values ('2018','43','Mendoza, Erik',150);
insert into rankings (season, rank, player, points) values ('2018','43','Castillo, Rogelio',150);
insert into rankings (season, rank, player, points) values ('2018','43','Fernandez, A.j.',150);
insert into rankings (season, rank, player, points) values ('2018','43','Sada, Eddie',150);
insert into rankings (season, rank, player, points) values ('2018','43','Walters, Brent',150);
insert into rankings (season, rank, player, points) values ('2018','43','Kurzbard, Fernando',150);
insert into rankings (season, rank, player, points) values ('2018','43','Rhodes, John',150);
insert into rankings (season, rank, player, points) values ('2018','43','Loreto, Juan',150);
insert into rankings (season, rank, player, points) values ('2018','43','Valadez, Raul',150);
insert into rankings (season, rank, player, points) values ('2018','43','Maldonado, Daniel',150);
insert into rankings (season, rank, player, points) values ('2018','43','Cuevas Fernandez, Erick',150);

commit;

-- now run names cleanup