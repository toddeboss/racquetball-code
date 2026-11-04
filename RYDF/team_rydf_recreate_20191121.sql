use cp30725_prs;

drop table team_rydf;

create table team_rydf_20191114 as select * from team_rydf;

create table team_rydf_20191121 as select * from team_rydf;

create table team_rydf
(player varchar(50),
gender varchar(2),
email varchar(50),
phone varchar(20),
prefer varchar(20)
);

insert into cp30725_prs.team_rydf (player,gender) values ('Herrera, Alexandra','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Pratt (Orozco), Cecilia','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Flores, Ana Laura','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Barrios, Angelica','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Laime, Brenda','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Munoz, Carla','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Amaya, Cristina','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Molina, Daniela','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Maldonado, Denisse','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Roberts, Annie','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Rivera (Groves), Erin','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Scott, Hollie','F');



insert into cp30725_prs.team_rydf (player,gender) values ('Riquelme, Maria Paz','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Rodriguez, Maria Renee','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Ortiz, Maricruz','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Franco, Maritza','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Rivera, Masiel','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Mejia, Monserrat','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Perez, Monserrat','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Enriquez, Nancy','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Salas, Samantha','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Acosta, Susana','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Centellas, Valeria','F');


commit;

insert into cp30725_prs.team_rydf (player,gender) values ('Acuna, Andres','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Alonso, Jordy','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Avila, Luis','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Benson, Justus','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Bredenbeck, Jake','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Camacho, Vicente','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Cardona, Alejandro','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Carter, Thomas','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Collins, Robert','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Cubillos, Set','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Cuevas, Erick','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Diaz, Jose','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Diaz, Ricardo','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Estrada, Javier','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Fernandez, Sebastian','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Franco, Gerardo','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Franco, Sebastian','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Garay, Eduardo','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Gomez, Andres','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Horn, David','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Keller, Carlos','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Landa, Alejandro','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Martell, Jaime','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Mercado, Mario','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Montoya, Rodrigo','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Moscoso, Conrrado','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Murray, Samuel','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Natera, Alan','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Nieto, Oscar','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Ochoa, Ernesto','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Parrilla, Andree','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Portillo, Eduardo','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Rodriguez, Juan Pablo','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Rojas, Daniel (Mauro)','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Troncoso, Francisco','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Webb, Trevor','M');
insert into cp30725_prs.team_rydf (player,gender) values ('Zelada, Mauricio','M');


commit;

select * from team_rydf;

-- 11/21/19: adding two more ahead of chicago event

insert into cp30725_prs.team_rydf (player,gender) values ('Rico, Daniela','F');

insert into cp30725_prs.team_rydf (player,gender) values ('York, Lexi','F');

-- 11/21/19; also adding back in Daza, Parrilla, Lawrence

insert into cp30725_prs.team_rydf (player,gender) values ('Daza, Jenny','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Parrilla, Jessica','F');
insert into cp30725_prs.team_rydf (player,gender) values ('Lawrence, Kelani','F');

SET SQL_SAFE_UPDATES = 0;

update cp30725_prs.team_rydf set player='Lawrence (Bailey), Kelani' where player='Lawrence, Kelani';

commit;