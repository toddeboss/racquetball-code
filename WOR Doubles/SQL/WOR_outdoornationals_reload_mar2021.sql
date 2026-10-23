-- 3/8/21 updating more Doubles data from elkins

use cp30725_wor;

SET SQL_SAFE_UPDATES = 0;

create table results_doubles_20210309 as select * from results_doubles;

create table seedings_doubles_20210309 as select * from seedings_doubles;

create table tourneys_doubles_20210309 as select * from tourneys_doubles;

select * from results_doubles where event='1976 3rd Outdoor National Championships - Mens Three Wall';


delete from results_doubles where event='1976 3rd Outdoor National Championships - Mens Three Wall';
delete from results_doubles where event='1978 5th Outdoor National Championships - Mens Three Wall';
delete from results_doubles where event='1982 9th Outdoor National Championships - Mens Three Wall';
delete from results_doubles where event='1983 10th Outdoor National Championships - Mens Three Wall';
delete from results_doubles where event='1984 11th Outdoor National Championships - Mens Three Wall';
delete from results_doubles where event='1985 12th Outdoor National Championships - Mens Three Wall';
delete from results_doubles where event='1987 14th Outdoor National Championships - Mens Three Wall';
delete from results_doubles where event='1991 18th Outdoor National Championships - Mens Three Wall';
delete from results_doubles where event='1996 23rd Outdoor National Championships - Mens Three Wall';


---

delete from results_doubles where event='2017 WOR Championships - Mens Three Wall';
delete from results_doubles where event='2016 WOR Championships - Mens Three Wall';
delete from results_doubles where event='2015 WOR Championships - Mens Three Wall';
delete from results_doubles where event='2014 WOR Championships presented by Ektelon - Mens Three Wall';
delete from results_doubles where event='2013 Roundabout Entertainment WOR Championships presented by Ektelon - Mens Three Wall';
delete from results_doubles where event='2012 WOR Championships presented by Roundabout Entertainment & Ektelon - Mens Three Wall';
delete from results_doubles where event='2011 WOR 38th Racquetball Warehouse World Championships presented by Ektelon - Mens Three Wall';
delete from results_doubles where event='2010 WOR Racquetball Warehouse Championships - Mens Three Wall';
delete from results_doubles where event='2009 Racquetball Warehouse WOR Championships - Mens Three Wall';
delete from results_doubles where event='2008 WOR Championships - Mens Three Wall';
delete from results_doubles where event='2007 WOR - Ektelon Championships - Mens Three Wall';
delete from results_doubles where event='2006 33rd Outdoor National Championships - Mens Three Wall';



select * from results_doubles where event='1989 16th Outdoor National Championships - Mens Three Wall';

update results_doubles set winner_p1='Hawkes, Brian' where round=2 and event='1989 16th Outdoor National Championships - Mens Three Wall';

select * from results_doubles where event='1990 17th Outdoor National Championships - Mens Three Wall';

update results_doubles set winner_p1='Hawkes, Brian' where round=2 and event='1990 17th Outdoor National Championships - Mens Three Wall';

commit;


-- 1981 confirmed

select * from results_doubles where event='1981 8th Outdoor National Championships - Mens Three Wall';

update results_doubles set winner_p1='Harding, Mike',winner_p2='Olson, Paul'
where event='1981 8th Outdoor National Championships - Mens Three Wall' and round=2;

commit;
