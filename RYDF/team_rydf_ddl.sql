-- 11/14/19: adding gender

use cp30725_prs;

drop table team_rydf;

create table team_rydf
(player varchar(50),
gender varchar(2),
email varchar(50),
phone varchar(20),
prefer varchar(20)
);

/* the below no longer works; see roster xls for insertion details

truncate table team_rydf;

insert into team_rydf values ('Antone, Wayne','aantone@comcast.net','5419121608','any');
insert into team_rydf values ('Avila, Luis','luis96avila@hotmail.com','424-264-6515 (MX)','Email');
insert into team_rydf values ('Bredenbeck, Jake','jbrball@msn.com','651-253-9286','Text');
insert into team_rydf values ('Camacho, Victor ','camacho.raquet@gmail.com','33-1210-3006 (mx)','Facebook');
insert into team_rydf values ('Cardona, Alex','alex_cardona1_1@hormail.com','656-133-0731 (MX)','Email');
insert into team_rydf values ('Carter, Thomas','thomas_f_carter@yahoo.com','','Email or Text');
insert into team_rydf values ('Collins, Robbie','rc101190@aol.com','','Email or Text');
insert into team_rydf values ('Diaz, Jose','josediaz1993@yahoo.com','','Text');
insert into team_rydf values ('Franco, Sebastian','sebasfrancofranco@hotmail.com','','Email');
insert into team_rydf values ('Franco, Gerardo','gerardo-98-rcqt@hotmail.com','','Facebook');
insert into team_rydf values ('Horn, Bobby','bobbyhornrball@gmail.com','209-242-3451','Any');
insert into team_rydf values ('Martell, Jaime','jaimemartell18@gmail.com','','Email or Facebook');
insert into team_rydf values ('Mercado, Mario','marioraqueta_574@hotmail.com','','');
insert into team_rydf values ('Miller, Maurice','millergold93@aol.com','','Email or Text');
insert into team_rydf values ('Montoya, Rodrigo','rodrigo_montoya96@live.com.mx','','Facebook');
insert into team_rydf values ('Parrilla, Andree','andreparrilla@hotmail.com','','Facebook');
insert into team_rydf values ('Riffel, Nick','riffelnicholas@gmail.com','970-488-0095','Facebook or Text');
insert into team_rydf values ('Rodriguez, Miguel','antoniorod98@outlook.com','','Email');
insert into team_rydf values ('Rojas, Antonio','tatoepotatoe9@gmail.com','','Facebook');
insert into team_rydf values ('Rojas, Daniel','drojas3@ymail.com','','Facebook');
insert into team_rydf values ('Vazquez, Kevin','kevin.vazquez06@hotmail.com','786-763-5958','text');
insert into team_rydf values ('Warigon, Troy','troy.warigon@gmail.com','','Facebook');
insert into team_rydf values ('Zelada, MoMo','formulaflow@yahoo.com','','Any');

insert into team_rydf values ('Amaya, Cristina','cristiamaya@gmail.com','480-300-1368','Email  ');
insert into team_rydf values ('Bailey, Kelani','kqbailey@gmail.com','757-642-1763','Email');
insert into team_rydf values ('Cooperider, Jordan','jnracquetball@gmail.com','727-434-2643','Email or Text');
insert into team_rydf values ('Franco, Ma Regina','mreglz@hotmail.com','444-291-5328 (MX)','Any');
insert into team_rydf values ('Franco, Maritza','maritzfg05@outlook.com','444-315-9943 (MX)','Email or Facebook');
insert into team_rydf values ('Gonzalez, Lucia','chinaytuti_95@hotmail.com','656-379-7955 (MX)','Facebook');
insert into team_rydf values ('Hanson, Arrisa','arrisahanson@yahoo.com','804-539-4700','Email');
insert into team_rydf values ('Herrera, Alexandra','ale_sandra1095love@hotmail.com','812-150-7685 (MX)','Email');
insert into team_rydf values ('Luque, Carolina','caroluque007@gmail.com','444-419-6026 (MX)','Email  ');
insert into team_rydf values ('Martinez, Gabriela','gabymg99@gmail.com','502-4211-1923 (GT)','Facebook');
insert into team_rydf values ('Mejia, Montse','montse.mejia6@hotmail.es','444-313-9061 (MX)','Any');
insert into team_rydf values ('Munoz, Carla','carla.m14@gmail.com','925-364-0270','Email ');
insert into team_rydf values ('Parrilla, Jessica','jpbn1@hotmail.com','444-329-1238 (MX)','Facebook');
insert into team_rydf values ('Pratt, Ceci','ceci320@hotmail.com','503-939-8923','Email or Text');
insert into team_rydf values ('Rascon , Sofia','arminda8_12@hotmail.com','','Any');
insert into team_rydf values ('Rivera, Masiel','masielx3@hotmail.com','','Email or Text');
insert into team_rydf values ('Rodriguez, Ma Renee','mariarenee.rodriguez@gmail.com','502-4211-5870 (GT)','Any');
insert into team_rydf values ('Scott, Hollie','hollieraescott57@yahoo.com','360-201-0511','Email or Text');
insert into team_rydf values ('Shnurman, Hannah','Hannah.shnurman@gmail.com','515-720-3097','Email or Text');
insert into team_rydf values ('Simmons, Samantha','samanthajsimmons@aol.com','','Any');
insert into team_rydf values ('York, Lexi','lexijoyo@gmail.com','503-432-7575','Text');


insert into team_rydf (player) values ('Fernandez, Sebastian');
insert into team_rydf (player) values ('Garcia, Diego');
insert into team_rydf (player) values ('Sabja, Yazmine');
insert into team_rydf (player) values ('Navia, Jenny');
-- insert into team_rydf (player) values ('Martinez, Gaby');
insert into team_rydf (player) values ('Barrios, Angelica');
insert into team_rydf (player) values ('Enriquez, Nancy');
insert into team_rydf (player) values ('Moscosco, Conrrado');
insert into team_rydf (player) values ('Laime, Brenda');
insert into team_rydf (player) values ('Portillo, Eduardo');
insert into team_rydf (player) values ('Elkins, Dane');
insert into team_rydf (player) values ('Flores, Ana Laura');
insert into team_rydf (player) values ('Groves, Erin');
insert into team_rydf (player) values ('Natera, Alan');
insert into team_rydf (player) values ('Alonso, Jordy');
insert into team_rydf (player) values ('Iwassa, Coby');
insert into team_rydf (player) values ('Murray, Samuel');
insert into team_rydf (player) values ('Centellas, Valerie');
insert into team_rydf (player) values ('Roberts, Annie');

-- delete from team_rydf where player='Martinez, Gaby';
-- delete from team_rydf where player='Martinez, Ana Gabriela' and email is null;

commit;

-- cleaning uip a couple of names that weren't cleaning properly with sp_fixname.
update team_rydf set player='Rascon, Sofia' where player='Rascon , Sofia';
update team_rydf set player='Moscoso, Conrrado' where player='Moscosco, Conrrado';

commit;

select * from team_rydf order by player;

-- 10/15/18: adding two players

insert into cp30725_prs.team_rydf (player) values ('Diaz, Ricardo');

insert into cp30725_prs.team_rydf (player) values ('Longoria, Christian');

insert into cp30725_prs.team_rydf (player) values ('Manilla, Adam');


*/