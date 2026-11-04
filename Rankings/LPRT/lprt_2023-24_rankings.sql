-- 2023-24 season standings

select * from rankings order by season, `rank` desc;

create table rankings_20240612 as select * from rankings;

select * from rankings where season='2023-24' order by `rank`;

select * from rankings where season='2022-23' order by convert(`rank`,unsigned integer);

-- delete from rankings where season='2018-19';

insert into rankings (season, `rank`, player, points) values ('2023-24',1,'Vargas, Maria Jose',1502);
insert into rankings (season, `rank`, player, points) values ('2023-24',2,'Longoria, Paola',1409.5);
insert into rankings (season, `rank`, player, points) values ('2023-24',3,'Mejia, Montserrat',1093.5);
insert into rankings (season, `rank`, player, points) values ('2023-24',4,'Herrera, Alexandra',896);
insert into rankings (season, `rank`, player, points) values ('2023-24',5,'Laime, Brenda',467.5);
insert into rankings (season, `rank`, player, points) values ('2023-24',6,'Lawrence, Kelani',460);
insert into rankings (season, `rank`, player, points) values ('2023-24',7,'Mendez, Natalia',393.5);
insert into rankings (season, `rank`, player, points) values ('2023-24',8,'Amaya, Cristina',353.5);
insert into rankings (season, `rank`, player, points) values ('2023-24',9,'Munoz, Carla',342.5);
insert into rankings (season, `rank`, player, points) values ('2023-24',10,'Martinez, Gaby',333);
insert into rankings (season, `rank`, player, points) values ('2023-24',10,'Manilla, Erika',333);
insert into rankings (season, `rank`, player, points) values ('2023-24',12,'Salas, Samantha',322.5);
insert into rankings (season, `rank`, player, points) values ('2023-24',13,'Parrilla, Jessica',256);
insert into rankings (season, `rank`, player, points) values ('2023-24',14,'Scott, Hollie',214.25);
insert into rankings (season, `rank`, player, points) values ('2023-24',15,'York, Lexi',199.25);
insert into rankings (season, `rank`, player, points) values ('2023-24',16,'Paz, Maria',183.75);
insert into rankings (season, `rank`, player, points) values ('2023-24',17,'Synhorst, Stephanie',165.5);
insert into rankings (season, `rank`, player, points) values ('2023-24',18,'Ros, Naomi',162.25);
insert into rankings (season, `rank`, player, points) values ('2023-24',19,'Barrios, Angelica',151);
insert into rankings (season, `rank`, player, points) values ('2023-24',20,'Key, Michelle',112.5);
insert into rankings (season, `rank`, player, points) values ('2023-24',21,'Arterburn, Sunshine',105);
insert into rankings (season, `rank`, player, points) values ('2023-24',22,'Lotts, Sheryl',94.25);
insert into rankings (season, `rank`, player, points) values ('2023-24',23,'Leon, Chanis',78.75);
insert into rankings (season, `rank`, player, points) values ('2023-24',24,'Velpuri, Khyathi',67.5);
insert into rankings (season, `rank`, player, points) values ('2023-24',25,'Rodriguez, Maria Renee',63.75);
insert into rankings (season, `rank`, player, points) values ('2023-24',26,'Katz, Martina',56.25);
insert into rankings (season, `rank`, player, points) values ('2023-24',27,'Enriquez, Nancy',53);
insert into rankings (season, `rank`, player, points) values ('2023-24',28,'Lambert, Frederique',45.5);
insert into rankings (season, `rank`, player, points) values ('2023-24',29,'Mortensen, Kelly',33.75);
insert into rankings (season, `rank`, player, points) values ('2023-24',30,'Centellas, Valeria',30);
insert into rankings (season, `rank`, player, points) values ('2023-24',30,'Parent, Juliette',30);
insert into rankings (season, `rank`, player, points) values ('2023-24',32,'Perez-Picon, Estefania',18.75);
insert into rankings (season, `rank`, player, points) values ('2023-24',32,'Sarmiento, Ana',18.75);
insert into rankings (season, `rank`, player, points) values ('2023-24',32,'Munoz, Maria Jose',18.75);
insert into rankings (season, `rank`, player, points) values ('2023-24',32,'Sotomayor, Veronica',18.75);
insert into rankings (season, `rank`, player, points) values ('2023-24',32,'Martinez, Andrea',18.75);
insert into rankings (season, `rank`, player, points) values ('2023-24',32,'Ortiz, Maricruz',18.75);
insert into rankings (season, `rank`, player, points) values ('2023-24',32,'Diaz, Shane',18.75);
insert into rankings (season, `rank`, player, points) values ('2023-24',32,'Riveros, Adrianna',18.75);
insert into rankings (season, `rank`, player, points) values ('2023-24',32,'Rodriguez, Victoria',18.75);
insert into rankings (season, `rank`, player, points) values ('2023-24',41,'Acosta, Susy',15.5);
insert into rankings (season, `rank`, player, points) values ('2023-24',42,'Trujillo, Mariafernanda',15);
insert into rankings (season, `rank`, player, points) values ('2023-24',42,'Roberts, Annie',15);
insert into rankings (season, `rank`, player, points) values ('2023-24',42,'Gonzalez, Lucia',15);
insert into rankings (season, `rank`, player, points) values ('2023-24',42,'Salazar, Yanna',15);
insert into rankings (season, `rank`, player, points) values ('2023-24',42,'Sanchez, Fatima',15);
insert into rankings (season, `rank`, player, points) values ('2023-24',47,'Williams, Erica',4);


commit;


select count(*) from rankings where season='2023-24';

select * from rankings where season='2023-24' order by convert(`rank`,unsigned integer);

-- now run name cleanup 

-- now run season summary report QA data

update rankings set player='Riquelme, Maria Paz' where player='Paz, Maria';

update rankings set player='Riveros, Adriana' where player='Riveros, Adrianna';


-- 100% all good.