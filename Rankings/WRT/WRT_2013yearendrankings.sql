
/* 1/16/19: 2013 WRT year end rankings */


use cp30725_wrt;

SET SQL_SAFE_UPDATES = 0;


create table rankings_source_20190116 as select * from rankings_source;

create table rankings_20190116 as select * from rankings;

delete from rankings_source where season='2013';

insert into rankings_source (season,source) values ('2013','WRT Rankings 2016.xls from Pablo Fajre');



insert into rankings (season, rank, player, points) values ('2013','1','Gutierrez, Polo',7750);
insert into rankings (season, rank, player, points) values ('2013','2','Cardona, Alex',6825);
insert into rankings (season, rank, player, points) values ('2013','3','Herrera, Anthony',5625);
insert into rankings (season, rank, player, points) values ('2013','4','Landa, Alex',5500);
insert into rankings (season, rank, player, points) values ('2013','5','Mejia, Gil',4425);
insert into rankings (season, rank, player, points) values ('2013','6','Horn, Bobby',2625);
insert into rankings (season, rank, player, points) values ('2013','7','Sandoval, Erick',2425);
insert into rankings (season, rank, player, points) values ('2013','8','Martell, Jaime',2075);
insert into rankings (season, rank, player, points) values ('2013','9','Almada, Alejandro',1575);
insert into rankings (season, rank, player, points) values ('2013','10','Filippini, Rafael',1290);
insert into rankings (season, rank, player, points) values ('2013','11','Franco, Sebastian',1200);
insert into rankings (season, rank, player, points) values ('2013','12','Moreno, Javier',1200);
insert into rankings (season, rank, player, points) values ('2013','13','Camacho, Felipe',1175);
insert into rankings (season, rank, player, points) values ('2013','14','Canedo, Santiago',1000);
insert into rankings (season, rank, player, points) values ('2013','15','Troncoso, Francisco',960);
insert into rankings (season, rank, player, points) values ('2013','16','Hungerford, Josh',800);
insert into rankings (season, rank, player, points) values ('2013','17','Morales, Rafael',725);
insert into rankings (season, rank, player, points) values ('2013','18','Neri, Daniel',640);
insert into rankings (season, rank, player, points) values ('2013','19','Herrera, Juan',600);
insert into rankings (season, rank, player, points) values ('2013','20','Cocco, Alexi',560);
insert into rankings (season, rank, player, points) values ('2013','21','Majxner, Matthew',525);
insert into rankings (season, rank, player, points) values ('2013','21','Ortiz, Salvador',525);
insert into rankings (season, rank, player, points) values ('2013','23','Alvidrez, Jose',520);
insert into rankings (season, rank, player, points) values ('2013','23','Sandoval, Manolo',520);
insert into rankings (season, rank, player, points) values ('2013','25','Parrilla, Andree',445);
insert into rankings (season, rank, player, points) values ('2013','25','Rios, Fernando',445);
insert into rankings (season, rank, player, points) values ('2013','27','Miramontes, Nicolai',440);
insert into rankings (season, rank, player, points) values ('2013','27','Rodriguez, Miguel',440);
insert into rankings (season, rank, player, points) values ('2013','29','Guevara, Gerardo',400);
insert into rankings (season, rank, player, points) values ('2013','29','Embry, Aaron',400);
insert into rankings (season, rank, player, points) values ('2013','31','Cullen, Kurtis',325);
insert into rankings (season, rank, player, points) values ('2013','31','Martinez, Jose',325);
insert into rankings (season, rank, player, points) values ('2013','31','Jun Jeon, Seung',325);
insert into rankings (season, rank, player, points) values ('2013','31','Conway, Jason',325);
insert into rankings (season, rank, player, points) values ('2013','35','Alvarez, Jose Daniel',320);
insert into rankings (season, rank, player, points) values ('2013','35','Hernandez, Omar',320);
insert into rankings (season, rank, player, points) values ('2013','35','Sanchez, Jonathan',320);
insert into rankings (season, rank, player, points) values ('2013','38','Schonberger, Anthony',240);
insert into rankings (season, rank, player, points) values ('2013','38','Uribe, Humberto',240);
insert into rankings (season, rank, player, points) values ('2013','38','Fernandez, Luis',240);
insert into rankings (season, rank, player, points) values ('2013','41','Castro, Pedro',200);
insert into rankings (season, rank, player, points) values ('2013','41','Varela, Jacob',200);
insert into rankings (season, rank, player, points) values ('2013','41','Rojas, Daniel',200);
insert into rankings (season, rank, player, points) values ('2013','41','Gardea, Miguel',200);
insert into rankings (season, rank, player, points) values ('2013','41','Razo, Erick',200);
insert into rankings (season, rank, player, points) values ('2013','41','Casavolone, Bruno',200);
insert into rankings (season, rank, player, points) values ('2013','41','Acuna, Andres',200);
insert into rankings (season, rank, player, points) values ('2013','41','Iwaasa, Coby',200);
insert into rankings (season, rank, player, points) values ('2013','41','Lavely, Daniel',200);
insert into rankings (season, rank, player, points) values ('2013','41','Kurzbard, Pablo',200);
insert into rankings (season, rank, player, points) values ('2013','41','Kurzbard, Fernando',200);
insert into rankings (season, rank, player, points) values ('2013','41','Sada, Eddie',200);
insert into rankings (season, rank, player, points) values ('2013','41','Rodriguez, Daniel',200);
insert into rankings (season, rank, player, points) values ('2013','41','Munoz, Luis Felipe',200);
insert into rankings (season, rank, player, points) values ('2013','41','Balderrama, Emmanuel',200);
insert into rankings (season, rank, player, points) values ('2013','41','Swain, Cliff',200);
insert into rankings (season, rank, player, points) values ('2013','41','Coe, Emmett',200);
insert into rankings (season, rank, player, points) values ('2013','41','Ramirez, Freddy',200);
insert into rankings (season, rank, player, points) values ('2013','41','Martinez, Julio',200);
insert into rankings (season, rank, player, points) values ('2013','41','Perez, Mike',200);
insert into rankings (season, rank, player, points) values ('2013','41','Mercado, Felipe',200);
insert into rankings (season, rank, player, points) values ('2013','41','Guriel, Michael',200);
insert into rankings (season, rank, player, points) values ('2013','41','Doniak, Josh',200);
insert into rankings (season, rank, player, points) values ('2013','41','Wagner, Rick',200);
insert into rankings (season, rank, player, points) values ('2013','41','Medina, Luis',200);
insert into rankings (season, rank, player, points) values ('2013','41','Esparza, Enrique',200);
insert into rankings (season, rank, player, points) values ('2013','67','Aldana, Ismael',120);
insert into rankings (season, rank, player, points) values ('2013','67','Ivers, Justin',120);
insert into rankings (season, rank, player, points) values ('2013','67','Carrasco, Kadim',120);
insert into rankings (season, rank, player, points) values ('2013','67','Natera, Alan',120);
insert into rankings (season, rank, player, points) values ('2013','67','Marquez, Alan',120);
insert into rankings (season, rank, player, points) values ('2013','67','Leyva, Gil',120);
insert into rankings (season, rank, player, points) values ('2013','67','Longoria, Cristian',120);
insert into rankings (season, rank, player, points) values ('2013','67','Kwon, Daeyong',120);
insert into rankings (season, rank, player, points) values ('2013','67','Salgado, Rodrigo',120);
insert into rankings (season, rank, player, points) values ('2013','67','Collins, Robert',120);
insert into rankings (season, rank, player, points) values ('2013','67','Castillo, Cesar',120);
insert into rankings (season, rank, player, points) values ('2013','67','Guevara, Alejandro',120);
insert into rankings (season, rank, player, points) values ('2013','67','Parrilla, Fabian',120);
insert into rankings (season, rank, player, points) values ('2013','67','Burruel, Arturo',120);
insert into rankings (season, rank, player, points) values ('2013','67','Suarez, Mauricio',120);
insert into rankings (season, rank, player, points) values ('2013','67','Medina, Rogelio',120);
insert into rankings (season, rank, player, points) values ('2013','67','Silva, Diego',120);
insert into rankings (season, rank, player, points) values ('2013','67','McGlothing, Jeremy',120);
insert into rankings (season, rank, player, points) values ('2013','67','Vasquez, Armando',120);
insert into rankings (season, rank, player, points) values ('2013','67','Rodriguez, Erick',120);
insert into rankings (season, rank, player, points) values ('2013','67','Pesqueira, Luis',120);
insert into rankings (season, rank, player, points) values ('2013','67','Kiil, Paul',120);
insert into rankings (season, rank, player, points) values ('2013','67','Vequezo, Jimmy',120);
insert into rankings (season, rank, player, points) values ('2013','67','Leyva, Guillermo',120);
insert into rankings (season, rank, player, points) values ('2013','67','Serrano, Jose',120);
insert into rankings (season, rank, player, points) values ('2013','67','Turner, Steven',120);
insert into rankings (season, rank, player, points) values ('2013','67','Bowers, Bradley',120);
insert into rankings (season, rank, player, points) values ('2013','67','Machaen, Xavier',120);
insert into rankings (season, rank, player, points) values ('2013','67','Ortiz, David',120);
insert into rankings (season, rank, player, points) values ('2013','67','Flores, Alberto',120);
insert into rankings (season, rank, player, points) values ('2013','67','Maldonado, Elizer',120);
insert into rankings (season, rank, player, points) values ('2013','67','Perea, Miguel',120);
insert into rankings (season, rank, player, points) values ('2013','67','Ortega, Ricardo',120);
insert into rankings (season, rank, player, points) values ('2013','67','Leal, David',120);
insert into rankings (season, rank, player, points) values ('2013','67','Gatica, Patricio',120);
insert into rankings (season, rank, player, points) values ('2013','67','Garate, Antonio',120);
insert into rankings (season, rank, player, points) values ('2013','67','Borquez, Mauricio',120);
insert into rankings (season, rank, player, points) values ('2013','67','Accorsi, Cristobal',120);
insert into rankings (season, rank, player, points) values ('2013','67','Paez, Exequiel',120);
insert into rankings (season, rank, player, points) values ('2013','67','Sanabria, Victor',120);
insert into rankings (season, rank, player, points) values ('2013','67','Cannady, Cameron',120);
insert into rankings (season, rank, player, points) values ('2013','67','Fernandez, Rafael',120);
insert into rankings (season, rank, player, points) values ('2013','67','Imhausen, Jared',120);
insert into rankings (season, rank, player, points) values ('2013','67','Randles, Darin',120);
insert into rankings (season, rank, player, points) values ('2013','67','Bermudez, Armando',120);
insert into rankings (season, rank, player, points) values ('2013','67','Beistle, Greg',120);
insert into rankings (season, rank, player, points) values ('2013','67','Garcia, German',120);
insert into rankings (season, rank, player, points) values ('2013','67','Bugarin, Luis',120);
insert into rankings (season, rank, player, points) values ('2013','67','Romero, Rafael',120);
insert into rankings (season, rank, player, points) values ('2013','67','Crespo, Diego',120);
insert into rankings (season, rank, player, points) values ('2013','117','Koliczew, Victor',80);
insert into rankings (season, rank, player, points) values ('2013','117','Imhausen, Richard',80);
insert into rankings (season, rank, player, points) values ('2013','117','Diaz, Juan',80);
insert into rankings (season, rank, player, points) values ('2013','117','Patterson, Zachary',80);



commit;

-- now run names cleanup

select count(*) from rankings where season='2012';