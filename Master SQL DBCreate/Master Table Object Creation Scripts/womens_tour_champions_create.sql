-- sql to make the tour_champions table.

-- truncate table tour_champions;

SET SQL_SAFE_UPDATES = 0;

create table tour_champions_20260624 as select * from tour_champions;

create table tour_champions_20240612 as select * from tour_champions;
create table tour_champions_20230622 as select * from tour_champions;
create table tour_champions_20220614 as select * from tour_champions;
create table tour_champions_20160611 as select * from tour_champions;
create table tour_champions_20190619 as select * from tour_champions;
create table tour_champions_20200608 as select * from tour_champions;

select * from tour_champions order by 1 desc;

update tour_champions set player='Maria Jose Vargas', player_dbname='Vargas, Maria Jose' where season='2025-26';
insert into tour_champions(season,player,player_dbname) values ('2026-27','None determined yet','None determined yet');

commit;

insert into tour_champions(season,player,player_dbname) values ('2025-26','None determined yet','None determined yet');
update tour_champions set player='Paola Longoria', player_dbname='Longoria, Paola' where season='2024-25';

insert into tour_champions(season,player,player_dbname) values ('2024-25','None determined yet','None determined yet');
update tour_champions set player='Maria Jose Vargas', player_dbname='Vargas, Maria Jose' where season='2023-24';

insert into tour_champions(season,player,player_dbname) values ('2023-24','None determined yet','None determined yet');
update tour_champions set player='Monserrat Mejia', player_dbname='Mejia, Monserrat' where season='2022-23';

insert into tour_champions(season,player,player_dbname) values ('2021-22','Paola Longoria','Longoria, Paola');
insert into tour_champions(season,player,player_dbname) values ('2020-21','Paola Longoria','Longoria, Paola');
insert into tour_champions(season,player,player_dbname) values ('2019-20','Paola Longoria','Longoria, Paola');
insert into tour_champions(season,player,player_dbname) values ('2018-19','Paola Longoria','Longoria, Paola');
insert into tour_champions(season,player,player_dbname) values ('2017-18','Paola Longoria','Longoria, Paola');
insert into tour_champions(season,player,player_dbname) values ('2016-17','Paola Longoria','Longoria, Paola');
insert into tour_champions(season,player,player_dbname) values ('2015-16','Paola Longoria','Longoria, Paola');
insert into tour_champions(season,player,player_dbname) values ('2014-15','Paola Longoria','Longoria, Paola');
insert into tour_champions(season,player,player_dbname) values ('2013-14','Paola Longoria','Longoria, Paola');
insert into tour_champions(season,player,player_dbname) values ('2012-13','Paola Longoria','Longoria, Paola');
insert into tour_champions(season,player,player_dbname) values ('2011-12','Paola Longoria','Longoria, Paola');
insert into tour_champions(season,player,player_dbname) values ('2010-11','Rhonda Rajsich','Rajsich, Rhonda');
insert into tour_champions(season,player,player_dbname) values ('2009-10','Paola Longoria','Longoria, Paola');
insert into tour_champions(season,player,player_dbname) values ('2008-09','Paola Longoria','Longoria, Paola');
insert into tour_champions(season,player,player_dbname) values ('2007-08','Rhonda Rajsich','Rajsich, Rhonda');
insert into tour_champions(season,player,player_dbname) values ('2006-07','Rhonda Rajsich','Rajsich, Rhonda');
insert into tour_champions(season,player,player_dbname) values ('2005-06','Rhonda Rajsich','Rajsich, Rhonda');
insert into tour_champions(season,player,player_dbname) values ('2004-05','Christie Van Hees','Huczek (Van Hees), Christie');
insert into tour_champions(season,player,player_dbname) values ('2003-04','Cheryl Gudinas','Gudinas, Cheryl');
insert into tour_champions(season,player,player_dbname) values ('2002-03','Cheryl Gudinas','Gudinas, Cheryl');
insert into tour_champions(season,player,player_dbname) values ('2001-02','Cheryl Gudinas','Gudinas, Cheryl');
insert into tour_champions(season,player,player_dbname) values ('2000-01','Cheryl Gudinas','Gudinas, Cheryl');
insert into tour_champions(season,player,player_dbname) values ('1999-00','Jackie Paraiso','Paraiso, Jackie');
insert into tour_champions(season,player,player_dbname) values ('1998-99','Jackie Paraiso','Paraiso, Jackie');
insert into tour_champions(season,player,player_dbname) values ('1997-98','Michelle Gould','Gould, Michelle');
insert into tour_champions(season,player,player_dbname) values ('1996-97','Michelle Gould','Gould, Michelle');
insert into tour_champions(season,player,player_dbname) values ('1995-96','Michelle Gould','Gould, Michelle');
insert into tour_champions(season,player,player_dbname) values ('1994-95','Michelle Gould','Gould, Michelle');
insert into tour_champions(season,player,player_dbname) values ('1993-94','Michelle Gould','Gould, Michelle');
insert into tour_champions(season,player,player_dbname) values ('1992-93','Michelle Gould','Gould, Michelle');
insert into tour_champions(season,player,player_dbname) values ('1991-92','Jackie Paraiso','Paraiso, Jackie');
insert into tour_champions(season,player,player_dbname) values ('1990-91','Michelle Gould','Gould, Michelle');
insert into tour_champions(season,player,player_dbname) values ('1989-90','Lynn Adams','Adams, Lynn');
insert into tour_champions(season,player,player_dbname) values ('1988-89','Caryn McKinney','McKinney, Caryn');
insert into tour_champions(season,player,player_dbname) values ('1987-88','Lynn Adams','Adams, Lynn');
insert into tour_champions(season,player,player_dbname) values ('1986-87','Lynn Adams','Adams, Lynn');
insert into tour_champions(season,player,player_dbname) values ('1985-86','Lynn Adams','Adams, Lynn');
insert into tour_champions(season,player,player_dbname) values ('1984-85','Lynn Adams 	','Adams, Lynn');
insert into tour_champions(season,player,player_dbname) values ('1983-84','Heather McKay','McKay, Heather');
insert into tour_champions(season,player,player_dbname) values ('1982-83','Heather McKay','McKay, Heather');
insert into tour_champions(season,player,player_dbname) values ('1981-82','Lynn Adams','Adams, Lynn');
insert into tour_champions(season,player,player_dbname) values ('1980-81','Heather McKay','McKay, Heather');
insert into tour_champions(season,player,player_dbname) values ('1979-80','Heather McKay','McKay, Heather');
insert into tour_champions(season,player,player_dbname) values ('1978-79','Shannon Wright-Hamilton','Wright-Hamilton, Shannon');
insert into tour_champions(season,player,player_dbname) values ('1977-78','Shannon Wright-Hamilton','Wright-Hamilton, Shannon');
insert into tour_champions(season,player,player_dbname) values ('1976-77','Shannon Wright-Hamilton','Wright-Hamilton, Shannon');
insert into tour_champions(season,player,player_dbname) values ('1975-76','Peggy Steding','Steding, Peggy');
-- insert into tour_champions(season,player,player_dbname) values ('1974-75','Peggy Steding','Steding, Peggy');
-- insert into tour_champions(season,player,player_dbname) values ('1973-74','Peggy Steding','Steding, Peggy');
-- insert into tour_champions(season,player,player_dbname) values ('1972-73','Peggy Steding','Steding, Peggy');
-- insert into tour_champions(season,player,player_dbname) values ('1971-72','Jan Pasternak','Pasternak, Jan');
-- insert into tour_champions(season,player,player_dbname) values ('1970-71','Jan Pasternak','Pasternak, Jan');
-- insert into tour_champions(season,player,player_dbname) values ('1969-70','Fran Cohen','Cohen, Fran');

commit;

select * from tour_champions order by season desc;