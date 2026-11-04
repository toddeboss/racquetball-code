-- 2025-26 rankings manipulation 6/17/26 - 6/24/26

use cp30725_men;

SET SQL_SAFE_UPDATES = 0;

select * from rankings where season='2025-26' order by convert(`rank`,unsigned integer);

/* only if rebuilding b/c of screw up
delete from rankings;
insert into rankings select * from rankings_20260617;
*/

create table rankings_20260623 as select * from rankings;

create table rankings_source_20260617 as select * from rankings_source;

select * from rankings_source order by season desc;

delete from rankings where season='2025-26';

delete from rankings_source where season='2025-26';

insert into rankings_source (season,source) values ('2025-26','6/23/26 irttour.com End of 2025-26 season rankings');

insert into rankings_source (season,source) values ('2026-27','In progress');

select * from rankings_source order by season desc;

commit;

-- now load rankings from working XLS


insert into rankings (season, `rank`, player, points) values ('2025-26',1,'Waselenchuk, Kane',3545);
insert into rankings (season, `rank`, player, points) values ('2025-26',2,'Moscoso, Conrrado',2989);
insert into rankings (season, `rank`, player, points) values ('2025-26',3,'Acuna, Andres',2280);
insert into rankings (season, `rank`, player, points) values ('2025-26',4,'Bredenbeck, Jake',2126);
insert into rankings (season, `rank`, player, points) values ('2025-26',5,'Montoya, Rodrigo',1854);
insert into rankings (season, `rank`, player, points) values ('2025-26',6,'Flores, Jhonatan',1777);
insert into rankings (season, `rank`, player, points) values ('2025-26',7,'Portillo, Eduardo',1520);
insert into rankings (season, `rank`, player, points) values ('2025-26',8,'Parrilla, Andree',1500);
insert into rankings (season, `rank`, player, points) values ('2025-26',9,'Manilla, Adam',1479);
insert into rankings (season, `rank`, player, points) values ('2025-26',10,'Mar, Javier',1469);
insert into rankings (season, `rank`, player, points) values ('2025-26',11,'Natera, Alan',1261);
insert into rankings (season, `rank`, player, points) values ('2025-26',12,'Alonso, Jordy',940);
insert into rankings (season, `rank`, player, points) values ('2025-26',13,'Martell, Jaime',842);
insert into rankings (season, `rank`, player, points) values ('2025-26',14,'Carter, Thomas',812);
insert into rankings (season, `rank`, player, points) values ('2025-26',15,'Trujillo, Erick',805);
insert into rankings (season, `rank`, player, points) values ('2025-26',16,'Gastelum, Diego',788);
insert into rankings (season, `rank`, player, points) values ('2025-26',17,'Carrasco, Kadim',739);
insert into rankings (season, `rank`, player, points) values ('2025-26',18,'Miranda, Gerson',606);
insert into rankings (season, `rank`, player, points) values ('2025-26',19,'Bredenbeck, Sam',578);
insert into rankings (season, `rank`, player, points) values ('2025-26',20,'Garcia, Diego',522);
insert into rankings (season, `rank`, player, points) values ('2025-26',21,'Collins, Robert',470);
insert into rankings (season, `rank`, player, points) values ('2025-26',22,'Sendrey, Cole',466);
insert into rankings (season, `rank`, player, points) values ('2025-26',23,'Wolfe, John',383);
insert into rankings (season, `rank`, player, points) values ('2025-26',24,'Douglas, Jim',370);
insert into rankings (season, `rank`, player, points) values ('2025-26',25,'Salvatierra, Juan',300);
insert into rankings (season, `rank`, player, points) values ('2025-26',26,'Mendoza, DJ',294);
insert into rankings (season, `rank`, player, points) values ('2025-26',27,'Elkins, Cody',290);
insert into rankings (season, `rank`, player, points) values ('2025-26',28,'Zera, Blase',279);
insert into rankings (season, `rank`, player, points) values ('2025-26',29,'Pratt, Charles',244);
insert into rankings (season, `rank`, player, points) values ('2025-26',30,'Ramirez, Carlos',230);
insert into rankings (season, `rank`, player, points) values ('2025-26',31,'Arteaga, Miguel Angel',224);
insert into rankings (season, `rank`, player, points) values ('2025-26',32,'Herrera II, Juan',212);
insert into rankings (season, `rank`, player, points) values ('2025-26',33,'Horn, David',211);
insert into rankings (season, `rank`, player, points) values ('2025-26',34,'Castillo, Santiago',198);
insert into rankings (season, `rank`, player, points) values ('2025-26',34,'Subieta, Ezequiel',198);
insert into rankings (season, `rank`, player, points) values ('2025-26',36,'Aldana, Christian',153);
insert into rankings (season, `rank`, player, points) values ('2025-26',37,'Connell, Lee',150);
insert into rankings (season, `rank`, player, points) values ('2025-26',38,'Gatica, Diego',143);
insert into rankings (season, `rank`, player, points) values ('2025-26',38,'Bear, Alejandro',143);
insert into rankings (season, `rank`, player, points) values ('2025-26',40,'Murray, Samuel',140);
insert into rankings (season, `rank`, player, points) values ('2025-26',41,'Caceres, Jose',116);
insert into rankings (season, `rank`, player, points) values ('2025-26',42,'Sierra, Alex',113);
insert into rankings (season, `rank`, player, points) values ('2025-26',43,'Goth, John',105);
insert into rankings (season, `rank`, player, points) values ('2025-26',44,'Williams, Grant',96);
insert into rankings (season, `rank`, player, points) values ('2025-26',44,'Reque, Esteban',96);
insert into rankings (season, `rank`, player, points) values ('2025-26',46,'Yelverton, Brady',95);
insert into rankings (season, `rank`, player, points) values ('2025-26',47,'Gonzalez, Javier',88);
insert into rankings (season, `rank`, player, points) values ('2025-26',48,'Galicia, Edwin',78);
insert into rankings (season, `rank`, player, points) values ('2025-26',48,'Steadman-Shockley, Homer',76);
insert into rankings (season, `rank`, player, points) values ('2025-26',48,'Horner, Benjamin',76);
insert into rankings (season, `rank`, player, points) values ('2025-26',48,'Antone IV, Wayne',76);
insert into rankings (season, `rank`, player, points) values ('2025-26',52,'Levine, Bradley',75);
insert into rankings (season, `rank`, player, points) values ('2025-26',52,'Guillen, Alvaro',75);
insert into rankings (season, `rank`, player, points) values ('2025-26',54,'Martinez, Emir',74);
insert into rankings (season, `rank`, player, points) values ('2025-26',55,'Galina, Santiago',73);
insert into rankings (season, `rank`, player, points) values ('2025-26',56,'Martin, Anthony',70);
insert into rankings (season, `rank`, player, points) values ('2025-26',57,'Chevaile, Sebastian',62);
insert into rankings (season, `rank`, player, points) values ('2025-26',58,'Mueller, Drew',58);
insert into rankings (season, `rank`, player, points) values ('2025-26',58,'Black, James',58);
insert into rankings (season, `rank`, player, points) values ('2025-26',60,'Herrera, Alejandro',54);
insert into rankings (season, `rank`, player, points) values ('2025-26',61,'Acha, Jhoel',53);
insert into rankings (season, `rank`, player, points) values ('2025-26',62,'Spencer, Sunji',48);
insert into rankings (season, `rank`, player, points) values ('2025-26',62,'Garcia, Gabriel',48);
insert into rankings (season, `rank`, player, points) values ('2025-26',64,'Sharma, Ayan',45);
insert into rankings (season, `rank`, player, points) values ('2025-26',64,'Haines, Travis',45);
insert into rankings (season, `rank`, player, points) values ('2025-26',64,'Huyke, Orlando Josue',45);
insert into rankings (season, `rank`, player, points) values ('2025-26',64,'Sanchez, Antonio',45);
insert into rankings (season, `rank`, player, points) values ('2025-26',68,'Huyke, Mario Andres',43);
insert into rankings (season, `rank`, player, points) values ('2025-26',69,'Giljum, Brendan',40);
insert into rankings (season, `rank`, player, points) values ('2025-26',69,'Whitley, Evan',40);
insert into rankings (season, `rank`, player, points) values ('2025-26',69,'Sutherland, Gatlin',40);
insert into rankings (season, `rank`, player, points) values ('2025-26',69,'Brooks, Sean',40);
insert into rankings (season, `rank`, player, points) values ('2025-26',69,'Lavely, Danny',40);
insert into rankings (season, `rank`, player, points) values ('2025-26',69,'Mangalampalli, Vaishant',40);
insert into rankings (season, `rank`, player, points) values ('2025-26',69,'Teach, Tony',40);
insert into rankings (season, `rank`, player, points) values ('2025-26',69,'Dyck, Steven',40);
insert into rankings (season, `rank`, player, points) values ('2025-26',69,'Acuna, Sergio',40);
insert into rankings (season, `rank`, player, points) values ('2025-26',78,'Garcia, Erik',39);
insert into rankings (season, `rank`, player, points) values ('2025-26',79,'Cubillos, Set',38);
insert into rankings (season, `rank`, player, points) values ('2025-26',79,'Zelada, Mauricio',38);
insert into rankings (season, `rank`, player, points) values ('2025-26',79,'Franco, Sebastian',38);
insert into rankings (season, `rank`, player, points) values ('2025-26',82,'Gonzalez, Salim',37);
insert into rankings (season, `rank`, player, points) values ('2025-26',83,'De Alba, Jose Luis',36);
insert into rankings (season, `rank`, player, points) values ('2025-26',84,'Arnez, Matias',35);
insert into rankings (season, `rank`, player, points) values ('2025-26',84,'Estrada, Alfredo',35);
insert into rankings (season, `rank`, player, points) values ('2025-26',84,'Stark, Jeff',35);
insert into rankings (season, `rank`, player, points) values ('2025-26',84,'Borja, Santiago',35);
insert into rankings (season, `rank`, player, points) values ('2025-26',84,'Ortega, Guillermo',35);
insert into rankings (season, `rank`, player, points) values ('2025-26',89,'Migliore, Victor',32);
insert into rankings (season, `rank`, player, points) values ('2025-26',90,'Bremner, Parker',31);
insert into rankings (season, `rank`, player, points) values ('2025-26',91,'Davenport, Matthew',21);
insert into rankings (season, `rank`, player, points) values ('2025-26',91,'Qualls, Deacon',21);
insert into rankings (season, `rank`, player, points) values ('2025-26',93,'Kosetty, Kalyan',20);
insert into rankings (season, `rank`, player, points) values ('2025-26',93,'Dixon, Jeremy',20);
insert into rankings (season, `rank`, player, points) values ('2025-26',93,'Mtz, Emir',20);
insert into rankings (season, `rank`, player, points) values ('2025-26',96,'Ruiz, Ernesto',19);
insert into rankings (season, `rank`, player, points) values ('2025-26',96,'Camacho, Victor',19);
insert into rankings (season, `rank`, player, points) values ('2025-26',96,'Pruitt, Dylan',19);
insert into rankings (season, `rank`, player, points) values ('2025-26',96,'Rojas, Mauro',19);
insert into rankings (season, `rank`, player, points) values ('2025-26',100,'Meinerz, Lee',18);
insert into rankings (season, `rank`, player, points) values ('2025-26',100,'Barrios, Hector',18);
insert into rankings (season, `rank`, player, points) values ('2025-26',100,'Luensmann, Marcel',18);
insert into rankings (season, `rank`, player, points) values ('2025-26',100,'Reyes, Brandon',18);
insert into rankings (season, `rank`, player, points) values ('2025-26',100,'Jacquez, Jesus Roberto',18);
insert into rankings (season, `rank`, player, points) values ('2025-26',100,'Castelltort, Luis',18);
insert into rankings (season, `rank`, player, points) values ('2025-26',100,'Mettenbrink, Travis',18);
insert into rankings (season, `rank`, player, points) values ('2025-26',100,'Hedalen, Ty',18);
insert into rankings (season, `rank`, player, points) values ('2025-26',100,'Ceja, Leonides',18);
insert into rankings (season, `rank`, player, points) values ('2025-26',100,'Kavanagh, Damien',18);
insert into rankings (season, `rank`, player, points) values ('2025-26',100,'Mousavi, Reza',18);
insert into rankings (season, `rank`, player, points) values ('2025-26',100,'Thielen, Tyler',18);
insert into rankings (season, `rank`, player, points) values ('2025-26',112,'Kelley, Joe',14);
insert into rankings (season, `rank`, player, points) values ('2025-26',113,'Dowell, John',13);
insert into rankings (season, `rank`, player, points) values ('2025-26',114,'Clement Jr., Craig',11);
insert into rankings (season, `rank`, player, points) values ('2025-26',115,'Kelley, Samuel',10);
insert into rankings (season, `rank`, player, points) values ('2025-26',115,'Flores, Jr., Jose',10);
insert into rankings (season, `rank`, player, points) values ('2025-26',117,'Loza, Einer',8);
insert into rankings (season, `rank`, player, points) values ('2025-26',117,'Vargas, Carlos',8);
insert into rankings (season, `rank`, player, points) values ('2025-26',117,'Segreda, Felipe',8);
insert into rankings (season, `rank`, player, points) values ('2025-26',117,'Prigo, Tim',8);
insert into rankings (season, `rank`, player, points) values ('2025-26',117,'Hernandez, Sebastian',8);
insert into rankings (season, `rank`, player, points) values ('2025-26',122,'Blanchard, Ronnie',7);
insert into rankings (season, `rank`, player, points) values ('2025-26',122,'Clouse, Woody',7);
insert into rankings (season, `rank`, player, points) values ('2025-26',122,'Limonciello, Joey',7);
insert into rankings (season, `rank`, player, points) values ('2025-26',125,'Almada, Alejandro',6);
insert into rankings (season, `rank`, player, points) values ('2025-26',126,'Ugalde, Jose',5);
insert into rankings (season, `rank`, player, points) values ('2025-26',126,'Elizondo, Adrian',5);
insert into rankings (season, `rank`, player, points) values ('2025-26',126,'Kurzbard, Fernando',5);
insert into rankings (season, `rank`, player, points) values ('2025-26',126,'Camacho, Felipe',5);
insert into rankings (season, `rank`, player, points) values ('2025-26',126,'Carchi, Martin',5);
insert into rankings (season, `rank`, player, points) values ('2025-26',126,'Cammann, Mychal',5);
insert into rankings (season, `rank`, player, points) values ('2025-26',126,'Carver, Rich',5);
insert into rankings (season, `rank`, player, points) values ('2025-26',126,'Honkanen, Hunter',5);
insert into rankings (season, `rank`, player, points) values ('2025-26',126,'Cueva, Juan',5);
insert into rankings (season, `rank`, player, points) values ('2025-26',135,'Cardenas, Abraham',4);
insert into rankings (season, `rank`, player, points) values ('2025-26',135,'Behm, John',4);
insert into rankings (season, `rank`, player, points) values ('2025-26',135,'Blanchard, Nick',4);
insert into rankings (season, `rank`, player, points) values ('2025-26',135,'Nieto, Elias',4);
insert into rankings (season, `rank`, player, points) values ('2025-26',135,'Jackson, Bob',4);
insert into rankings (season, `rank`, player, points) values ('2025-26',135,'Giordano, Kevin',4);
insert into rankings (season, `rank`, player, points) values ('2025-26',135,'Danos, Timothy',4);
insert into rankings (season, `rank`, player, points) values ('2025-26',135,'Markee, Tim',4);
insert into rankings (season, `rank`, player, points) values ('2025-26',135,'Storgion, James',4);
insert into rankings (season, `rank`, player, points) values ('2025-26',135,'Acuna, Brian',4);
insert into rankings (season, `rank`, player, points) values ('2025-26',135,'Penny, Bill',4);
insert into rankings (season, `rank`, player, points) values ('2025-26',135,'Alvendia, Ted',4);
insert into rankings (season, `rank`, player, points) values ('2025-26',135,'Smith, Keegan',4);
insert into rankings (season, `rank`, player, points) values ('2025-26',135,'Cabana, Orlando',4);
insert into rankings (season, `rank`, player, points) values ('2025-26',135,'Syslo, Christopher',4);
insert into rankings (season, `rank`, player, points) values ('2025-26',150,'Mendoza, DJ (FL)',3);
insert into rankings (season, `rank`, player, points) values ('2025-26',150,'Mansilla, Jaime',3);
insert into rankings (season, `rank`, player, points) values ('2025-26',150,'Baskaran, Arun',3);
insert into rankings (season, `rank`, player, points) values ('2025-26',150,'Lope, Iván',3);
insert into rankings (season, `rank`, player, points) values ('2025-26',150,'Escobar, Norman',3);
insert into rankings (season, `rank`, player, points) values ('2025-26',150,'Maggi, Daniel',3);
insert into rankings (season, `rank`, player, points) values ('2025-26',150,'Salgado Jr., Rodrigo',3);
insert into rankings (season, `rank`, player, points) values ('2025-26',150,'Townsend, London',3);
insert into rankings (season, `rank`, player, points) values ('2025-26',150,'McKissack, Rich',3);
insert into rankings (season, `rank`, player, points) values ('2025-26',150,'Castillo, Juan Carlos',3);
insert into rankings (season, `rank`, player, points) values ('2025-26',150,'Igor, Johan',3);
insert into rankings (season, `rank`, player, points) values ('2025-26',161,'Sincovich, Glenn',2);
insert into rankings (season, `rank`, player, points) values ('2025-26',161,'Otero, Joaquin',2);
insert into rankings (season, `rank`, player, points) values ('2025-26',161,'Petrovich, Serguey',2);
insert into rankings (season, `rank`, player, points) values ('2025-26',161,'Goldberg, Jack',2);
insert into rankings (season, `rank`, player, points) values ('2025-26',161,'Mercado, Abraham',2);
insert into rankings (season, `rank`, player, points) values ('2025-26',161,'Reyes, Fernando',2);
insert into rankings (season, `rank`, player, points) values ('2025-26',161,'Sharifuddin, Nadeem',2);
insert into rankings (season, `rank`, player, points) values ('2025-26',161,'Harris, Jamal',2);
insert into rankings (season, `rank`, player, points) values ('2025-26',161,'Moore, Troy',2);
insert into rankings (season, `rank`, player, points) values ('2025-26',161,'Scarcia, Sergio',2);
insert into rankings (season, `rank`, player, points) values ('2025-26',161,'Young, Stacey',2);
insert into rankings (season, `rank`, player, points) values ('2025-26',161,'Scoppa, Ignacio',2);
insert into rankings (season, `rank`, player, points) values ('2025-26',161,'Zurita, Leandro',2);





select count(*) from rankings where season='2025-26';

select * from rankings where season='2025-26' order by convert(`rank`,unsigned integer) asc;


select player,count(*) from rankings where season='2025-26' group by player having count(*) > 1;

-- 2025-26: resolved multiple dups with Ryan: Luis Casteltort, Jhonathan Flores, Travis Mettenbrink was a web issue
-- DJ Mendoza: 2 now, changed one to (FL)

-- now run name cleanup.  


-- one-off name cleanups

call sp_fixname('Acha, Jhoel Alexis','Acha, Joel');
call sp_fixname('Acha, Jhoel Alexis','Acha, Jhoel');

call sp_fixname('Ortega Jr., Guillermo','Ortega, Guillermo');



-- Now Run Season Summary report to see which players have results but names mismatch the rankings

-- Migueal Angel Arteaga not matching up, why?

select * from rankings where player like '%Ortega%';

update rankings set player='Arteaga, Miguel Angel' where player='Angel, Miguel Angel';

-- Just one player missing in Seson Summary report: Damien Kavanaugh, who went 0-1 in an event and has no points.alter

-- we're missing dozens of players who earned points in satellites, which aren't in the database.  



-- that's it all done