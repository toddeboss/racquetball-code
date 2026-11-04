create table rankings_20171122 as select * from rankings;

SET SQL_SAFE_UPDATES = 0;

select * from rankings where season='1975-6';

delete from rankings where season='1975-6';

insert into rankings (season,rank,player,prizemoney) values ('1975-6','1','Brumfield, Charlie','12675');
insert into rankings (season,rank,player,prizemoney) values ('1975-6','2','Hogan, Marty','6675');
insert into rankings (season,rank,player,prizemoney) values ('1975-6','3','Strandemo, Steve','4275');
insert into rankings (season,rank,player,prizemoney) values ('1975-6','4','Keeley, Steve','4025');
insert into rankings (season,rank,player,prizemoney) values ('1975-6','5','Wagner, Rich','3350');
insert into rankings (season,rank,player,prizemoney) values ('1975-6','6','Bledsoe, Davey','3075');
insert into rankings (season,rank,player,prizemoney) values ('1975-6','7','Serot, Steve','3050');
insert into rankings (season,rank,player,prizemoney) values ('1975-6','8','Schmidtke, Bill','2175');
insert into rankings (season,rank,player,prizemoney) values ('1975-6','9','Zeitman, Mike','1750');
insert into rankings (season,rank,player,prizemoney) values ('1975-6','10','McCoy, Craig','1700');
insert into rankings (season,rank,player,prizemoney) values ('1975-6','11','Hilecher, Jerry','1650');
insert into rankings (season,rank,player,prizemoney) values ('1975-6','12','Bowman, Jeff','800');
insert into rankings (season,rank,player,prizemoney) values ('1975-6','13','Rubenstein, Ron','450');
insert into rankings (season,rank,player,prizemoney) values ('1975-6','14','Ikier, Paul','400');

commit;

update rankings_source set source='1975-6: Charlie Brumfield: NR v4n4 pg 74' where season='1975-6';
