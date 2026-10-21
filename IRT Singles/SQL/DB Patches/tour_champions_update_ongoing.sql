use cp30725_men;

SET SQL_SAFE_UPDATES = 0;


-- Go to the bottom!!!



/* 5/11/09: populating the tour_champions at end of season */
select * from tour_champions order by season desc;

-- don't forget to update code to set "none declared yet" season



/* 9/20/10: populating the tour_champions at end of 2010 season */
select * from tour_champions;
insert into tour_champions values ('2009-10','Kane Waselenchuk');

-- don't forget to update code to set "none declared yet" season





/* 6/3/11: populating the tour_champions at end of 2010-11 season */
select * from tour_champions order by season desc;

insert into tour_champions values ('2010-11','Kane Waselenchuk');
commit;

/* 6/3/11: populating the tour_champions at end of 2010-11 season */
select * from tour_champions order by season desc;

insert into tour_champions values ('2011-12','Kane Waselenchuk');
commit;



insert into tour_champions values ('2012-13','Kane Waselenchuk');
commit;



insert into tour_champions values ('2014-15','Kane Waselenchuk','Waselenchuk, Kane');
commit;

-- don't forget to update code to set "none declared yet" season


insert into tour_champions values ('2015-16','None Declared Yet','None Declared Yet');
commit;

-- 5/23/16 work for 2015-16 season

update tour_champions set player='Kane Waselenchuk', player_dbname='Waselenchuk, Kane'
where season='2015-16';

insert into tour_champions values ('2016-17','None Declared Yet','None Declared Yet');
commit;


-- 5/2/17 work for 2015-16 season

update tour_champions set player='Kane Waselenchuk', player_dbname='Waselenchuk, Kane'
where season='2016-17';

insert into tour_champions values ('2017-18','None Declared Yet','None Declared Yet');
commit;

SET SQL_SAFE_UPDATES = 0;

-- 2017-18 work


update tour_champions set player='Rocky Carson', player_dbname='Carson, Rocky'
where season='2017-18';

insert into tour_champions values ('2018-19','None Declared Yet','None Declared Yet');

commit;

-- 2018-19 work


update tour_champions set player='Kane Waselenchuk', player_dbname='Waselenchuk, Kane'
where season='2018-19';

insert into tour_champions values ('2019-20','None Declared Yet','None Declared Yet');

commit;



-- 2019-20 work

SET SQL_SAFE_UPDATES = 0;



update tour_champions set player='Kane Waselenchuk', player_dbname='Waselenchuk, Kane'
where season='2019-20';

insert into tour_champions values ('2022','None Declared Yet','None Declared Yet');

commit;


-- 2021 work

SET SQL_SAFE_UPDATES = 0;

update tour_champions set season='2021' where season='2020-21';

update tour_champions set player='Daniel De La Rosa', player_dbname='De La Rosa, Daniel'
where season='2021';

insert into tour_champions values ('2020-21','None Declared Yet','None Declared Yet');

commit;




-- 2022 work

SET SQL_SAFE_UPDATES = 0;

select * from tour_champions order by season desc;

-- update tour_champions set season='2021' where season='2020-21';

update tour_champions set player='Daniel De La Rosa', player_dbname='De La Rosa, Daniel'
where season='2022';

insert into tour_champions values ('2023','None Declared Yet','None Declared Yet');

commit;



-- 2023 work

SET SQL_SAFE_UPDATES = 0;

select * from tour_champions order by season desc;

-- update tour_champions set season='2021' where season='2020-21';

update tour_champions set player='Daniel De La Rosa', player_dbname='De La Rosa, Daniel'
where season='2023';

insert into tour_champions values ('2024','None Declared Yet','None Declared Yet');

commit;


-- 2024 work

SET SQL_SAFE_UPDATES = 0;

select * from tour_champions order by season desc;

-- update tour_champions set season='2021' where season='2020-21';

update tour_champions set player='Kane Waselenchuk', player_dbname='Waselenchuk, Kane' where season='2024';

insert into tour_champions values ('2025','None Declared Yet','None Declared Yet');

commit;


-- 2025-26 work

SET SQL_SAFE_UPDATES = 0;

select * from tour_champions order by season desc;

-- update tour_champions set season='2021' where season='2020-21';

update tour_champions set player='Kane Waselenchuk', player_dbname='Waselenchuk, Kane' where season='2025-26';

insert into tour_champions values ('2026-27','None Declared Yet','None Declared Yet');

commit;






-- audit data
select * from tour_champions order by season desc;








