select * from rankings order by season desc, rank asc;

create table rankings_20190619 as select * from rankings;

select * from rankings where season='2018-19' order by rank;

select * from rankings where season='2018-19' order by convert(rank,unsigned integer);

delete from rankings where season='2018-19';




insert into rankings (season, rank, player, points) values ('2018-19','1','Longoria, Paola',2240.00);
insert into rankings (season, rank, player, points) values ('2018-19','2','Salas, Samantha',1661.50);
insert into rankings (season, rank, player, points) values ('2018-19','3','Vargas, Maria Jose',988.25);
insert into rankings (season, rank, player, points) values ('2018-19','4','Herrera, Alexandra',935.00);
insert into rankings (season, rank, player, points) values ('2018-19','5','Rajsich, Rhonda',728.50);
insert into rankings (season, rank, player, points) values ('2018-19','6','Mendez, Natalia',582.50);
insert into rankings (season, rank, player, points) values ('2018-19','7','Enriquez, Nancy',497.25);
insert into rankings (season, rank, player, points) values ('2018-19','8','Amaya, Cristina',458.50);
insert into rankings (season, rank, player, points) values ('2018-19','9','Lambert, Frederique',320.50);
insert into rankings (season, rank, player, points) values ('2018-19','10','Riveros, Adriana',309.50);
insert into rankings (season, rank, player, points) values ('2018-19','11','Martinez, Gabriella',307.50);
insert into rankings (season, rank, player, points) values ('2018-19','12','Rivera, Masiel',285.25);
insert into rankings (season, rank, player, points) values ('2018-19','13','Laime, Brenda',258.00);
insert into rankings (season, rank, player, points) values ('2018-19','14','Flores, Ana Laura',245.00);
insert into rankings (season, rank, player, points) values ('2018-19','15','Lee, Casandra',216.25);
insert into rankings (season, rank, player, points) values ('2018-19','16','Sabja, Yazmine',211.00);
insert into rankings (season, rank, player, points) values ('2018-19','17','Mejia, Monserrat',179.75);
insert into rankings (season, rank, player, points) values ('2018-19','18','Fisher Haynes, Adrienne',178.25);
insert into rankings (season, rank, player, points) values ('2018-19','19','Barrios, Angelica',170.75);
insert into rankings (season, rank, player, points) values ('2018-19','20','Munoz, Carla',164.75);
insert into rankings (season, rank, player, points) values ('2018-19','21','Lotts, Sheryl',163.75);
insert into rankings (season, rank, player, points) values ('2018-19','22','Acosta-Mendoza, Susy',159.00);
insert into rankings (season, rank, player, points) values ('2018-19','23','Rodriguez, Maria Renee',125.25);
insert into rankings (season, rank, player, points) values ('2018-19','24','De La Rosa, Michelle',120.75);
insert into rankings (season, rank, player, points) values ('2018-19','25','Bailey Lawrence, Kelani',95.75);
insert into rankings (season, rank, player, points) values ('2018-19','26','Perez, Montse',93.00);
insert into rankings (season, rank, player, points) values ('2018-19','27','Scott, Hollie',84.25);
insert into rankings (season, rank, player, points) values ('2018-19','28','Daza, Jenny',79.75);
insert into rankings (season, rank, player, points) values ('2018-19','29','Brandt, Laura',74.50);
insert into rankings (season, rank, player, points) values ('2018-19','30','Rivera, Erin',72.25);
insert into rankings (season, rank, player, points) values ('2018-19','31','Centellas, Valeria',70.00);
insert into rankings (season, rank, player, points) values ('2018-19','32','Maldonado, Denisse',59.75);
insert into rankings (season, rank, player, points) values ('2018-19','33','Dering, Jennifer',50.00);
insert into rankings (season, rank, player, points) values ('2018-19','33','Pratt, Ceci',50.00);
insert into rankings (season, rank, player, points) values ('2018-19','35','Meneses, Micaela',42.00);
insert into rankings (season, rank, player, points) values ('2018-19','36','Gudinas, Cheryl',41.50);
insert into rankings (season, rank, player, points) values ('2018-19','37','Parilla, Jessica',41.00);
insert into rankings (season, rank, player, points) values ('2018-19','38','Aguilar, Diana',40.00);
insert into rankings (season, rank, player, points) values ('2018-19','38','Rivero, Romina',40.00);
insert into rankings (season, rank, player, points) values ('2018-19','40','Rivera Luque, Carolina',32.50);
insert into rankings (season, rank, player, points) values ('2018-19','41','Shnurman, Hannah',32.25);
insert into rankings (season, rank, player, points) values ('2018-19','42','Ortiz, Maricruz',29.25);
insert into rankings (season, rank, player, points) values ('2018-19','43','Gonzalez, Lucia',29.00);
insert into rankings (season, rank, player, points) values ('2018-19','44','Tyler, Linda',28.75);
insert into rankings (season, rank, player, points) values ('2018-19','45','Maddux, Danielle',25.00);
insert into rankings (season, rank, player, points) values ('2018-19','45','Neils. Katherine',25.00);
insert into rankings (season, rank, player, points) values ('2018-19','47','Gomar, Marie',21.00);
insert into rankings (season, rank, player, points) values ('2018-19','48','Del Granado Revollo, Gabriela',20.00);
insert into rankings (season, rank, player, points) values ('2018-19','48','Garcia, Andrea',20.00);
insert into rankings (season, rank, player, points) values ('2018-19','48','Mazuelos, Melissa',20.00);
insert into rankings (season, rank, player, points) values ('2018-19','48','Quiroga, Andrea',20.00);
insert into rankings (season, rank, player, points) values ('2018-19','48','Rivero, Camilla',20.00);
insert into rankings (season, rank, player, points) values ('2018-19','48','Rodriguez, Nineth',20.00);
insert into rankings (season, rank, player, points) values ('2018-19','54','Kirchoff, Mary',18.75);
insert into rankings (season, rank, player, points) values ('2018-19','54','Manilla, Erika',18.75);
insert into rankings (season, rank, player, points) values ('2018-19','54','Rivera, Ana Kristina',18.75);
insert into rankings (season, rank, player, points) values ('2018-19','54','Whitmire, Robin',18.75);
insert into rankings (season, rank, player, points) values ('2018-19','58','Morisette, Michelle',17.25);
insert into rankings (season, rank, player, points) values ('2018-19','58','Rico, Daniela',17.25);
insert into rankings (season, rank, player, points) values ('2018-19','60','Brewer, Aime',12.50);
insert into rankings (season, rank, player, points) values ('2018-19','60','Riquelme, Maria Paz',12.50);
insert into rankings (season, rank, player, points) values ('2018-19','60','York, Lexi',12.50);
insert into rankings (season, rank, player, points) values ('2018-19','63','Molina, Daniela',12.25);
insert into rankings (season, rank, player, points) values ('2018-19','64','Lee, Youngock',3.75);
insert into rankings (season, rank, player, points) values ('2018-19','64','Sato, Maiko',3.75);
insert into rankings (season, rank, player, points) values ('2018-19','66','Aguilar, Delia',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Ana Jungeon',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Andrade, Claudia',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Baumbaugh, T.J.',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Camacho, Ana',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Cooperrider, Jordan',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Davis, Damonique',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Drury, Daniele',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Flores Segovia, Anakaren',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Fonseca, Lynn',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Franco, Maritza',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Franco, Regina',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Gonzalez, Ximena',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Gremley, Kelly',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Guillemette, Veronique',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Guzman Velgis, Eleni',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Halahan, Jean',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Hanson, Arrisa',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Hayes, Cheyenne',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Hernandez, Valeria',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Herrera Cristina, Daniela',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Hickey, Aisling',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Hughes, Grace',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Jackson, Sharon',0.00);
insert into rankings (season, rank, player, points) values ('2018-19','66','Jacquet, Briana',0.00);




commit;


select count(*) from rankings where season='2018-19';

-- now run name cleanup and QA data


