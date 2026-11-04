-- 1985-86 rankings update; expanding from top 10 initially put in into the top 50 as per the magazine. 12/30/20.

use cp30725_men;

SET SQL_SAFE_UPDATES = 0;

select * from rankings where season='1985-6' order by convert(rank,unsigned integer);

create table rankings_20201230 as select * from rankings;

create table rankings_source_20200613 as select * from rankings_source;

select * from rankings_source order by season desc;

delete from rankings where season='1985-6';

delete from rankings_source where season='2019-20';

insert into rankings_source (season,source) values ('2019-20','6/13/20 irt-tour.com end of season rankings as of 4/1/20, suspended due to Covid-19 at that date');

insert into rankings_source (season,source) values ('2020-21','In progress');


insert into rankings (season,rank,player,points) values ('1985-6',1,'Yellen, Mike',531.71);
insert into rankings (season,rank,player,points) values ('1985-6',2,'Harnett, Brett',451.38);
insert into rankings (season,rank,player,points) values ('1985-6',3,'Hogan, Marty',422.1);
insert into rankings (season,rank,player,points) values ('1985-6',4,'Peck, Gregg',375.36);
insert into rankings (season,rank,player,points) values ('1985-6',5,'Swain, Cliff',297.21);
insert into rankings (season,rank,player,points) values ('1985-6',6,'Ray, Mike',258.48);
insert into rankings (season,rank,player,points) values ('1985-6',7,'Peck, Dave',257.5);
insert into rankings (season,rank,player,points) values ('1985-6',8,'Gonzalez, Ruben',248.19);
insert into rankings (season,rank,player,points) values ('1985-6',9,'Andrews, Ed',236.45);
insert into rankings (season,rank,player,points) values ('1985-6',10,'Oliver, Scott',222.73);
insert into rankings (season,rank,player,points) values ('1985-6',11,'Price, Gerry',213.86);
insert into rankings (season,rank,player,points) values ('1985-6',12,'Hilecher, Jerry',198.02);
insert into rankings (season,rank,player,points) values ('1985-6',13,'Lerner, Steve',181.15);
insert into rankings (season,rank,player,points) values ('1985-6',14,'Cohen, Doug',158.46);
insert into rankings (season,rank,player,points) values ('1985-6',15,'Gross, Andy',154.73);
insert into rankings (season,rank,player,points) values ('1985-6',16,'Obremski, Dan',146.45);
insert into rankings (season,rank,player,points) values ('1985-6',17,'Gross, David',144.8);
insert into rankings (season,rank,player,points) values ('1985-6',18,'Inoue, Egan',134.38);
insert into rankings (season,rank,player,points) values ('1985-6',19,'Cascio, Jim',133.14);
insert into rankings (season,rank,player,points) values ('1985-6',20,'Egerman, John',124.79);
insert into rankings (season,rank,player,points) values ('1985-6',21,'Griffith, Mike',121.83);
insert into rankings (season,rank,player,points) values ('1985-6',22,'Sell, Bill',93.9);
insert into rankings (season,rank,player,points) values ('1985-6',23,'Navarro, Ray',93.04);
insert into rankings (season,rank,player,points) values ('1985-6',24,'Brysman, Corey',91.1);
insert into rankings (season,rank,player,points) values ('1985-6',25,'Newman, Jack',75.22);
insert into rankings (season,rank,player,points) values ('1985-6',26,'Wagner, Rich',57.27);
insert into rankings (season,rank,player,points) values ('1985-6',27,'Harripersad, Roger',56.6);
insert into rankings (season,rank,player,points) values ('1985-6',28,'Levine, Mark',53.59);
insert into rankings (season,rank,player,points) values ('1985-6',29,'Green, Dolawaine',51.31);
insert into rankings (season,rank,player,points) values ('1985-6',30,'Nolan, Jack',40.13);
insert into rankings (season,rank,player,points) values ('1985-6',31,'Moskwa, Sean',31.65);
insert into rankings (season,rank,player,points) values ('1985-6',32,'Johnson, Dave',31.35);
insert into rankings (season,rank,player,points) values ('1985-6',33,'Roberts, Andy',28.15);
insert into rankings (season,rank,player,points) values ('1985-6',34,'Clark,S',24.02);
insert into rankings (season,rank,player,points) values ('1985-6',35,'Plazak, Jeff',21.43);
insert into rankings (season,rank,player,points) values ('1985-6',36,'Britos, John',21.05);
insert into rankings (season,rank,player,points) values ('1985-6',37,'Gilliam, Lance',18.27);
insert into rankings (season,rank,player,points) values ('1985-6',38,'Embry, Aaron',16.49);
insert into rankings (season,rank,player,points) values ('1985-6',39,'Plotkin, Mark',16.09);
insert into rankings (season,rank,player,points) values ('1985-6',40,'Terry, Evan',11.8);
insert into rankings (season,rank,player,points) values ('1985-6',41,'Ganim, Doug',11.63);
insert into rankings (season,rank,player,points) values ('1985-6',42,'Williams, Ben',11.58);
insert into rankings (season,rank,player,points) values ('1985-6',43,'Katz, Aaron',10.98);
insert into rankings (season,rank,player,points) values ('1985-6',43,'Parodi, Bill',10.98);
insert into rankings (season,rank,player,points) values ('1985-6',45,'Hansen, E',10.06);
insert into rankings (season,rank,player,points) values ('1985-6',45,'Stead, T',10.06);
insert into rankings (season,rank,player,points) values ('1985-6',45,'Thielen, Tyler',10.06);
insert into rankings (season,rank,player,points) values ('1985-6',45,'Zirkle,D',10.06);
insert into rankings (season,rank,player,points) values ('1985-6',49,'Clouse, Woody',9.91);
insert into rankings (season,rank,player,points) values ('1985-6',50,'Wilhelm,B',9.69);

commit;



select count(*) from rankings where season='1985-6';

select * from rankings where season='1985-6' order by convert(rank,unsigned integer) asc;

-- now run name cleanup.  and test online to see if any name fixes need to be done.



commit;

