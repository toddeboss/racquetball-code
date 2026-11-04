-- Re-create RYDF roster 10/2/19

create table cp30725_prs.team_rydf_20191002 as select * from cp30725_prs.team_rydf;

select * from cp30725_prs.team_rydf_20190628;

select * from cp30725_prs.team_rydf;

truncate table cp30725_prs.team_rydf;

-- 37 men as of 10/1/19
insert into cp30725_prs.team_rydf (player) values ('Natera, Alan');
insert into cp30725_prs.team_rydf (player) values ('Cardona, Alejandro');
insert into cp30725_prs.team_rydf (player) values ('Landa, Alejandro');
insert into cp30725_prs.team_rydf (player) values ('Parrilla, Andree');
insert into cp30725_prs.team_rydf (player) values ('Acuna, Andres');
insert into cp30725_prs.team_rydf (player) values ('Keller, Carlos');
insert into cp30725_prs.team_rydf (player) values ('Moscoso, Conrrado');
insert into cp30725_prs.team_rydf (player) values ('Horn, David');

insert into cp30725_prs.team_rydf (player) values ('Garay, Eduardo');
insert into cp30725_prs.team_rydf (player) values ('Portillo, Eduardo');
insert into cp30725_prs.team_rydf (player) values ('Nieto, Oscar');
insert into cp30725_prs.team_rydf (player) values ('Cuevas, Erick');
insert into cp30725_prs.team_rydf (player) values ('Ochoa, Ernesto');
insert into cp30725_prs.team_rydf (player) values ('Troncoso, Francisco');
insert into cp30725_prs.team_rydf (player) values ('Franco, Gerardo');
insert into cp30725_prs.team_rydf (player) values ('Gomez, Andres');
insert into cp30725_prs.team_rydf (player) values ('Bredenbeck, Jake');
insert into cp30725_prs.team_rydf (player) values ('Martell, Jaime');
insert into cp30725_prs.team_rydf (player) values ('Estrada, Javier');

insert into cp30725_prs.team_rydf (player) values ('Alonso, Jordy');
insert into cp30725_prs.team_rydf (player) values ('Diaz, Jose');
insert into cp30725_prs.team_rydf (player) values ('Rodriguez, Juan Pablo');
insert into cp30725_prs.team_rydf (player) values ('Benson, Justus');

insert into cp30725_prs.team_rydf (player) values ('Avila, Luis');
insert into cp30725_prs.team_rydf (player) values ('Mercado, Mario');
insert into cp30725_prs.team_rydf (player) values ('Zelada, Mauricio');
insert into cp30725_prs.team_rydf (player) values ('Rojas, Daniel (Mauro)');
insert into cp30725_prs.team_rydf (player) values ('Diaz, Ricardo');
insert into cp30725_prs.team_rydf (player) values ('Collins, Robert');
insert into cp30725_prs.team_rydf (player) values ('Montoya, Rodrigo');
insert into cp30725_prs.team_rydf (player) values ('Murray, Samuel');
insert into cp30725_prs.team_rydf (player) values ('Fernandez, Sebastian');
insert into cp30725_prs.team_rydf (player) values ('Franco, Sebastian');
insert into cp30725_prs.team_rydf (player) values ('Cubillos, Set');
insert into cp30725_prs.team_rydf (player) values ('Carter, Thomas');
insert into cp30725_prs.team_rydf (player) values ('Webb, Trevor');
insert into cp30725_prs.team_rydf (player) values ('Camacho, Vicente');



commit;

-- 23 women as of 10/1/19
insert into cp30725_prs.team_rydf (player) values ('Herrera, Alexandra');
insert into cp30725_prs.team_rydf (player) values ('Pratt (Orozco), Cecilia');
insert into cp30725_prs.team_rydf (player) values ('Flores, Ana Laura');
insert into cp30725_prs.team_rydf (player) values ('Barrios, Angelica');
insert into cp30725_prs.team_rydf (player) values ('Laime, Brenda');
insert into cp30725_prs.team_rydf (player) values ('Munoz, Carla');
insert into cp30725_prs.team_rydf (player) values ('Amaya, Cristina');
insert into cp30725_prs.team_rydf (player) values ('Molina, Daniela');
insert into cp30725_prs.team_rydf (player) values ('Maldonado, Denisse');
insert into cp30725_prs.team_rydf (player) values ('Roberts, Annie');
insert into cp30725_prs.team_rydf (player) values ('Rivera (Groves), Erin');
insert into cp30725_prs.team_rydf (player) values ('Scott, Hollie');
insert into cp30725_prs.team_rydf (player) values ('Riquelme, Maria Paz');
insert into cp30725_prs.team_rydf (player) values ('Rodriguez, Maria Renee');
insert into cp30725_prs.team_rydf (player) values ('Ortiz, Maricruz');
insert into cp30725_prs.team_rydf (player) values ('Franco, Maritza');
insert into cp30725_prs.team_rydf (player) values ('Rivera, Masiel');
insert into cp30725_prs.team_rydf (player) values ('Mejia, Monserrat');
insert into cp30725_prs.team_rydf (player) values ('Perez, Monserrat');
insert into cp30725_prs.team_rydf (player) values ('Enriquez, Nancy');
insert into cp30725_prs.team_rydf (player) values ('Salas, Samantha');
insert into cp30725_prs.team_rydf (player) values ('Acosta, Susana');
insert into cp30725_prs.team_rydf (player) values ('Centellas, Valeria');


commit;

-- quick fixes on Pratt's name.

use cp30725_prs;

SET SQL_SAFE_UPDATES = 0;

update cp30725_prs.team_rydf  set player='Pratt (Orozco), Cecilia' where player='Orozco), Cecilia';

select  * from cp30725_prs.player_profile where player like '%Pratt%';

call sp_fixname ('Pratt (Orozco), Cecilia','Pratt, Ceci');