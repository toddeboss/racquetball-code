
use cp30725_women;

SET SQL_SAFE_UPDATES = 0;

delete from rankings_source where season='1976-77';

insert into rankings_source (season,source) values ('1976-77','NR v5n4 July 1977 pg 131');


insert into rankings (season, rank, player,points,prizemoney) values ('1976-77','1','Wright, Shannon',0,0);
insert into rankings (season, rank, player,points,prizemoney) values ('1976-77','2','Steding, Peggy',0,0);
insert into rankings (season, rank, player,points,prizemoney) values ('1976-77','3','Marriott, Janell',0,0);
insert into rankings (season, rank, player,points,prizemoney) values ('1976-77','4','Williams, Kathy',0,0);
insert into rankings (season, rank, player,points,prizemoney) values ('1976-77','5','Harding, Jennifer',0,0);
insert into rankings (season, rank, player,points,prizemoney) values ('1976-77','6','Sauser, Jean',0,0);
insert into rankings (season, rank, player,points,prizemoney) values ('1976-77','7','Campbell, Jan',0,0);
insert into rankings (season, rank, player,points,prizemoney) values ('1976-77','8','Green, Sarah',0,0);
insert into rankings (season, rank, player,points,prizemoney) values ('1976-77','9','Hoff, Rita',0,0);
insert into rankings (season, rank, player,points,prizemoney) values ('1976-77','10','Carow, Sue',0,0);
insert into rankings (season, rank, player,points,prizemoney) values ('1976-77','11','Byrd, Martha',0,0);
insert into rankings (season, rank, player,points,prizemoney) values ('1976-77','12','Pasternak, Jan',0,0);
insert into rankings (season, rank, player,points,prizemoney) values ('1976-77','13','Weed, Bette',0,0);
insert into rankings (season, rank, player,points,prizemoney) values ('1976-77','14','McCarthy, Camille',0,0);
insert into rankings (season, rank, player,points,prizemoney) values ('1976-77','15','Schmidt, Pat',0,0);

commit;