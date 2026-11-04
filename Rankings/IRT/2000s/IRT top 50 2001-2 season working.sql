-- 2001-2 rankings fixing from Magazine 3/27/25

use cp30725_men;

SET SQL_SAFE_UPDATES = 0;

select * from rankings where season='2001-2' order by convert(`rank`,unsigned integer);

select * from rankings_source where season='2001-2';

create table rankings_20250327 as select * from rankings;

create table rankings_source_20250327 as select * from rankings_source;

select * from rankings_source order by season desc;

delete from rankings where season='2001-2';

delete from rankings_source where season='2001-2';

insert into rankings_source (season,source) values ('2001-2','Confirmed per IRT website May 2002.  3/27/25 updated top 50 from Racquetball Magazine July/Aug 2002');

insert into rankings_source (season,source) values ('2025','In progress');

select * from rankings_source order by season desc;

commit;

-- now load rankings from working XLS

insert into rankings (season,`rank`,player) values ('2001-2','1','Swain, Cliff');
insert into rankings (season,`rank`,player) values ('2001-2','2','Mannino, Jason');
insert into rankings (season,`rank`,player) values ('2001-2','3','Ellis, John');
insert into rankings (season,`rank`,player) values ('2001-2','4','Waselenchuk, Kane');
insert into rankings (season,`rank`,player) values ('2001-2','5','Huczek, Jack');
insert into rankings (season,`rank`,player) values ('2001-2','6','Beltran, Alvaro');
insert into rankings (season,`rank`,player) values ('2001-2','7','Carson, Rocky');
insert into rankings (season,`rank`,player) values ('2001-2','8','Robinson, Derek');
insert into rankings (season,`rank`,player) values ('2001-2','9','Doyle, Tim');
insert into rankings (season,`rank`,player) values ('2001-2','10','Guidry, Mike');
insert into rankings (season,`rank`,player) values ('2001-2','11','Green, Mike');
insert into rankings (season,`rank`,player) values ('2001-2','12','Gonzalez, Ruben');
insert into rankings (season,`rank`,player) values ('2001-2','13','Istace, Brian');
insert into rankings (season,`rank`,player) values ('2001-2','14','Crowther, Chris');
insert into rankings (season,`rank`,player) values ('2001-2','15','Fowler, Dan');
insert into rankings (season,`rank`,player) values ('2001-2','16','Moreno, Javier');
insert into rankings (season,`rank`,player) values ('2001-2','17','Monchik, Sudsy');
insert into rankings (season,`rank`,player) values ('2001-2','18','Manzuri, Shai');
insert into rankings (season,`rank`,player) values ('2001-2','19','Clouse, Woody');
insert into rankings (season,`rank`,player) values ('2001-2','20','Brannigan, Erin');
insert into rankings (season,`rank`,player) values ('2001-2','21','Karp, Adam');
insert into rankings (season,`rank`,player) values ('2001-2','22','Llacera, Dan');
insert into rankings (season,`rank`,player) values ('2001-2','23','Valentine, Dale');
insert into rankings (season,`rank`,player) values ('2001-2','24','Locker, Mike');
insert into rankings (season,`rank`,player) values ('2001-2','25','Thomas, Greg');
insert into rankings (season,`rank`,player) values ('2001-2','26','Pointelin, Brian');
insert into rankings (season,`rank`,player) values ('2001-2','27','Dennison, Mike');
insert into rankings (season,`rank`,player) values ('2001-2','28','Odegard, Kris');
insert into rankings (season,`rank`,player) values ('2001-2','29','Ganim, Doug');
insert into rankings (season,`rank`,player) values ('2001-2','30','Thoerner, Jason');
insert into rankings (season,`rank`,player) values ('2001-2','31','Vogel, Luis');
insert into rankings (season,`rank`,player) values ('2001-2','32','Royster, Shawn');
insert into rankings (season,`rank`,player) values ('2001-2','33','Coyle, Eugene');
insert into rankings (season,`rank`,player) values ('2001-2','34','Vanderson, Shane');
insert into rankings (season,`rank`,player) values ('2001-2','35','Jansen, Jason');
insert into rankings (season,`rank`,player) values ('2001-2','36','Garner, Jeff');
insert into rankings (season,`rank`,player) values ('2001-2','37','Wright, Chris');
insert into rankings (season,`rank`,player) values ('2001-2','38','Moore, Bruce');
insert into rankings (season,`rank`,player) values ('2001-2','39','Shimzu, Hirosi');
insert into rankings (season,`rank`,player) values ('2001-2','40','Homa, Ryan');
insert into rankings (season,`rank`,player) values ('2001-2','41','Lockhart, James');
insert into rankings (season,`rank`,player) values ('2001-2','41','Gutierrez, Polo');
insert into rankings (season,`rank`,player) values ('2001-2','43','Minkel, Jim');
insert into rankings (season,`rank`,player) values ('2001-2','44','Hansen, Brent');
insert into rankings (season,`rank`,player) values ('2001-2','45','Frautschi, Jim');
insert into rankings (season,`rank`,player) values ('2001-2','46','Graham, Kevin');
insert into rankings (season,`rank`,player) values ('2001-2','47','Logan, Joey');
insert into rankings (season,`rank`,player) values ('2001-2','48','Willis, Ed');
insert into rankings (season,`rank`,player) values ('2001-2','49','Jimenez, Andres');
insert into rankings (season,`rank`,player) values ('2001-2','50','Walters, Brent');



select count(*) from rankings where season='2001-2';

select * from rankings where season='2001-2' order by convert(`rank`,unsigned integer) asc;


select player,count(*) from rankings where season='2001-2' group by player having count(*) > 1;

-- Roman Haller = duplicate folrf 2024; emailed Ryan, consolidated manually for now.


-- now run name cleanup.  




-- Now Run Season Summary report to see which players have results but names mismatch the rankings

-- just one missing player: Sifuentes, Phillip who no-showed for only result so in DB, no points.

call sp_fixname('Vogel, Louis','Vogel, Luis');


call sp_fixname('Shimizu, Hiroshi','Shimzu, Hiroshi');


-- that's it all done