use cp30725_men;

SET SQL_SAFE_UPDATES = 0;

select * from rankings where season='2005-6';

create table rankings_20151206 as select * from rankings;

delete from rankings where season='2005-6';

insert into rankings (season, rank, player, points) values ('2005-6','1','Waselenchuk, Kane',3248);
insert into rankings (season, rank, player, points) values ('2005-6','2','Huczek, Jack',3188);
insert into rankings (season, rank, player, points) values ('2005-6','3','Swain, Cliff',2243);
insert into rankings (season, rank, player, points) values ('2005-6','4','Beltran, Alvaro',2213);
insert into rankings (season, rank, player, points) values ('2005-6','5','Mannino, Jason',2130);
insert into rankings (season, rank, player, points) values ('2005-6','6','Carson, Rocky',2100);
insert into rankings (season, rank, player, points) values ('2005-6','7','Vanderson, Shane',1568);
insert into rankings (season, rank, player, points) values ('2005-6','8','Thoerner, Jason',1421);
insert into rankings (season, rank, player, points) values ('2005-6','9','Williams, Mitch',1166);
insert into rankings (season, rank, player, points) values ('2005-6','10','Crowther, Chris',1043);
insert into rankings (season, rank, player, points) values ('2005-6','11','Hawthorne, Andy',1013);
insert into rankings (season, rank, player, points) values ('2005-6','12','Tucker, Josh',975);
insert into rankings (season, rank, player, points) values ('2005-6','13','Herrera, Alejandro',833);
insert into rankings (season, rank, player, points) values ('2005-6','14','Croft, Ben',775);
insert into rankings (season, rank, player, points) values ('2005-6','15','Granberg, Aaron',710);
insert into rankings (season, rank, player, points) values ('2005-6','16','Guidry, Mike',702);
insert into rankings (season, rank, player, points) values ('2005-6','17','Veenstra, Kyle',652);
insert into rankings (season, rank, player, points) values ('2005-6','18','Gutierrez, Polo',604);
insert into rankings (season, rank, player, points) values ('2005-6','19','Gonzalez, Ruben',496);
insert into rankings (season, rank, player, points) values ('2005-6','20','Clouse, Woody',494);
insert into rankings (season, rank, player, points) values ('2005-6','21','Shimizu, Hiroshi',455);
insert into rankings (season, rank, player, points) values ('2005-6','22','Istace, Brian',420);
insert into rankings (season, rank, player, points) values ('2005-6','23','Herrera, Juan',398);
insert into rankings (season, rank, player, points) values ('2005-6','24','Tilton, Willie',334);
insert into rankings (season, rank, player, points) values ('2005-6','25','Moreno, Javier',317);
insert into rankings (season, rank, player, points) values ('2005-6','26','Herrera, Andres',309);
insert into rankings (season, rank, player, points) values ('2005-6','27','Crosser, Bryan',290);
insert into rankings (season, rank, player, points) values ('2005-6','28','De los rios, Gil',286);
insert into rankings (season, rank, player, points) values ('2005-6','29','Tristan, Agustin',272);
insert into rankings (season, rank, player, points) values ('2005-6','30','Gagnon, Vincent',199);
insert into rankings (season, rank, player, points) values ('2005-6','31','Derocheres, Eric',192);
insert into rankings (season, rank, player, points) values ('2005-6','32','Green, Mike',185);
insert into rankings (season, rank, player, points) values ('2005-6','33','Ganim, Doug',180);
insert into rankings (season, rank, player, points) values ('2005-6','34','Orr, Mike',174);
insert into rankings (season, rank, player, points) values ('2005-6','35','Smith, Ryan',147);
insert into rankings (season, rank, player, points) values ('2005-6','36','Ellis, John',139);
insert into rankings (season, rank, player, points) values ('2005-6','37','Pratt, Charlie',130);
insert into rankings (season, rank, player, points) values ('2005-6','38','Simons, Ben',124);
insert into rankings (season, rank, player, points) values ('2005-6','39','Ussery, Evan',114);
insert into rankings (season, rank, player, points) values ('2005-6','40','Odegard, Kris',106);
insert into rankings (season, rank, player, points) values ('2005-6','41','Solis, Greg',102);
insert into rankings (season, rank, player, points) values ('2005-6','42','Wagner, Jeff',98);
insert into rankings (season, rank, player, points) values ('2005-6','42','Walters, Brent',98);
insert into rankings (season, rank, player, points) values ('2005-6','42','Benderoth, Rich',98);
insert into rankings (season, rank, player, points) values ('2005-6','45','Fredenberg, Brian',92);
insert into rankings (season, rank, player, points) values ('2005-6','46','Woodbury, Travis',87);
insert into rankings (season, rank, player, points) values ('2005-6','47','Minor, Keith',86);
insert into rankings (season, rank, player, points) values ('2005-6','48','Purington, Chris',85);
insert into rankings (season, rank, player, points) values ('2005-6','49','Stark, Jeff',83);
insert into rankings (season, rank, player, points) values ('2005-6','50','Keddie, Mike',80);

commit;