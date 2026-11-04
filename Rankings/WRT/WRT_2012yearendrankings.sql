
/* 1/16/19: 2012 WRT year end rankings */


use cp30725_wrt;

SET SQL_SAFE_UPDATES = 0;


create table rankings_source_20190116 as select * from rankings_source;

create table rankings_20190116 as select * from rankings;

delete from rankings_source where season='2012';

insert into rankings_source (season,source) values ('2012','WRT Rankings 2016.xls from Pablo Fajre');



insert into rankings (season, rank, player, points) values ('2012','1','Keller, Carlos',1500);
insert into rankings (season, rank, player, points) values ('2012','2','Cardona, Alex',1000);
insert into rankings (season, rank, player, points) values ('2012','3','Cullen, Kurtis',600);
insert into rankings (season, rank, player, points) values ('2012','3','Aldana, Ismael',600);
insert into rankings (season, rank, player, points) values ('2012','5','Franco, Sebastian',325);
insert into rankings (season, rank, player, points) values ('2012','5','Castro, Pedro',325);
insert into rankings (season, rank, player, points) values ('2012','5','Hungerford, Josh',325);
insert into rankings (season, rank, player, points) values ('2012','5','Ivers, Justin',325);
insert into rankings (season, rank, player, points) values ('2012','9','Troncoso, Francisco',200);
insert into rankings (season, rank, player, points) values ('2012','9','Carrasco, Kadim',200);
insert into rankings (season, rank, player, points) values ('2012','9','Filippini, Rafael',200);
insert into rankings (season, rank, player, points) values ('2012','9','Schonberger, Anthony',200);
insert into rankings (season, rank, player, points) values ('2012','9','Varela, Jacob',200);
insert into rankings (season, rank, player, points) values ('2012','9','Salinas, Mark',200);
insert into rankings (season, rank, player, points) values ('2012','9','Swift, James',200);
insert into rankings (season, rank, player, points) values ('2012','9','Ellis, John',200);
insert into rankings (season, rank, player, points) values ('2012','17','Miramontes, Nicolai',120);
insert into rankings (season, rank, player, points) values ('2012','17','Rojas, Daniel',120);
insert into rankings (season, rank, player, points) values ('2012','17','Koliczew, Victor',120);
insert into rankings (season, rank, player, points) values ('2012','17','Du, S',120);
insert into rankings (season, rank, player, points) values ('2012','17','Meza, Luis',120);
insert into rankings (season, rank, player, points) values ('2012','17','Klemmensen, Kelly',120);


commit;

-- now run names cleanup

select count(*) from rankings where season='2012';coc