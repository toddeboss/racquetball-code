-- team results loading ongoing.

use cp30725_irf;

SET SQL_SAFE_UPDATES = 0;

truncate table team_results_staging;

-- create table team_results_20180619 as select * from team_results;

create table team_results_20260403 as select * from team_results;


-- delete from team_results where season='2021';



load data local infile 'c:/Dropbox/z IT/temp/irf_2026_parc_team.csv' into table team_results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

-- load data local infile 'e:/Dropbox/z rball/IRF/IRF_Team_results.csv' into table team_results_staging
-- fields terminated by ',' enclosed by '"' lines terminated by '\n';

select * from team_results_staging;


delete from team_results_staging where country='Country';

delete from team_results_staging where country='';

-- update results_staging set tmp_date='2016-11-19';

update team_results_staging set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

update team_results_staging set season='2026' where season like '2026%';

update team_results_staging set season='2025' where season like '2025%';
update team_results_staging set season='2024' where season like '2024%';
update team_results_staging set season='2023' where season like '2023%';
update team_results_staging set season='2022' where season like '2022%';
update team_results_staging set season='2021' where season like '2021%';
update team_results_staging set season='2019' where season like '2019%';
update team_results_staging set season='2018' where season like '2018%';
update team_results_staging set season='2017' where season like '2017%';
update team_results_staging set season='2016' where season like '2016%';
update team_results_staging set season='2015' where season like '2015%';
update team_results_staging set season='2014' where season like '2014%';
update team_results_staging set season='2013' where season like '2013%';
update team_results_staging set season='2012' where season like '2012%';
update team_results_staging set season='2011' where season like '2011%';
update team_results_staging set season='2010' where season like '2010%';
update team_results_staging set season='2009' where season like '2009%';
update team_results_staging set season='2008' where season like '2008%';
update team_results_staging set season='2007' where season like '2007%';
update team_results_staging set season='2006' where season like '2006%';
update team_results_staging set season='2005' where season like '2005%';
update team_results_staging set season='2004' where season like '2004%';
update team_results_staging set season='2003' where season like '2003%';
update team_results_staging set season='2002' where season like '2002%';
update team_results_staging set season='2001' where season like '2001%';
update team_results_staging set season='2000' where season like '2000%';
update team_results_staging set season='1999' where season like '1999%';
update team_results_staging set season='1998' where season like '1998%';
update team_results_staging set season='1997' where season like '1997%';
update team_results_staging set season='1996' where season like '1996%';
update team_results_staging set season='1995' where season like '1995%';
update team_results_staging set season='1994' where season like '1994%';
update team_results_staging set season='1993' where season like '1993%';
update team_results_staging set season='1992' where season like '1992%';
update team_results_staging set season='1991' where season like '1991%';
update team_results_staging set season='1990' where season like '1990%';
update team_results_staging set season='1989' where season like '1989%';
update team_results_staging set season='1988' where season like '1988%';
update team_results_staging set season='1987' where season like '1987%';
update team_results_staging set season='1986' where season like '1986%';
update team_results_staging set season='1985' where season like '1985%';
update team_results_staging set season='1984' where season like '1984%';
update team_results_staging set season='1983' where season like '1983%';
update team_results_staging set season='1982' where season like '1982%';
update team_results_staging set season='1981' where season like '1981%';
update team_results_staging set season='1980' where season like '1980%';
update team_results_staging set season='1979' where season like '1979%';
update team_results_staging set season='1978' where season like '1978%';
update team_results_staging set season='1977' where season like '1977%';
update team_results_staging set season='1976' where season like '1976%';
update team_results_staging set season='1975' where season like '1975%';
update team_results_staging set season='1974' where season like '1974%';
update team_results_staging set season='1973' where season like '1973%';
update team_results_staging set season='1972' where season like '1972%';
update team_results_staging set season='1971' where season like '1971%';



select * from team_results_staging;

-- create table team_results_20201210 as select * from team_results;

-- truncate table team_results;

insert into team_results select * from team_results_staging;
commit;



