use cp30725_men;

SET SQL_SAFE_UPDATES = 0;

select * from rankings where season='1978-9' order by convert(rank,unsigned integer);

create table rankings_20151206 as select * from rankings;

select * from rankings_source order by season desc;

delete from rankings where season='1978-9';

delete from rankings_source where season='1978-9';
insert into rankings_source (season,source) values ('1978-9','12/6/16 replaced DP qtrs results with top 20 from NR mid 1979');


insert into rankings (season, rank, player,points) values ('1978-9','1','Hogan, Marty',0);
insert into rankings (season, rank, player,points) values ('1978-9','2','Hilecher, Jerry',0);
insert into rankings (season, rank, player,points) values ('1978-9','3','Wagner, Richard',0);
insert into rankings (season, rank, player,points) values ('1978-9','4','Strandemo, Steve',0);
insert into rankings (season, rank, player,points) values ('1978-9','5','Fleetwood, David',0);
insert into rankings (season, rank, player,points) values ('1978-9','6','Yellen, Mike',0);
insert into rankings (season, rank, player,points) values ('1978-9','7','Koltun, Ben',0);
insert into rankings (season, rank, player,points) values ('1978-9','8','Bledsoe, Davey',0);
insert into rankings (season, rank, player,points) values ('1978-9','9','McCoy, Craig',0);
insert into rankings (season, rank, player,points) values ('1978-9','10','Peck, Dave',0);
insert into rankings (season, rank, player,points) values ('1978-9','11','Brumfield, Charlie',0);
insert into rankings (season, rank, player,points) values ('1978-9','12','Morrow, Mark',0);
insert into rankings (season, rank, player,points) values ('1978-9','13','Keeley, Steve',0);
insert into rankings (season, rank, player,points) values ('1978-9','13','Jones, Jay',0);
insert into rankings (season, rank, player,points) values ('1978-9','13','Zuckerman, Jerry',0);
insert into rankings (season, rank, player,points) values ('1978-9','16','Chase, Steve',0);
insert into rankings (season, rank, player,points) values ('1978-9','16','Zeitman, Mike',0);
insert into rankings (season, rank, player,points) values ('1978-9','18','Serot, Steve',0);
insert into rankings (season, rank, player,points) values ('1978-9','19','Wirkus, Jim',0);
insert into rankings (season, rank, player,points) values ('1978-9','19','Campbell, Eric',0);
insert into rankings (season, rank, player,points) values ('1978-9','19','Ikier, Paul',0);




commit;