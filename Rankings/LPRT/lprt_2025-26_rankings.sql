-- 2025-26 season standings work 6/24/26

/* note: we are not maintaining the "frozen" rankings for Longoria at #2, or Salas at #9, instead these rankings
go by performance in teh season */

select * from rankings order by season, `rank` desc;

create table rankings_20260624 as select * from rankings;

select * from rankings where season='2025-26' order by `rank`;

select * from rankings where season='2023-24' order by convert(`rank`,unsigned integer);

-- delete from rankings where season='2018-19';

insert into rankings (season, `rank`, player, points) values ('2025-26',1,'Vargas, Maria Jose',1703.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',2,'Mejia, Montse',866.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',3,'Longoria, Paola',806.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',4,'Centellas, Valeria',539.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',5,'Mendez, Natalia',530.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',6,'Martinez, Gaby',493);
insert into rankings (season, `rank`, player, points) values ('2025-26',7,'Laime, Brenda',341);
insert into rankings (season, `rank`, player, points) values ('2025-26',8,'Herrera, Alexandra',340);
insert into rankings (season, `rank`, player, points) values ('2025-26',9,'Munoz, Carla',338.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',10,'Amaya, Cristina',263.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',11,'Lotts, Sheryl',226);
insert into rankings (season, `rank`, player, points) values ('2025-26',12,'Sanchez-Roberts, Annie',206.25);
insert into rankings (season, `rank`, player, points) values ('2025-26',13,'Josey  (Rodriguez), Maria Renee',170.75);
insert into rankings (season, `rank`, player, points) values ('2025-26',14,'Rajsich, Rhonda',168.75);
insert into rankings (season, `rank`, player, points) values ('2025-26',15,'York, Lexi',151);
insert into rankings (season, `rank`, player, points) values ('2025-26',16,'Synhorst, Stephanie',150.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',17,'Manilla, Erika',112.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',17,'Parrilla, Jessica',112.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',19,'Faeth, Larissa',93.75);
insert into rankings (season, `rank`, player, points) values ('2025-26',20,'Salas, Samantha',75);
insert into rankings (season, `rank`, player, points) values ('2025-26',20,'Reyes, Andrea Gabriela',75);
insert into rankings (season, `rank`, player, points) values ('2025-26',20,'Acosta, Susy',75);
insert into rankings (season, `rank`, player, points) values ('2025-26',23,'Williams, Erica',56.25);
insert into rankings (season, `rank`, player, points) values ('2025-26',23,'Parent, Juliette',56.25);
insert into rankings (season, `rank`, player, points) values ('2025-26',23,'Brandt, Laura',56.25);
insert into rankings (season, `rank`, player, points) values ('2025-26',26,'Ros, Naomi',38.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',27,'Enriquez, Nancy',38);
insert into rankings (season, `rank`, player, points) values ('2025-26',28,'Yaanez, Alondra',37.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',28,'Aldana, Paula',37.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',28,'Perez-Picon, Andrea',37.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',28,'Wer, Isabella',37.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',28,'Millet, Bri',37.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',28,'Rivero, Camila',37.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',28,'Boaz, Ella',37.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',28,'Davis, Kyla',37.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',28,'Gonzalez, Lucia',37.5);
insert into rankings (season, `rank`, player, points) values ('2025-26',37,'Leon, Chanis',18.75);
insert into rankings (season, `rank`, player, points) values ('2025-26',37,'Gutierrez, Cynthia',18.75);
insert into rankings (season, `rank`, player, points) values ('2025-26',37,'Perez-Picon, Estefania',18.75);
insert into rankings (season, `rank`, player, points) values ('2025-26',37,'Balderrama, Ivanna',18.75);
insert into rankings (season, `rank`, player, points) values ('2025-26',37,'Trujillo, Mariafernanda',18.75);
insert into rankings (season, `rank`, player, points) values ('2025-26',37,'Key, Michelle',18.75);




commit;


select count(*) from rankings where season='2025-26';

select * from rankings where season='2025-26' order by convert(`rank`,unsigned integer);

-- now run name cleanup 

-- now run season summary report QA data: any player in the Season Summary report missing a seed has a name issue
-- or entered but did not show up for an event.

call sp_fixname ('Josey (Rodriguez), Maria Renee','Rodriguez, Maria Renee');

call sp_fixname ('Josey (Rodriguez), Maria Renee','Josey  (Rodriguez), Maria Renee');

call sp_fixname('Yanez, Alondra','Allondra, Yanez');
call sp_fixname('Yanez, Alondra','Alondra, Yanez');
call sp_fixname('Yanez, Alondra','Yanez, Allondra');

select * from rankings where player like '%Yanez%';


-- 100% all good.