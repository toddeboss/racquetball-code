-- 2021--22 season standings

select * from rankings order by season desc, rank asc;

create table rankings_20220614 as select * from rankings;

select * from rankings where season='2021-22' order by rank;

select * from rankings where season='2021-22' order by convert(rank,unsigned integer);

-- delete from rankings where season='2018-19';

-- 2020-21 pulled from season_ending_standings.xlsx since we didn't have a web scraper this year.

insert into rankings (season, rank, player, points) values ('2021-22','1','Longoria, Paola',1976);
insert into rankings (season, rank, player, points) values ('2021-22','2','Herrera, Alexandra',1321.5);
insert into rankings (season, rank, player, points) values ('2021-22','3','Vargas, Maria Jose',1019.5);
insert into rankings (season, rank, player, points) values ('2021-22','4','Mendez, Natalia',602);
insert into rankings (season, rank, player, points) values ('2021-22','5','Martinez, Gaby',579);
insert into rankings (season, rank, player, points) values ('2021-22','6','Manilla, Erika',522.25);
insert into rankings (season, rank, player, points) values ('2021-22','7','Barrios, Angelica',465);
insert into rankings (season, rank, player, points) values ('2021-22','8','Parrilla, Jessica',449.5);
insert into rankings (season, rank, player, points) values ('2021-22','9','Rajsich, Rhonda',444);
insert into rankings (season, rank, player, points) values ('2021-22','10','Mejia, Montse',436.25);
insert into rankings (season, rank, player, points) values ('2021-22','11','Munoz, Carla',406.75);
insert into rankings (season, rank, player, points) values ('2021-22','12','Lawrence, Kelani',401);
insert into rankings (season, rank, player, points) values ('2021-22','13','Laime, Brenda',371);
insert into rankings (season, rank, player, points) values ('2021-22','14','Salas, Samantha',367.5);
insert into rankings (season, rank, player, points) values ('2021-22','15','Centellas, Valeria',294.5);
insert into rankings (season, rank, player, points) values ('2021-22','16','Scott, Hollie',286);
insert into rankings (season, rank, player, points) values ('2021-22','17','Rodriguez, Maria Renee',223.75);
insert into rankings (season, rank, player, points) values ('2021-22','18','Lotts, Sheryl',210.25);
insert into rankings (season, rank, player, points) values ('2021-22','19','Enriquez, Nancy',192.25);
insert into rankings (season, rank, player, points) values ('2021-22','20','Amaya, Cristina',171.25);
insert into rankings (season, rank, player, points) values ('2021-22','21','Meneses, Micaela',163.25);
insert into rankings (season, rank, player, points) values ('2021-22','22','Perez, Montse',97.5);
insert into rankings (season, rank, player, points) values ('2021-22','23','Daza, Jenny',93.75);
insert into rankings (season, rank, player, points) values ('2021-22','24','Sotomayor, Veronica',79.75);
insert into rankings (season, rank, player, points) values ('2021-22','25','Rivero, Camila',72.5);
insert into rankings (season, rank, player, points) values ('2021-22','26','Chen, Jessica',71.25);
insert into rankings (season, rank, player, points) values ('2021-22','27','Roberts, Annie',68.75);
insert into rankings (season, rank, player, points) values ('2021-22','27','Acosta, Susy',68.75);
insert into rankings (season, rank, player, points) values ('2021-22','29','Ros, Naomi',67.5);
insert into rankings (season, rank, player, points) values ('2021-22','30','Riveros, Adriana',59);
insert into rankings (season, rank, player, points) values ('2021-22','31','Slutzky, Erin',53);
insert into rankings (season, rank, player, points) values ('2021-22','32','Haynes, Adrienne',50);
insert into rankings (season, rank, player, points) values ('2021-22','33','Flores, Ana Laura',48.75);
insert into rankings (season, rank, player, points) values ('2021-22','33','Rivera, Masiel',48.75);
insert into rankings (season, rank, player, points) values ('2021-22','33','Diaz, Shane',48.75);
insert into rankings (season, rank, player, points) values ('2021-22','36','Rico, Daniela',45);
insert into rankings (season, rank, player, points) values ('2021-22','37','Hickey, Aisling',38);
insert into rankings (season, rank, player, points) values ('2021-22','38','Riquelme, Maria Paz',37.5);
insert into rankings (season, rank, player, points) values ('2021-22','39','Synhorst, Stephanie',36.88);
insert into rankings (season, rank, player, points) values ('2021-22','40','Perez-Picon, Andrea',30);
insert into rankings (season, rank, player, points) values ('2021-22','41','Tyler, Linda',3.75);
insert into rankings (season, rank, player, points) values ('2021-22','42','Wargo, Graci',22.5);
insert into rankings (season, rank, player, points) values ('2021-22','43','Martina, Katz',20);
insert into rankings (season, rank, player, points) values ('2021-22','43','Arterburn, Sunshine',20);
insert into rankings (season, rank, player, points) values ('2021-22','45','Lee, Cassi',18.75);
insert into rankings (season, rank, player, points) values ('2021-22','45','Gonzalez, Lucia',18.75);
insert into rankings (season, rank, player, points) values ('2021-22','45','Munoz, Maria',18.75);
insert into rankings (season, rank, player, points) values ('2021-22','45','Kirchoff, Mary',18.75);
insert into rankings (season, rank, player, points) values ('2021-22','45','Gonzalez, Ximena',18.75);
insert into rankings (season, rank, player, points) values ('2021-22','50','Janz, Carlee',15);
insert into rankings (season, rank, player, points) values ('2021-22','50','Perez-Picon, Estefania',15);
insert into rankings (season, rank, player, points) values ('2021-22','50','York, Lexi',15);
insert into rankings (season, rank, player, points) values ('2021-22','50','Ortiz, Maricruz',15);
insert into rankings (season, rank, player, points) values ('2021-22','54','Rivera, Erin',3.75);
insert into rankings (season, rank, player, points) values ('2021-22','54','Mortensen, Kelly',3.75);
insert into rankings (season, rank, player, points) values ('2021-22','54','Brandt, Laura',3.75);
insert into rankings (season, rank, player, points) values ('2021-22','54','Munoz, Maria Jose',3.75);
insert into rankings (season, rank, player, points) values ('2021-22','54','De La Rosa, Michelle',3.75);
insert into rankings (season, rank, player, points) values ('2021-22','54','Mita, Natalia',3.75);
insert into rankings (season, rank, player, points) values ('2021-22','60','Munoz, Maria Paz',2.38);
insert into rankings (season, rank, player, points) values ('2021-22','61','Kaiser, Ava',1.88);
insert into rankings (season, rank, player, points) values ('2021-22','61','Lee, Sumin',1.88);




commit;


select count(*) from rankings where season='2021-22';

select * from rankings where season='2021-22' order by convert(rank,unsigned integer);

-- now run name cleanup and QA data


