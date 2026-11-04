
use cp30725_women;

SET SQL_SAFE_UPDATES = 0;

delete from rankings_source where season='1975-76';

insert into rankings_source (season,source) values ('1975-76','NR v4n4 July 1976');


insert into rankings (season, rank, player,points,prizemoney) values ('1975-76','1','Steding, Peggy',0,2850);
insert into rankings (season, rank, player,points,prizemoney) values ('1975-76','2','Wright, Shannon',0,1350);
insert into rankings (season, rank, player,points,prizemoney) values ('1975-76','3','Marriott, Janell',0,750);
insert into rankings (season, rank, player,points,prizemoney) values ('1975-76','4','Sauser, Jean',0,650);
insert into rankings (season, rank, player,points,prizemoney) values ('1975-76','5','Williams, Kathy',0,550);
insert into rankings (season, rank, player,points,prizemoney) values ('1975-76','6','Campbell, Jan',0,500);
insert into rankings (season, rank, player,points,prizemoney) values ('1975-76','6','Carow, Sue',0,500);
insert into rankings (season, rank, player,points,prizemoney) values ('1975-76','8','Pasternak, Jan',0,200);
insert into rankings (season, rank, player,points,prizemoney) values ('1975-76','9','Harding, Jennifer',0,150);
insert into rankings (season, rank, player,points,prizemoney) values ('1975-76','9','McCarthy, Camille',0,150);


commit;