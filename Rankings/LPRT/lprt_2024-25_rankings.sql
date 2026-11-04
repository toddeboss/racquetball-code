-- 2024-25 season standings

select * from rankings order by season, `rank` desc;

create table rankings_20250718 as select * from rankings;

select * from rankings where season='2024-25' order by `rank`;

select * from rankings where season='2023-24' order by convert(`rank`,unsigned integer);

-- delete from rankings where season='2018-19';




insert into rankings (season, `rank`, player, points) values ('2024-25',1,'Longoria, Paola',1521.5);
insert into rankings (season, `rank`, player, points) values ('2024-25',2,'Vargas, Maria Jose',1218);
insert into rankings (season, `rank`, player, points) values ('2024-25',2,'Mejia, Montse',1218);
insert into rankings (season, `rank`, player, points) values ('2024-25',4,'Martinez, Gaby',919);
insert into rankings (season, `rank`, player, points) values ('2024-25',5,'Mendez, Natalia',528);
insert into rankings (season, `rank`, player, points) values ('2024-25',6,'Laime, Brenda',492.5);
insert into rankings (season, `rank`, player, points) values ('2024-25',7,'Lawrence, Kelani',487.5);
insert into rankings (season, `rank`, player, points) values ('2024-25',8,'Herrera, Alexandra',451.5);
insert into rankings (season, `rank`, player, points) values ('2024-25',9,'Parrilla, Jessica',320.25);
insert into rankings (season, `rank`, player, points) values ('2024-25',10,'Amaya, Cristina',305.5);
insert into rankings (season, `rank`, player, points) values ('2024-25',11,'Salas, Samantha',302.5);
insert into rankings (season, `rank`, player, points) values ('2024-25',12,'Centellas, Valeria',227);
insert into rankings (season, `rank`, player, points) values ('2024-25',13,'York, Lexi',226);
insert into rankings (season, `rank`, player, points) values ('2024-25',14,'Lotts, Sheryl',207.25);
insert into rankings (season, `rank`, player, points) values ('2024-25',15,'Synhorst, Stephanie',187.5);
insert into rankings (season, `rank`, player, points) values ('2024-25',16,'Munoz, Carla',169.25);
insert into rankings (season, `rank`, player, points) values ('2024-25',17,'Rodriguez Josey, Maria Renee',168.75);
insert into rankings (season, `rank`, player, points) values ('2024-25',18,'Riquelme, Maria Paz',150);
insert into rankings (season, `rank`, player, points) values ('2024-25',18,'Sanchez-Roberts, Annie',150);
insert into rankings (season, `rank`, player, points) values ('2024-25',20,'Key, Michelle',114.5);
insert into rankings (season, `rank`, player, points) values ('2024-25',21,'Barrios, Angelica',112.5);
insert into rankings (season, `rank`, player, points) values ('2024-25',22,'Ros, Naomi',94.25);
insert into rankings (season, `rank`, player, points) values ('2024-25',23,'Velpuri, Khyathi',93.75);
insert into rankings (season, `rank`, player, points) values ('2024-25',24,'Rivero, Camila',75);
insert into rankings (season, `rank`, player, points) values ('2024-25',25,'Scott, Hollie',56.25);
insert into rankings (season, `rank`, player, points) values ('2024-25',25,'Leon, Chanis',56.25);
insert into rankings (season, `rank`, player, points) values ('2024-25',27,'Parent, Juliette',38);
insert into rankings (season, `rank`, player, points) values ('2024-25',28,'Acosta, Susy',37.5);
insert into rankings (season, `rank`, player, points) values ('2024-25',28,'Brandt, Laura',37.5);
insert into rankings (season, `rank`, player, points) values ('2024-25',28,'Enriquez, Nancy',37.5);
insert into rankings (season, `rank`, player, points) values ('2024-25',28,'Lambert, Frederique',37.5);
insert into rankings (season, `rank`, player, points) values ('2024-25',28,'Manilla, Erika',37.5);
insert into rankings (season, `rank`, player, points) values ('2024-25',28,'Rico, Daniela',37.5);
insert into rankings (season, `rank`, player, points) values ('2024-25',34,'Rodriguez, Victoria',18.75);
insert into rankings (season, `rank`, player, points) values ('2024-25',34,'Wilscam, Ofelia',18.75);
insert into rankings (season, `rank`, player, points) values ('2024-25',34,'Reyes, Andrea',18.75);
insert into rankings (season, `rank`, player, points) values ('2024-25',34,'Gonzalez, Lucia',18.75);
insert into rankings (season, `rank`, player, points) values ('2024-25',34,'Salazar, Yanna',18.75);
insert into rankings (season, `rank`, player, points) values ('2024-25',34,'Williams, Erica',18.75);
insert into rankings (season, `rank`, player, points) values ('2024-25',34,'Millet, Bri',18.75);
insert into rankings (season, `rank`, player, points) values ('2024-25',34,'Jauvin, Chloe',18.75);
insert into rankings (season, `rank`, player, points) values ('2024-25',34,'Sullivan, Jolene',18.75);
insert into rankings (season, `rank`, player, points) values ('2024-25',34,'Rajsich, Rhonda',18.75);

commit;


select count(*) from rankings where season='2024-25';

select * from rankings where season='2024-25' order by convert(`rank`,unsigned integer);

-- now run name cleanup 

call sp_fixname ('Rodriguez, Maria Renee','Rodriguez Josey, Maria Renee');
call sp_fixname ('Rodriguez, Maria Renee','Josey, Maria Renee');

-- now run season summary report QA data: any player in the Season Summary report missing a seed has a name issue
-- or entered but did not show up for an event.

update rankings set player='Rodriguez, Victoria (USA)' where player='Rodriguez, Victoria' and season='2024-25';

select * from rankings where player like 'Rodriguez, Victoria%';

select * from results where loser like 'Rodriguez, Victoria%';

update results set winner='Rodriguez, Victoria (USA)' where winner='Rodriguez, Victoria' and season='2024-25';
update results set loser='Rodriguez, Victoria (USA)' where loser='Rodriguez, Victoria' and season='2023-24';

update results set winner='Rodriguez, Victoria (USA)' where winner like 'Rodriguez, Victoria (USA)%';
update results set loser='Rodriguez, Victoria (USA)' where loser like 'Rodriguez, Victoria (USA)%';
update results set loser='Rodriguez, Victoria (USA)' where loser like 'Rodriguez, Victoria  (USA)%';

call sp_fixname ('Reyes, Andrea','Reyes, Andrea Gabriela');


-- 100% all good.