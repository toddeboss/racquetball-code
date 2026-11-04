-- 2022-23 season standings

select * from rankings order by season desc, rank asc;

create table rankings_20230622 as select * from rankings;

select * from rankings where season='2022-23' order by rank;

select * from rankings where season='2021-22' order by convert(rank,unsigned integer);

-- delete from rankings where season='2018-19';

-- 2020-21 pulled from season_ending_standings.xlsx since we didn't have a web scraper this year.

insert into rankings (season, rank, player, points) values ('2022-23','1','Mejia, Montserrat',1637.5);
insert into rankings (season, rank, player, points) values ('2022-23','2','Longoria, Paola',1424);
insert into rankings (season, rank, player, points) values ('2022-23','3','Herrera, Alexandra',902.5);
insert into rankings (season, rank, player, points) values ('2022-23','4','Manilla, Erika',838.5);
insert into rankings (season, rank, player, points) values ('2022-23','5','Laime, Brenda',808);
insert into rankings (season, rank, player, points) values ('2022-23','6','Barrios, Angelica',663.5);
insert into rankings (season, rank, player, points) values ('2022-23','7','Vargas, Maria Jose',634.5);
insert into rankings (season, rank, player, points) values ('2022-23','8','Parrilla, Jessica',589.5);
insert into rankings (season, rank, player, points) values ('2022-23','9','Munoz, Carla',571.5);
insert into rankings (season, rank, player, points) values ('2022-23','10','Mendez, Natalia',563.5);
insert into rankings (season, rank, player, points) values ('2022-23','11','Salas, Samantha',472);
insert into rankings (season, rank, player, points) values ('2022-23','12','Martinez, Ana Gabriela',468.5);
insert into rankings (season, rank, player, points) values ('2022-23','13','Centellas, Valeria',465.5);
insert into rankings (season, rank, player, points) values ('2022-23','14','Lawrence, Kelani',458.5);
insert into rankings (season, rank, player, points) values ('2022-23','15','Amaya, Cristina',333.5);
insert into rankings (season, rank, player, points) values ('2022-23','16','Scott, Hollie',289);
insert into rankings (season, rank, player, points) values ('2022-23','17','Riquelme, Maria Paz',203.75);
insert into rankings (season, rank, player, points) values ('2022-23','18','Lotts, Sheryl',198.5);
insert into rankings (season, rank, player, points) values ('2022-23','19','Rodriguez, Maria Renee',198.25);
insert into rankings (season, rank, player, points) values ('2022-23','20','Enriquez, Nancy',186);
insert into rankings (season, rank, player, points) values ('2022-23','21','Arterburn, Sunshine',142.5);
insert into rankings (season, rank, player, points) values ('2022-23','22','Synhorst, Stephanie',108.75);
insert into rankings (season, rank, player, points) values ('2022-23','23','York, Lexi',99.25);
insert into rankings (season, rank, player, points) values ('2022-23','24','Tyler, Linda',80);
insert into rankings (season, rank, player, points) values ('2022-23','25','Acosta, Susy',71.75);
insert into rankings (season, rank, player, points) values ('2022-23','26','Roberts, Annie',65);
insert into rankings (season, rank, player, points) values ('2022-23','27','Katz, Martina',63.75);
insert into rankings (season, rank, player, points) values ('2022-23','28','Ortiz, Maricruz',53.75);
insert into rankings (season, rank, player, points) values ('2022-23','29','Mansilla, Paula',53);
insert into rankings (season, rank, player, points) values ('2022-23','30','Daza, Jenny',40);
insert into rankings (season, rank, player, points) values ('2022-23','31','Aguilar, Jazmin',37.5);
insert into rankings (season, rank, player, points) values ('2022-23','32','Rivero, Camila',35);
insert into rankings (season, rank, player, points) values ('2022-23','33','Ros, Naomi',34.25);
insert into rankings (season, rank, player, points) values ('2022-23','33','Salazar, Yanna',34.25);
insert into rankings (season, rank, player, points) values ('2022-23','35','Diaz, Shane',33.75);
insert into rankings (season, rank, player, points) values ('2022-23','36','Brandt, Laura',30);
insert into rankings (season, rank, player, points) values ('2022-23','36','Velpuri, Khyathi',30);
insert into rankings (season, rank, player, points) values ('2022-23','36','Osorio, Leonela',30);
insert into rankings (season, rank, player, points) values ('2022-23','39','Meneses, Micaela',20.5);
insert into rankings (season, rank, player, points) values ('2022-23','40','Perez-Picon, Andrea',20);
insert into rankings (season, rank, player, points) values ('2022-23','40','Haynes, Adrienne',20);
insert into rankings (season, rank, player, points) values ('2022-23','40','Morisette, Michele',20);
insert into rankings (season, rank, player, points) values ('2022-23','40','Perez-Picon, Estefania',20);
insert into rankings (season, rank, player, points) values ('2022-23','40','Ortega, Angela',20);
insert into rankings (season, rank, player, points) values ('2022-23','45','Aguilar, Anna',18.75);
insert into rankings (season, rank, player, points) values ('2022-23','45','Aguilar, Paula',18.75);
insert into rankings (season, rank, player, points) values ('2022-23','47','Rajsich, Rhonda',15.5);
insert into rankings (season, rank, player, points) values ('2022-23','48','Janz, Carlee',15);
insert into rankings (season, rank, player, points) values ('2022-23','48','Maldonado, Denisse',15);
insert into rankings (season, rank, player, points) values ('2022-23','48','Gonzalez, Lucia',15);
insert into rankings (season, rank, player, points) values ('2022-23','48','Parent, Marjolaine',15);
insert into rankings (season, rank, player, points) values ('2022-23','48','Parent, Juliette',15);
insert into rankings (season, rank, player, points) values ('2022-23','48','Gonzalez, Ximena',15);
insert into rankings (season, rank, player, points) values ('2022-23','54','Portillo, Danna',3);



commit;


select count(*) from rankings where season='2022-23';

select * from rankings where season='2022-23' order by convert(rank,unsigned integer);

-- now run name cleanup and QA data

update rankings set player='Mejia, Monserrat' where season='2022-23' and rank=1;
update rankings set player='Lawrence (Bailey), Kelani' where season='2022-23' and rank=14;
update rankings set player='Acosta, Susana' where player='Acosta, Susy';
update rankings set player='Aguilar, Jazmin Elizabeth' where player='Aguilar, Jazmin';
update rankings set player='Aguilar, Anna Paul' where player='Aguilar, Anna';
update rankings set player='Jansz, Carlee' where player='Janz, Carlee';
update rankings set player='Ortega, Angela Veronica' where player='Ortega, Angela';
update rankings set player='Haynes (Fisher), Adrienne' where player='Haynes, Adrienne';
