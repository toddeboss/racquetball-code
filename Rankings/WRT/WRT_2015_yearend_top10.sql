set SQL_SAFE_UPDATES=0;

insert into rankings (season, rank, player, points) values ('2015','1','Cardona, Alejandro',0);
insert into rankings (season, rank, player, points) values ('2015','2','Bredenbeck, Jake',0);
insert into rankings (season, rank, player, points) values ('2015','3','Horn, David',0);
insert into rankings (season, rank, player, points) values ('2015','4','Gutierrez, Polo',0);
insert into rankings (season, rank, player, points) values ('2015','5','Parrilla, Andree',0);
insert into rankings (season, rank, player, points) values ('2015','6','Herrera, Anthony',0);
insert into rankings (season, rank, player, points) values ('2015','7','Martell, Jaime',0);
insert into rankings (season, rank, player, points) values ('2015','8','Landa, Alejandro',0);
insert into rankings (season, rank, player, points) values ('2015','9','Franco, Sebastian',0);
insert into rankings (season, rank, player, points) values ('2015','10','Ugalde, Jose Daniel',0);

select * from rankings where season='2015';

select * from rankings_source;

update rankings_source set source='archive.org as of 1/20/16' where season='2015';

