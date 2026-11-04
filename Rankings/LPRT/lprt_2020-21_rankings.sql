-- 2020-21 season standings

select * from rankings order by season desc, rank asc;

create table rankings_20211224 as select * from rankings;

select * from rankings where season='2020-21' order by rank;

select * from rankings where season='2019-20' order by convert(rank,unsigned integer);

-- delete from rankings where season='2018-19';

-- 2020-21 pulled from season_ending_standings.xlsx since we didn't have a web scraper this year.

insert into rankings (season, rank, player, points, record) values ('2020-21','1','Longoria, Paola','1544','');
insert into rankings (season, rank, player, points, record) values ('2020-21','2','Herrera, Alexandra','588.5','');
insert into rankings (season, rank, player, points, record) values ('2020-21','3','Mejia, Monserrat','548.5','');
insert into rankings (season, rank, player, points, record) values ('2020-21','4','Vargas, Maria Jose','541.5','');
insert into rankings (season, rank, player, points, record) values ('2020-21','5','Salas, Samantha','454','');
insert into rankings (season, rank, player, points, record) values ('2020-21','6','Mendez, Natalia','427','');
insert into rankings (season, rank, player, points, record) values ('2020-21','7','Parrilla, Jessica','377.5','');
insert into rankings (season, rank, player, points, record) values ('2020-21','8','Barrios, Angelica','360.25','');
insert into rankings (season, rank, player, points, record) values ('2020-21','9','Centellas, Valeria','333','');
insert into rankings (season, rank, player, points, record) values ('2020-21','10','Rajsich, Rhonda','311','');
insert into rankings (season, rank, player, points, record) values ('2020-21','11','Martinez, Ana Gabriela','290','');
insert into rankings (season, rank, player, points, record) values ('2020-21','12','Enriquez, Nancy','244.5','');
insert into rankings (season, rank, player, points, record) values ('2020-21','13','Munoz, Carla','231','');
insert into rankings (season, rank, player, points, record) values ('2020-21','14','Amaya, Cristina','192','');
insert into rankings (season, rank, player, points, record) values ('2020-21','15','Lawrence, Kelani','178.5','');
insert into rankings (season, rank, player, points, record) values ('2020-21','16','Riveros, Adriana','172.5','');
insert into rankings (season, rank, player, points, record) values ('2020-21','17','Rodriguez, Maria Renee','152.5','');
insert into rankings (season, rank, player, points, record) values ('2020-21','18','Laime, Brenda','147.5','');
insert into rankings (season, rank, player, points, record) values ('2020-21','19','Lotts, Sheryl','140.5','');
insert into rankings (season, rank, player, points, record) values ('2020-21','20','Scott, Hollie','133.75','');
insert into rankings (season, rank, player, points, record) values ('2020-21','21','Rivera, Masiel','106.25','');
insert into rankings (season, rank, player, points, record) values ('2020-21','22','Flores, Ana Laura','85.5','');
insert into rankings (season, rank, player, points, record) values ('2020-21','23','Meneses, Micaela','84.25','');
insert into rankings (season, rank, player, points, record) values ('2020-21','24','Fisher Haynes, Adrienne','77.5','');
insert into rankings (season, rank, player, points, record) values ('2020-21','25','Rivera, Erin','71','');
insert into rankings (season, rank, player, points, record) values ('2020-21','26','Acosta-Mendoza, Susy','68.75','');
insert into rankings (season, rank, player, points, record) values ('2020-21','27','Rico, Daniela','59.75','');
insert into rankings (season, rank, player, points, record) values ('2020-21','28','Chen, Jessica','58.75','');
insert into rankings (season, rank, player, points, record) values ('2020-21','28','Slutzky, Erin','58.75','');
insert into rankings (season, rank, player, points, record) values ('2020-21','28','Gonzalez, Lucia','58.75','');
insert into rankings (season, rank, player, points, record) values ('2020-21','31','Riquelme, Maria Paz','52.5','');
insert into rankings (season, rank, player, points, record) values ('2020-21','32','Wargo, Graci','43.75','');
insert into rankings (season, rank, player, points, record) values ('2020-21','33','Roberts, Annie','40','');
insert into rankings (season, rank, player, points, record) values ('2020-21','37','Manilla, Erika','38.75','');
insert into rankings (season, rank, player, points, record) values ('2020-21','37','Perez, Montse','38.75','');
insert into rankings (season, rank, player, points, record) values ('2020-21','37','Diaz, Shane','38.75','');
insert into rankings (season, rank, player, points, record) values ('2020-21','37','Shelton, Megan','38.75','');
insert into rankings (season, rank, player, points, record) values ('2020-21','38','Lee, Cassandra','31.25','');
insert into rankings (season, rank, player, points, record) values ('2020-21','38','York, Lexi','31.25','');
insert into rankings (season, rank, player, points, record) values ('2020-21','40','Brandt, Laura','25','');
insert into rankings (season, rank, player, points, record) values ('2020-21','41','Tyler, Linda','23.44','');
insert into rankings (season, rank, player, points, record) values ('2020-21','42','Neils, Katharine','20','');
insert into rankings (season, rank, player, points, record) values ('2020-21','43','Whitmore, Robin','18.75','');
insert into rankings (season, rank, player, points, record) values ('2020-21','44','Ros, Naomi','8.94','');
insert into rankings (season, rank, player, points, record) values ('2020-21','45','Rivero, Camila','4.94','');
insert into rankings (season, rank, player, points, record) values ('2020-21','45','Mita, Natalia','4.94','');
insert into rankings (season, rank, player, points, record) values ('2020-21','47','De La Rosa, Michelle','4.69','');
insert into rankings (season, rank, player, points, record) values ('2020-21','48','Daza, Jenny','4.25','');
insert into rankings (season, rank, player, points, record) values ('2020-21','49','Ortiz, Maricruz','3.75','');




commit;


select count(*) from rankings where season='2020-21';

select * from rankings where season='2020-21' order by convert(rank,unsigned integer);

-- now run name cleanup and QA data




