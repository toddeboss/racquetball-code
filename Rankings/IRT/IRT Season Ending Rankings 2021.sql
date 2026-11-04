-- 2021 rankings manipulation

use cp30725_men;

SET SQL_SAFE_UPDATES = 0;

select * from rankings where season='2021' order by convert(rank,unsigned integer);

create table rankings_20211231 as select * from rankings;

create table rankings_source_20211213 as select * from rankings_source;

select * from rankings_source order by season desc;

delete from rankings where season='2021';

delete from rankings_source where season='2020-21';

insert into rankings_source (season,source) values ('2021','12/31/21 irt-tour.com end of season rankings as of 12/31/21');

insert into rankings_source (season,source) values ('2022','In progress');

select * from rankings_source order by season desc;


commit;

-- now load rankings from working XLS

insert into rankings (season, rank, player, points) values ('2021',1,'De La Rosa, Daniel',3373.65);
insert into rankings (season, rank, player, points) values ('2021',2,'Landa, Alejandro',2469.16);
insert into rankings (season, rank, player, points) values ('2021',3,'Murray, Samuel',2269.24);
insert into rankings (season, rank, player, points) values ('2021',4,'Parrilla, Andree',2145.06);
insert into rankings (season, rank, player, points) values ('2021',5,'Portillo, Eduardo',2047.02);
insert into rankings (season, rank, player, points) values ('2021',6,'Waselenchuk, Kane',1990.57);
insert into rankings (season, rank, player, points) values ('2021',7,'Moscoso, Conrrado',1897.15);
insert into rankings (season, rank, player, points) values ('2021',8,'Carson, Rocky',1878.01);
insert into rankings (season, rank, player, points) values ('2021',9,'Bredenbeck, Jake',1642.01);
insert into rankings (season, rank, player, points) values ('2021',10,'Mercado, Mario',1606.16);
insert into rankings (season, rank, player, points) values ('2021',11,'Beltran, Alvaro',1549.03);
insert into rankings (season, rank, player, points) values ('2021',12,'Keller, Carlos',1336.03);
insert into rankings (season, rank, player, points) values ('2021',13,'Franco, Sebastian',1071.01);
insert into rankings (season, rank, player, points) values ('2021',14,'Manilla, Adam',1040.05);
insert into rankings (season, rank, player, points) values ('2021',15,'Garay, Eduardo',968.02);
insert into rankings (season, rank, player, points) values ('2021',16,'Acuna, Andres',851.53);
insert into rankings (season, rank, player, points) values ('2021',17,'Montoya, Rodrigo',802);
insert into rankings (season, rank, player, points) values ('2021',18,'Carter, Thomas',791.55);
insert into rankings (season, rank, player, points) values ('2021',19,'Fernandez, Sebastian',651.02);
insert into rankings (season, rank, player, points) values ('2021',20,'Mar, Javier',636.02);
insert into rankings (season, rank, player, points) values ('2021',21,'Natera, Alan',494.06);
insert into rankings (season, rank, player, points) values ('2021',22,'Estrada, Javier',480.01);
insert into rankings (season, rank, player, points) values ('2021',23,'Carrasco, Kadim',397.08);
insert into rankings (season, rank, player, points) values ('2021',24,'Bredenbeck, Sam',396.54);
insert into rankings (season, rank, player, points) values ('2021',25,'Franco, Gerardo',381.01);
insert into rankings (season, rank, player, points) values ('2021',26,'Camacho, Felipe',373.53);
insert into rankings (season, rank, player, points) values ('2021',27,'Collins, Robert',357.58);
insert into rankings (season, rank, player, points) values ('2021',28,'Zelada, Mauricio',345.52);
insert into rankings (season, rank, player, points) values ('2021',29,'Cuevas, Erick',254.03);
insert into rankings (season, rank, player, points) values ('2021',30,'McClellan, Scott',235.04);
insert into rankings (season, rank, player, points) values ('2021',31,'Cubillos, Set',233.53);
insert into rankings (season, rank, player, points) values ('2021',32,'Trujillo, Erick',193.02);
insert into rankings (season, rank, player, points) values ('2021',33,'Miller, Maurice',181.99);
insert into rankings (season, rank, player, points) values ('2021',34,'Salvatierra, Juan',158.54);
insert into rankings (season, rank, player, points) values ('2021',35,'Pratt, Charles',152.02);
insert into rankings (season, rank, player, points) values ('2021',36,'Galicia, Edwin',146.02);
insert into rankings (season, rank, player, points) values ('2021',37,'Horn, David',145.01);
insert into rankings (season, rank, player, points) values ('2021',38,'Kelley, Joe',143.02);
insert into rankings (season, rank, player, points) values ('2021',39,'Cunningham, Austin',136.98);
insert into rankings (season, rank, player, points) values ('2021',40,'Martin, Anthony',134.03);
insert into rankings (season, rank, player, points) values ('2021',41,'Douglas, Jim',132.04);
insert into rankings (season, rank, player, points) values ('2021',42,'Wer, Christian',130.53);
insert into rankings (season, rank, player, points) values ('2021',43,'Arteaga Guzman, Miguel Angel',125);
insert into rankings (season, rank, player, points) values ('2021',44,'Shahin, Majeed',122.54);
insert into rankings (season, rank, player, points) values ('2021',45,'Martell, Jaime',120);
insert into rankings (season, rank, player, points) values ('2021',46,'Martinez, Javier',112.04);
insert into rankings (season, rank, player, points) values ('2021',47,'Pruitt, Dylan',105);
insert into rankings (season, rank, player, points) values ('2021',48,'Riffel, Nicholas',96.52);
insert into rankings (season, rank, player, points) values ('2021',49,'Gleason, Andrew',96.51);
insert into rankings (season, rank, player, points) values ('2021',50,'Herrera, Alejandro',93.02);
insert into rankings (season, rank, player, points) values ('2021',51,'Peña, Abraham',92.01);
insert into rankings (season, rank, player, points) values ('2021',52,'Rodriguez, Rodrigo',87.53);
insert into rankings (season, rank, player, points) values ('2021',53,'Warigon, Troy',86.51);
insert into rankings (season, rank, player, points) values ('2021',54,'Samson, Ferd',80.03);
insert into rankings (season, rank, player, points) values ('2021',55,'Benson, Justus',80.01);
insert into rankings (season, rank, player, points) values ('2021',56,'Zamudio, Alex',77);
insert into rankings (season, rank, player, points) values ('2021',56,'Shea, Josh',77);
insert into rankings (season, rank, player, points) values ('2021',58,'Rodriguez, Juan Pablo',75.02);
insert into rankings (season, rank, player, points) values ('2021',59,'Meinerz, Lee',75);
insert into rankings (season, rank, player, points) values ('2021',60,'Jennings, Brennen',72.01);
insert into rankings (season, rank, player, points) values ('2021',61,'Williams, Zachary',70.01);
insert into rankings (season, rank, player, points) values ('2021',61,'Gómez, Andrés',70.01);
insert into rankings (season, rank, player, points) values ('2021',63,'Dowell, John',70);
insert into rankings (season, rank, player, points) values ('2021',64,'Adler, Joel',67.02);
insert into rankings (season, rank, player, points) values ('2021',65,'Fontana, Matt',67);
insert into rankings (season, rank, player, points) values ('2021',66,'Barrios, Hector',61.53);
insert into rankings (season, rank, player, points) values ('2021',67,'Ulliman, Kyle',61.01);
insert into rankings (season, rank, player, points) values ('2021',68,'Manzuri, Shai',61);
insert into rankings (season, rank, player, points) values ('2021',69,'Rogers, Bradly',60);
insert into rankings (season, rank, player, points) values ('2021',69,'Cardona, Alejandro',60);
insert into rankings (season, rank, player, points) values ('2021',69,'Hansen, Blake',60);
insert into rankings (season, rank, player, points) values ('2021',69,'Rutherford, Hal',60);
insert into rankings (season, rank, player, points) values ('2021',73,'Alonso, Jordy',58.01);
insert into rankings (season, rank, player, points) values ('2021',74,'Acuna, Sergio',56.52);
insert into rankings (season, rank, player, points) values ('2021',75,'Longoria, Sebastián',56.51);
insert into rankings (season, rank, player, points) values ('2021',76,'Castro, Roberto',54.99);
insert into rankings (season, rank, player, points) values ('2021',77,'Migliore, Victor',54.01);
insert into rankings (season, rank, player, points) values ('2021',78,'Connell, Lee',52.01);
insert into rankings (season, rank, player, points) values ('2021',79,'Shimizu, Hiroshi',51.01);
insert into rankings (season, rank, player, points) values ('2021',79,'Landeryou, Tim',51.01);
insert into rankings (season, rank, player, points) values ('2021',81,'Horner, Benjamin',50.01);
insert into rankings (season, rank, player, points) values ('2021',82,'Everhart, Destry',49.99);
insert into rankings (season, rank, player, points) values ('2021',83,'Jaldin Lobo, Adrian',47.02);
insert into rankings (season, rank, player, points) values ('2021',84,'Hansen, Timmy',46.51);
insert into rankings (season, rank, player, points) values ('2021',84,'Garcia, Gabriel',46.51);
insert into rankings (season, rank, player, points) values ('2021',86,'Nieto Valadez, Oscar Elias',46.01);
insert into rankings (season, rank, player, points) values ('2021',87,'Mendoza, Geovani',45.02);
insert into rankings (season, rank, player, points) values ('2021',87,'Wolfe, John',45.02);
insert into rankings (season, rank, player, points) values ('2021',89,'Kelley, Samuel',45.01);
insert into rankings (season, rank, player, points) values ('2021',90,'Shoemaker, Lucas',45);
insert into rankings (season, rank, player, points) values ('2021',90,'Loreto, Juan',45);
insert into rankings (season, rank, player, points) values ('2021',90,'Jackson, Bob',45);
insert into rankings (season, rank, player, points) values ('2021',93,'Reque, Esteban',41.02);
insert into rankings (season, rank, player, points) values ('2021',94,'Quinlan, Patrick',40);
insert into rankings (season, rank, player, points) values ('2021',94,'Castro, Pedro',40);
insert into rankings (season, rank, player, points) values ('2021',94,'Antone Iv, Wayne',40);
insert into rankings (season, rank, player, points) values ('2021',97,'Diaz, Daniel',39.99);
insert into rankings (season, rank, player, points) values ('2021',98,'Baron, Ben',35.01);
insert into rankings (season, rank, player, points) values ('2021',99,'Spelts, Art',35);
insert into rankings (season, rank, player, points) values ('2021',99,'Hansen, Brad',35);
insert into rankings (season, rank, player, points) values ('2021',99,'Prigo, Tim',35);
insert into rankings (season, rank, player, points) values ('2021',99,'Julbes, Paul',35);
insert into rankings (season, rank, player, points) values ('2021',99,'Basta, E.j.',35);
insert into rankings (season, rank, player, points) values ('2021',99,'Gerhardt, Thomas',35);
insert into rankings (season, rank, player, points) values ('2021',99,'Atwell, Kipp',35);
insert into rankings (season, rank, player, points) values ('2021',106,'Reid, Dylan',33.01);
insert into rankings (season, rank, player, points) values ('2021',106,'Almada, Alejandro',33.01);
insert into rankings (season, rank, player, points) values ('2021',108,'Diaz, Jose',32.01);
insert into rankings (season, rank, player, points) values ('2021',108,'Keller, Roland',32.01);
insert into rankings (season, rank, player, points) values ('2021',110,'Spencer, Sunji',32);
insert into rankings (season, rank, player, points) values ('2021',111,'Flores, Jr., Jose',31.99);
insert into rankings (season, rank, player, points) values ('2021',111,'Swain, Cliff',31.99);
insert into rankings (season, rank, player, points) values ('2021',113,'Jimenez, Noslen',31.01);
insert into rankings (season, rank, player, points) values ('2021',114,'Arenas, Felipe',30);
insert into rankings (season, rank, player, points) values ('2021',114,'Rivera, Fernando Javier',30);
insert into rankings (season, rank, player, points) values ('2021',114,'Lazenby, Alex',30);
insert into rankings (season, rank, player, points) values ('2021',114,'Ortega Jr, Guillermo Jesus',30);
insert into rankings (season, rank, player, points) values ('2021',114,'Garcia, Erik',30);
insert into rankings (season, rank, player, points) values ('2021',114,'Cobkit, Justin',30);
insert into rankings (season, rank, player, points) values ('2021',114,'Galvez, Carlos Jose',30);
insert into rankings (season, rank, player, points) values ('2021',114,'Davenport, Matthew',30);
insert into rankings (season, rank, player, points) values ('2021',114,'Barnabei, Drew',30);
insert into rankings (season, rank, player, points) values ('2021',114,'Eisemann, Richard',30);
insert into rankings (season, rank, player, points) values ('2021',114,'Rupp, Leland',30);
insert into rankings (season, rank, player, points) values ('2021',114,'McCunniff, Brad',30);
insert into rankings (season, rank, player, points) values ('2021',114,'Bronson, Jim',30);
insert into rankings (season, rank, player, points) values ('2021',114,'Dixon, Jeremy',30);
insert into rankings (season, rank, player, points) values ('2021',114,'Austin, David',30);
insert into rankings (season, rank, player, points) values ('2021',114,'Meguerditchian, Garin',30);
insert into rankings (season, rank, player, points) values ('2021',114,'Sendrey, Cole',30);
insert into rankings (season, rank, player, points) values ('2021',131,'Bowens Jr., Kevin',29.99);
insert into rankings (season, rank, player, points) values ('2021',131,'Burns, Jonathan',29.99);
insert into rankings (season, rank, player, points) values ('2021',131,'Deeney, Jordan',29.99);
insert into rankings (season, rank, player, points) values ('2021',131,'Thomas, Cody',29.99);
insert into rankings (season, rank, player, points) values ('2021',131,'Gomez Reyes, Francisco',29.99);
insert into rankings (season, rank, player, points) values ('2021',131,'Lan, Jimmy',29.99);
insert into rankings (season, rank, player, points) values ('2021',131,'Kosetty, Kalyan',29.99);
insert into rankings (season, rank, player, points) values ('2021',138,'Allin, Patrick',25.02);
insert into rankings (season, rank, player, points) values ('2021',138,'Tapia Zúñiga, Juan José',25.02);
insert into rankings (season, rank, player, points) values ('2021',140,'Kingsford, Jacob',25.01);
insert into rankings (season, rank, player, points) values ('2021',141,'Lazenby, Zack',25);
insert into rankings (season, rank, player, points) values ('2021',141,'Rodriguez, Daniel',25);
insert into rankings (season, rank, player, points) values ('2021',143,'Majxner, Matthew',22);
insert into rankings (season, rank, player, points) values ('2021',143,'Allen, Jansen',22);
insert into rankings (season, rank, player, points) values ('2021',145,'Miramontes, Nicolai',20.02);
insert into rankings (season, rank, player, points) values ('2021',146,'Cosmano, Anthony',20.01);
insert into rankings (season, rank, player, points) values ('2021',147,'Avila, Luis',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Ochoa, Ernesto',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Paul, Josh',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Hale, Lance',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Perez, Michael',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Sharifuddin, Nadeem',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Kukoyi, Bolaji',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Coggins, Guy',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Mijares, Marco',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Tribble, Preston',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Troncoso, Francisco',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Dresbach, Rom',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Magana, Michael',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Goedker, Steve',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Baghurst, Timothy',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Clarke, Andrew',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Giljum, Brendan',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Izzi, Derek',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Melster, Matt',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Goldblatt, Geoff',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Dardani, Aaron',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Healy, Matthew',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Cruz, Julian',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Davis, Thomas',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Meeks, Bailey',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Saha, Uttoreo',20);
insert into rankings (season, rank, player, points) values ('2021',147,'Rodriguez, Juan Pablo',20);
insert into rankings (season, rank, player, points) values ('2021',174,'Subieta, Ezequiel',17.01);
insert into rankings (season, rank, player, points) values ('2021',174,'Robles, Bruce',17.01);
insert into rankings (season, rank, player, points) values ('2021',176,'Moreno, Javier',15.01);
insert into rankings (season, rank, player, points) values ('2021',176,'Sullivan, Seth',15.01);
insert into rankings (season, rank, player, points) values ('2021',176,'Aguilar, Luis',15.01);
insert into rankings (season, rank, player, points) values ('2021',176,'Cuellar, Alejandro',15.01);
insert into rankings (season, rank, player, points) values ('2021',176,'Arnez, Matias',15.01);
insert into rankings (season, rank, player, points) values ('2021',176,'Cruz, Julian',15.01);
insert into rankings (season, rank, player, points) values ('2021',176,'Zera, Blase',15.01);
insert into rankings (season, rank, player, points) values ('2021',176,'Cuesta, Fabian',15.01);
insert into rankings (season, rank, player, points) values ('2021',176,'Siles Gonzales, Vladimir Fernando',15.01);
insert into rankings (season, rank, player, points) values ('2021',185,'Ewing, Eric',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Nieto, Elias',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Torres, Jared',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Svabek, Ladislav',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Storgion, James',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Simpson, Justin',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Reyes, Carlos',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Giraldo, Carlos',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Buchanan, Kooper',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Turnquest, Bradnado',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Vanbemmelen, Troy',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Clement Jr., Craig',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Midkiff, Alex',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Massuet, Alejandro',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Wheeler, Carl',15);
insert into rankings (season, rank, player, points) values ('2021',185,'St. Peter, Scott',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Witt, Dan',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Kissel, Mark',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Neri, Daniel',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Cramer, Dan',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Prince, Darrin',15);
insert into rankings (season, rank, player, points) values ('2021',185,'Sotomayor-Monchik, Veronica',15);
insert into rankings (season, rank, player, points) values ('2021',207,'Mettenbrink, Travis',12.01);
insert into rankings (season, rank, player, points) values ('2021',207,'Moncada, Manuel',12.01);
insert into rankings (season, rank, player, points) values ('2021',207,'Bear, Alejandro',12.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Martinez, Hanzel',10.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Mendoza, Dj',10.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Martinez, Edson',10.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Solter, Erik',10.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Cardenas, Abraham1',10.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Elkins, Cody',10.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Gatica, Rafael',10.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Crawford, James',10.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Baez, Ruben',10.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Ellis, Julius',10.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Salgado Jr., Rodrigo',10.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Wright, Jordan',10.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Jammal, Tony',10.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Chynoweth, Tracy',10.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Frattinger, Ian',10.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Carson, Tony',10.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Bautista, Daniel',10.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Rivero, Luis',10.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Pellowski, Zach',10.01);
insert into rankings (season, rank, player, points) values ('2021',210,'Cueva, Juan Francisco',10.01);
insert into rankings (season, rank, player, points) values ('2021',230,'Ramirez, Andres',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Anastasio, David',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Miller, Marquis',10);
insert into rankings (season, rank, player, points) values ('2021',230,'McLain, Kerry',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Young, Stacey (sly)',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Halsey, Rosco',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Kisling, Terry',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Blanchard, Nick',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Ratchford, Ryan',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Erickson, Ryan',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Stark, Jeff',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Sandoval, Francisco',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Rivera, Masiel',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Fernandez, A.j.',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Aholu, Wisdom',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Bremner, Parker',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Rivera, Noe',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Sandoval, Erick',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Cunningham, Jamie',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Hutkins, Jacob',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Price, Andrew',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Harris, Jamal',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Coyle, Eugene',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Martinez, Luis',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Urquidi Enriquez, Hector',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Guilfoy, Chris',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Flowers, Raymond',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Rodriguez, Maria Renee',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Lis, Jerry',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Armanuse, Anthony',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Sanchez, Christian',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Ott, Derek',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Márquez, Alan',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Boykin, Jonathan',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Renteria, Eder',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Renteria, Luis',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Martinez, Emir',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Scott, Russell',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Delgadillo, Mauricio',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Cohen, Doug',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Semones, Steve',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Cassens, Joel',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Slutzky, Erin',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Sanders, C J',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Pujari, Maneesh',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Gutierrez, Ariel',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Nomo, Alejandro',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Sandoval, Mark',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Laime, Brenda',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Hoffmann, Tyler',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Jones, Andrew',10);
insert into rankings (season, rank, player, points) values ('2021',230,'Miller, Edwin',10);
insert into rankings (season, rank, player, points) values ('2021',282,'Wylie, Jake',7.01);
insert into rankings (season, rank, player, points) values ('2021',283,'Purcell, Alexxander',5.01);
insert into rankings (season, rank, player, points) values ('2021',284,'Schaal, Michael',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Pearl, Josh',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Karmelin, Shane',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Moore, Troy',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Ingram, Blake',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Walters, Jordan',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Alvendia, Ted',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Mueller, Drew',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Chambers, Cliff',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Justice, Jonathan',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Provan, John',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Hojat, Sam',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Satawa, Bryan',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Wyatt, Adam',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Johnson, Jack',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Bergevin, Matt',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Bleyer, Ben',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Pleskac, Charlie',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Snarr, Mike',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Esker, Scott',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Niño, Rodrigo',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Rivera, Saul',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Keita, Yacouba',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Vanderbeek, Craig',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Longoria, Christian',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Schlichting, Ben',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Greenberg, Johnny',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Anum, Francis',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Peterson, Tyler',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Ruiz, Juan',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Herboso, Marcos',5);
insert into rankings (season, rank, player, points) values ('2021',284,'McClure, Dan',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Trejo, Andres',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Gastelum, Diego',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Hernández, Sebastian',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Baskaran, Arun',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Arango, Jesus',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Fletcher, Kenneth',5);
insert into rankings (season, rank, player, points) values ('2021',284,'McCoy, Mitchell',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Arredondo, Luis',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Kern, Travis',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Acuna, Brian',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Meeks, Rick',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Severns, Will',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Tata, Sudheer',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Sherman, William',5);
insert into rankings (season, rank, player, points) values ('2021',284,'De La Rosa, Sebastián',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Reiterhart, Christian',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Kenkel, Jared',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Zeleny, Chad',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Northcutt, Michael',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Castillo, Rogelio',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Vancura, Zach',5);
insert into rankings (season, rank, player, points) values ('2021',284,'Cáceres, José',5);
	




select count(*) from rankings where season='2021';

select * from rankings where season='2021' order by convert(rank,unsigned integer) asc;


select player,count(*) from rankings where season='2021' group by player having count(*) > 1;



-- use this time to clean up results that use the old season method

update results set season='2021' where season='2020-21';

update tourneys set season='2021' where season='2020-21';

update results_doubles set season='2021' where season='2020-21';

update tourneys_doubles set season='2021' where season='2020-21';


-- now run name cleanup.  and test online to see if any name fixes need to be done.  Run Season Summary report to see
-- which players have results but names mismatch the rankings

select * from rankings where season='2021' and player like '%Gue%';

select * from results where loser like 'Tapia%';


call sp_fixname ('Jaldin, Adrian','Jaldin Lobo, Adrian');

call sp_fixname('Flores Jr., Jose','Flores, Jr., Jose');

call sp_fixname ('Bowens, Kevin','Bowens Jr., Kevin');

call sp_fixname ('Tapia, Juan Jose','Tapia Zúñiga, Juan José');

call sp_fixname('Siles, Vladimir','Siles Gonzales, Vladimir Fernando');


select count(*) from rankings where season='2021';



/* What remains from Season Summary report?  
- Guevara, Gerardo: entered one tournament and no-showed, so in DB but not rankings: ok
- Arterburn, Sunshine: entered Denver, no-showed, so in DB but not in rankings.  ok.

- 2 entries for Guatemalan player Julian Cruz; he’s ranked #138 and #176 in year end standings.  If fixed, add 20 + 15.01 together.
- 2 entries for Juan Pablo Rodriguez seems to be in twice: #58 and #147  75.02 + 20 if fixed
- Elias Neito == “Oscar Elias Nieto Valadez” ?   #86 and #185.  If fixed, add togther 46.01 + 15.alter

*/


