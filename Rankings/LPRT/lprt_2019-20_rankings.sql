-- 2019-20 season standings

select * from rankings order by season desc, rank asc;

create table rankings_20200608 as select * from rankings;

alter table rankings 

select * from rankings where season='2019-20' order by rank;

select * from rankings where season='2018-19' order by convert(rank,unsigned integer);

delete from rankings where season='2018-19';

insert into rankings (season, rank, player, points) values ('2019-20','1','Longoria, Paola',2625);
insert into rankings (season, rank, player, points) values ('2019-20','2','Vargas, Maria Jose',1527);
insert into rankings (season, rank, player, points) values ('2019-20','3','Salas, Samantha',1079.5);
insert into rankings (season, rank, player, points) values ('2019-20','4','Herrera, Alexandra',746.5);
insert into rankings (season, rank, player, points) values ('2019-20','5','Mendez, Natalia',671);
insert into rankings (season, rank, player, points) values ('2019-20','6','Rajsich, Rhonda',668);
insert into rankings (season, rank, player, points) values ('2019-20','7','Mejia, Montse',573.5);
insert into rankings (season, rank, player, points) values ('2019-20','8','Enriquez, Nancy',535.5);
insert into rankings (season, rank, player, points) values ('2019-20','9','Amaya, Cristina',501.25);
insert into rankings (season, rank, player, points) values ('2019-20','10','Rivera, Masiel',358.75);
insert into rankings (season, rank, player, points) values ('2019-20','11','Parilla, Jessica',354.75);
insert into rankings (season, rank, player, points) values ('2019-20','12','Munoz, Carla',277);
insert into rankings (season, rank, player, points) values ('2019-20','13','Laime, Brenda',260.75);
insert into rankings (season, rank, player, points) values ('2019-20','14','Flores, Ana Laura',252);
insert into rankings (season, rank, player, points) values ('2019-20','15','Riveros, Adriana',244.5);
insert into rankings (season, rank, player, points) values ('2019-20','16','Lotts, Sheryl',224.25);
insert into rankings (season, rank, player, points) values ('2019-20','17','Rivera, Erin',217.5);
insert into rankings (season, rank, player, points) values ('2019-20','18','Rodriguez, Maria Renee',203.5);
insert into rankings (season, rank, player, points) values ('2019-20','19','Lee, Casandra',192.5);
insert into rankings (season, rank, player, points) values ('2019-20','20','Centellas, Valeria',192);
insert into rankings (season, rank, player, points) values ('2019-20','21','Fisher, Adrienne',188.25);
insert into rankings (season, rank, player, points) values ('2019-20','22','Bailey, Kelani',187.75);
insert into rankings (season, rank, player, points) values ('2019-20','23','Acosta-Mendoza, Susy',172);
insert into rankings (season, rank, player, points) values ('2019-20','24','Lambert, Frederique',87.5);
insert into rankings (season, rank, player, points) values ('2019-20','25','Scott, Hollie',85.25);
insert into rankings (season, rank, player, points) values ('2019-20','26','York, Lexi',77.5);
insert into rankings (season, rank, player, points) values ('2019-20','27','Martinez, Gabriella',75);
insert into rankings (season, rank, player, points) values ('2019-20','28','Rico, Daniela',48.5);
insert into rankings (season, rank, player, points) values ('2019-20','29','Brandt, Laura',42.25);
insert into rankings (season, rank, player, points) values ('2019-20','30','Maldonado, Denisse',40);
insert into rankings (season, rank, player, points) values ('2019-20','31','Perez, Montse',39.75);
insert into rankings (season, rank, player, points) values ('2019-20','31','De la Rosa, Michelle',39.75);
insert into rankings (season, rank, player, points) values ('2019-20','33','Wargo, Graci',37.5);
insert into rankings (season, rank, player, points) values ('2019-20','33','Barrios, Angelica',37.5);
insert into rankings (season, rank, player, points) values ('2019-20','35','Gudinas, Cheryl',33.75);
insert into rankings (season, rank, player, points) values ('2019-20','36','Rivera, Carolina',32.5);
insert into rankings (season, rank, player, points) values ('2019-20','37','Shelton, Megan',31.25);
insert into rankings (season, rank, player, points) values ('2019-20','38','Ortiz, Maricruz',29.25);
insert into rankings (season, rank, player, points) values ('2019-20','39','Meneses, Micaela',25);
insert into rankings (season, rank, player, points) values ('2019-20','39','Sabja, Yazmine',25);
insert into rankings (season, rank, player, points) values ('2019-20','41','Gomar, Marie',22);
insert into rankings (season, rank, player, points) values ('2019-20','42','Sato, Maiko',18.75);
insert into rankings (season, rank, player, points) values ('2019-20','42','Tyler, Linda',18.75);
insert into rankings (season, rank, player, points) values ('2019-20','42','Daza, Jenny',18.75);
insert into rankings (season, rank, player, points) values ('2019-20','42','Whitmire, Robin',18.75);
insert into rankings (season, rank, player, points) values ('2019-20','46','Sauma, Melania',15);
insert into rankings (season, rank, player, points) values ('2019-20','46','Neils., Katherine',15);
insert into rankings (season, rank, player, points) values ('2019-20','48','Morisette, Michelle',13.5);
insert into rankings (season, rank, player, points) values ('2019-20','48','Shnurman, Hannah',13.5);
insert into rankings (season, rank, player, points) values ('2019-20','50','Riquelme, Maria Paz',12.5);
insert into rankings (season, rank, player, points) values ('2019-20','50','Pratt, Ceci',12.5);
insert into rankings (season, rank, player, points) values ('2019-20','50','Bailey, Malia',12.5);
insert into rankings (season, rank, player, points) values ('2019-20','50','Brewer, Aime',12.5);
insert into rankings (season, rank, player, points) values ('2019-20','54','Kozakai, Megumi',3.75);
insert into rankings (season, rank, player, points) values ('2019-20','54','Molina, Daniela',3.75);
insert into rankings (season, rank, player, points) values ('2019-20','54','Dering, Jennifer',3.75);
insert into rankings (season, rank, player, points) values ('2019-20','54','Hanashi, Ayoko',3.75);
insert into rankings (season, rank, player, points) values ('2019-20','54','Roberts, Annie',3.75);




commit;


select count(*) from rankings where season='2019-20';

select * from rankings where season='2019-20' order by convert(rank,unsigned integer);

-- now run name cleanup and QA data




