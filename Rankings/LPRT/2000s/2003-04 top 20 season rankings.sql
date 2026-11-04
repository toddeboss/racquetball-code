-- rebuilding 2003-4 rankings from Racquetball Magazine May/June 2004 v15n3 pg23

create table rankings_20200425 as select * from rankings;

delete from rankings where season='2003-04';

insert into rankings (season, rank, player, points, record) values ('2003-04','1','Gudinas, Cheryl','905.5','');
insert into rankings (season, rank, player, points, record) values ('2003-04','2','Van Hees, Christie','479.25','');
insert into rankings (season, rank, player, points, record) values ('2003-04','3','Rajsich, Rhonda','462.25','');
insert into rankings (season, rank, player, points, record) values ('2003-04','4','Wachtel, Kerri','449.75','');
insert into rankings (season, rank, player, points, record) values ('2003-04','5','Walsh, Kristin','340.75','');
insert into rankings (season, rank, player, points, record) values ('2003-04','6','Hallander, Kersten','254.5','');
insert into rankings (season, rank, player, points, record) values ('2003-04','7','Fisher, Adrienne','209.75','');
insert into rankings (season, rank, player, points, record) values ('2003-04','8','Brown, Tammy','149','');
insert into rankings (season, rank, player, points, record) values ('2003-04','9','Grisar, Angela','138.25','');
insert into rankings (season, rank, player, points, record) values ('2003-04','10','Paraiso, Jackie','137','');
insert into rankings (season, rank, player, points, record) values ('2003-04','11','Kyzer, Brenda','135','');
insert into rankings (season, rank, player, points, record) values ('2003-04','12','Russell, Kim','133.25','');
insert into rankings (season, rank, player, points, record) values ('2003-04','13','Shattuck, Jo','119.5','');
insert into rankings (season, rank, player, points, record) values ('2003-04','14','Morton, Karen','91.75','');
insert into rankings (season, rank, player, points, record) values ('2003-04','15','Acosta, Susy','89','');
insert into rankings (season, rank, player, points, record) values ('2003-04','16','Gellman, Rachel','82','');
insert into rankings (season, rank, player, points, record) values ('2003-04','17','Munger, Stephanie','65.5','');
insert into rankings (season, rank, player, points, record) values ('2003-04','18','Csuk, Crystal','63.5','');
insert into rankings (season, rank, player, points, record) values ('2003-04','19','Von Ondarza, Ramona','56.25','');
insert into rankings (season, rank, player, points, record) values ('2003-04','20','Powell, Lori-Jane','52.5','');

commit;

create table rankings_source_20200425 as select * from rankings_source;

delete from rankings_source where season='2003-04';

insert into rankings_source (season,source) values ('2003-04','Racquetball Magazine May/June 2004 v15n3 pg23');

-- now run  name cleanup