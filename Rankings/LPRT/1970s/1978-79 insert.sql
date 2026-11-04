
use cp30725_women;

SET SQL_SAFE_UPDATES = 0;

delete from rankings_source where season='1978-79';
insert into rankings_source (season,source) values ('1978-79','NR Mid 1979 loaded top 16 12/6/16');

delete from rankings where season='1978-9';

insert into rankings (season, rank, player,points) values ('1978-79','1','Wright, Shannon',0);
insert into rankings (season, rank, player,points) values ('1978-79','2','Greer, Marci',0);
insert into rankings (season, rank, player,points) values ('1978-79','3','Marriott, Janel',0);
insert into rankings (season, rank, player,points) values ('1978-79','4','Harding, Jennifer',0);
insert into rankings (season, rank, player,points) values ('1978-79','5','Sauser, Jean',0);
insert into rankings (season, rank, player,points) values ('1978-79','6','Green, Sarah',0);
insert into rankings (season, rank, player,points) values ('1978-79','7','Hoff, Rita',0);
insert into rankings (season, rank, player,points) values ('1978-79','8','Prefontaine, Linda',0);
insert into rankings (season, rank, player,points) values ('1978-79','9','Steding, Peggy',0);
insert into rankings (season, rank, player,points) values ('1978-79','10','Walton, Karin',0);
insert into rankings (season, rank, player,points) values ('1978-79','11','McDonald, Martha',0);
insert into rankings (season, rank, player,points) values ('1978-79','12','Williams, Kathy',0);
insert into rankings (season, rank, player,points) values ('1978-79','13','Matthews, Jan',0);
insert into rankings (season, rank, player,points) values ('1978-79','14','Moore, Alicia',0);
insert into rankings (season, rank, player,points) values ('1978-79','14','Schmidt, Pat',0);
insert into rankings (season, rank, player,points) values ('1978-79','16','Dugan, Susie',0);

commit;