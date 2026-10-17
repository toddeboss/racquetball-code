-- 9/15/13: modifying this for new season, new site

/* Process:
- start Bitvise ssh client
- login to 3essentials site
- minimize window
- start Mysql workbench as normal

*/



/* -------------------------------------------------------- */
-- simple instructions

use cp30725_irf;

SET SQL_SAFE_UPDATES = 0;

delete from results_doubles_staging;

delete from seedings_doubles_staging;


create table results_doubles_20260403 as select * from results_doubles;

create table tourneys_doubles_20260403 as select * from tourneys_doubles;

create table seedings_doubles_20260403 as select * from seedings_doubles;


load data local infile 'c:/Dropbox/z IT/temp/irf_2026_parc_doubles.csv' into table results_doubles_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

-- load data local infile 'E:/Dropbox/z rball/IRF Doubles/IRF_doubles_results.csv' into table results_doubles_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\n';

-- load data local infile 'C:/Users/tboss/Dropbox/z rball/IRT/temp working files/irt_portland17_doublesresults.csv' into table results_doubles_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\n';


select * from results_doubles_staging;

delete from results_doubles_staging where winner_p1='Winner Player 1';

-- update results_doubles_staging set tmp_date='2016-11-19';

update results_doubles_staging set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

-- this gets trailing space embedded in the xls data entry.

update results_doubles_staging set season='2026';

update results_doubles_staging set season='2023' where season like '2023%';
update results_doubles_staging set season='2022' where season like '2022%';
update results_doubles_staging set season='2021' where season like '2021%';
update results_doubles_staging set season='2020' where season like '2020%';
update results_doubles_staging set season='2019' where season like '2019%';
update results_doubles_staging set season='2018' where season like '2018%';
update results_doubles_staging set season='2017' where season like '2017%';
update results_doubles_staging set season='2016' where season like '2016%';
update results_doubles_staging set season='2015' where season like '2015%';
update results_doubles_staging set season='2014' where season like '2014%';
update results_doubles_staging set season='2013' where season like '2013%';
update results_doubles_staging set season='2012' where season like '2012%';
update results_doubles_staging set season='2011' where season like '2011%';
update results_doubles_staging set season='2010' where season like '2010%';
update results_doubles_staging set season='2009' where season like '2009%';
update results_doubles_staging set season='2008' where season like '2008%';
update results_doubles_staging set season='2007' where season like '2007%';
update results_doubles_staging set season='2006' where season like '2006%';
update results_doubles_staging set season='2005' where season like '2005%';
update results_doubles_staging set season='2004' where season like '2004%';
update results_doubles_staging set season='2003' where season like '2003%';
update results_doubles_staging set season='2002' where season like '2002%';
update results_doubles_staging set season='2001' where season like '2001%';
update results_doubles_staging set season='2000' where season like '2000%';
update results_doubles_staging set season='1999' where season like '1999%';
update results_doubles_staging set season='1998' where season like '1998%';
update results_doubles_staging set season='1997' where season like '1997%';
update results_doubles_staging set season='1996' where season like '1996%';
update results_doubles_staging set season='1995' where season like '1995%';
update results_doubles_staging set season='1994' where season like '1994%';
update results_doubles_staging set season='1993' where season like '1993%';
update results_doubles_staging set season='1992' where season like '1992%';
update results_doubles_staging set season='1991' where season like '1991%';
update results_doubles_staging set season='1990' where season like '1990%';
update results_doubles_staging set season='1989' where season like '1989%';
update results_doubles_staging set season='1988' where season like '1988%';
update results_doubles_staging set season='1987' where season like '1987%';
update results_doubles_staging set season='1986' where season like '1986%';
update results_doubles_staging set season='1985' where season like '1985%';
update results_doubles_staging set season='1984' where season like '1984%';
update results_doubles_staging set season='1983' where season like '1983%';
update results_doubles_staging set season='1982' where season like '1982%';
update results_doubles_staging set season='1981' where season like '1981%';
update results_doubles_staging set season='1980' where season like '1980%';
update results_doubles_staging set season='1979' where season like '1979%';
update results_doubles_staging set season='1978' where season like '1978%';
update results_doubles_staging set season='1977' where season like '1977%';
update results_doubles_staging set season='1976' where season like '1976%';
update results_doubles_staging set season='1975' where season like '1975%';
update results_doubles_staging set season='1974' where season like '1974%';
update results_doubles_staging set season='1973' where season like '1973%';
update results_doubles_staging set season='1972' where season like '1972%';
update results_doubles_staging set season='1971' where season like '1971%';
update results_doubles_staging set season='1970' where season like '1970%';
update results_doubles_staging set season='1969' where season like '1969%';
update results_doubles_staging set season='1968' where season like '1968%';


update results_doubles_staging set round=99 where round=0;

update results_doubles_staging set round=99 where round='RR';

select * from results_doubles_staging;



insert into results_doubles select * from results_doubles_staging;
commit;





-- All irf events go in as "N" 
insert into tourneys_doubles (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'N' from results_doubles_staging;



load data local infile 'c:/Dropbox/z IT/temp/irf_2026_parc_doubles_seeding.csv' into table seedings_doubles_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

-- load data local infile 'E:/Dropbox/z rball/IRF Doubles/IRF_doubles_seedings.csv' into table seedings_doubles_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

-- load data local infile 'C:/Users/tboss/Dropbox/z rball/IRT/temp working files/irt_portland17_doublesresults_seedings.csv' into table seedings_doubles_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\r\n';


select * from seedings_doubles_staging order by seeding;

delete from seedings_doubles_staging where event='Event';

select * from seedings_doubles_staging where player1='?';

insert into seedings_doubles select * from seedings_doubles_staging;
commit;

--
-- run name clean up here
--


delete from wins_doubles;

insert into wins_doubles
select p.winner, sum(wins) as wins from (
select winner_p1 as winner, count(winner_p1) as wins
from results_doubles
group by winner_p1
union all
select winner_p2 winner, count(winner_p2) as wins
from results_doubles
group by winner_p2) p
group by p.winner order by 1;


select * from banner;

delete from banner;
insert into banner values ('IRF singles: Loaded all finals data dating to 1981.  IRF Doubles in progress. IRF summary complete from 1981-2015.','7/3/18');
commit;


-- now post to meetandplay, twitter


9/15/13: modifying this for new season, new site

/* Process:
- start Bitvise ssh client
- login to 3essentials site
- minimize window
- start Mysql workbench as normal

*/



/* -------------------------------------------------------- */
-- simple instructions

use cp30725_irf;

SET SQL_SAFE_UPDATES = 0;

delete from results_doubles_staging;

delete from seedings_doubles_staging;


create table results_doubles_20230409 as select * from results_doubles;

create table tourneys_doubles_20230409 as select * from tourneys_doubles;

create table seedings_doubles_20230409 as select * from seedings_doubles;


load data local infile 'c:/temp/irf_2023parc_doubles.csv' into table results_doubles_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

-- load data local infile 'E:/Dropbox/z rball/IRF Doubles/IRF_doubles_results.csv' into table results_doubles_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\n';

-- load data local infile 'C:/Users/tboss/Dropbox/z rball/IRT/temp working files/irt_portland17_doublesresults.csv' into table results_doubles_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\n';


select * from results_doubles_staging;

delete from results_doubles_staging where winner_p1='Winner Player 1';

-- update results_doubles_staging set tmp_date='2016-11-19';

update results_doubles_staging set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

-- this gets trailing space embedded in the xls data entry.

update results_doubles_staging set season='2023' where season like '2023%';

update results_doubles_staging set season='2022' where season like '2022%';
update results_doubles_staging set season='2021' where season like '2021%';
update results_doubles_staging set season='2020' where season like '2020%';
update results_doubles_staging set season='2019' where season like '2019%';
update results_doubles_staging set season='2018' where season like '2018%';
update results_doubles_staging set season='2017' where season like '2017%';
update results_doubles_staging set season='2016' where season like '2016%';
update results_doubles_staging set season='2015' where season like '2015%';
update results_doubles_staging set season='2014' where season like '2014%';
update results_doubles_staging set season='2013' where season like '2013%';
update results_doubles_staging set season='2012' where season like '2012%';
update results_doubles_staging set season='2011' where season like '2011%';
update results_doubles_staging set season='2010' where season like '2010%';
update results_doubles_staging set season='2009' where season like '2009%';
update results_doubles_staging set season='2008' where season like '2008%';
update results_doubles_staging set season='2007' where season like '2007%';
update results_doubles_staging set season='2006' where season like '2006%';
update results_doubles_staging set season='2005' where season like '2005%';
update results_doubles_staging set season='2004' where season like '2004%';
update results_doubles_staging set season='2003' where season like '2003%';
update results_doubles_staging set season='2002' where season like '2002%';
update results_doubles_staging set season='2001' where season like '2001%';
update results_doubles_staging set season='2000' where season like '2000%';
update results_doubles_staging set season='1999' where season like '1999%';
update results_doubles_staging set season='1998' where season like '1998%';
update results_doubles_staging set season='1997' where season like '1997%';
update results_doubles_staging set season='1996' where season like '1996%';
update results_doubles_staging set season='1995' where season like '1995%';
update results_doubles_staging set season='1994' where season like '1994%';
update results_doubles_staging set season='1993' where season like '1993%';
update results_doubles_staging set season='1992' where season like '1992%';
update results_doubles_staging set season='1991' where season like '1991%';
update results_doubles_staging set season='1990' where season like '1990%';
update results_doubles_staging set season='1989' where season like '1989%';
update results_doubles_staging set season='1988' where season like '1988%';
update results_doubles_staging set season='1987' where season like '1987%';
update results_doubles_staging set season='1986' where season like '1986%';
update results_doubles_staging set season='1985' where season like '1985%';
update results_doubles_staging set season='1984' where season like '1984%';
update results_doubles_staging set season='1983' where season like '1983%';
update results_doubles_staging set season='1982' where season like '1982%';
update results_doubles_staging set season='1981' where season like '1981%';
update results_doubles_staging set season='1980' where season like '1980%';
update results_doubles_staging set season='1979' where season like '1979%';
update results_doubles_staging set season='1978' where season like '1978%';
update results_doubles_staging set season='1977' where season like '1977%';
update results_doubles_staging set season='1976' where season like '1976%';
update results_doubles_staging set season='1975' where season like '1975%';
update results_doubles_staging set season='1974' where season like '1974%';
update results_doubles_staging set season='1973' where season like '1973%';
update results_doubles_staging set season='1972' where season like '1972%';
update results_doubles_staging set season='1971' where season like '1971%';
update results_doubles_staging set season='1970' where season like '1970%';
update results_doubles_staging set season='1969' where season like '1969%';
update results_doubles_staging set season='1968' where season like '1968%';


update results_doubles_staging set round=99 where round=0;

update results_doubles_staging set round=99 where round='RR';

select * from results_doubles_staging;



insert into results_doubles select * from results_doubles_staging;
commit;





-- All irf events go in as "N" 
insert into tourneys_doubles (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'N' from results_doubles_staging;



load data local infile 'c:/temp/irf_2023parc_doubles_seeding.csv' into table seedings_doubles_staging
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

-- load data local infile 'E:/Dropbox/z rball/IRF Doubles/IRF_doubles_seedings.csv' into table seedings_doubles_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

-- load data local infile 'C:/Users/tboss/Dropbox/z rball/IRT/temp working files/irt_portland17_doublesresults_seedings.csv' into table seedings_doubles_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\r\n';


select * from seedings_doubles_staging order by seeding;

delete from seedings_doubles_staging where event='Event';

select * from seedings_doubles_staging where player1='?';

insert into seedings_doubles select * from seedings_doubles_staging;
commit;

--
-- run name clean up here
--


delete from wins_doubles;

insert into wins_doubles
select p.winner, sum(wins) as wins from (
select winner_p1 as winner, count(winner_p1) as wins
from results_doubles
group by winner_p1
union all
select winner_p2 winner, count(winner_p2) as wins
from results_doubles
group by winner_p2) p
group by p.winner order by 1;


select * from banner;

delete from banner;
insert into banner values ('IRF singles: Loaded all finals data dating to 1981.  IRF Doubles in progress. IRF summary complete from 1981-2015.','7/3/18');
commit;


-- now post to meetandplay, twitter


