-- July 2019 fixing some older data 

select * from tourneys order by tmp_date desc;

select * from results where event='2019 46th Outdoor Racquetball Championships - Mens Three Wall';

update results set score='wbf-inj' where event='2019 46th Outdoor Racquetball Championships - Mens Three Wall' and round=2;

commit;


select * from results order by tmp_date asc;




-- loading up corrected old data

create table results_20190716 as select * from results;

select * from results where tour='WOR Mens Three Wall' and tmp_date < '2014-01-01' order by tmp_date desc;

delete from results where tour='WOR Mens Three Wall' and tmp_date < '2014-01-01';



select * from results where event='1981 8th WOR Championships - Mens Three Wall';

update results set loser='?' where event='1981 8th WOR Championships - Mens Three Wall' and round=4 and winner='Southern, Dan';

select * from results where event='1986 13th WOR Championships - Mens Three Wall';

-- was Booth as the semi finalist here, Peck thinks this is the year.
update results set loser='Peck, Gregg' where event='1986 13th WOR Championships - Mens Three Wall' and round=4 and winner='Southern, Dan';
update results set loser='Andrews, Ed' where event='1986 13th WOR Championships - Mens Three Wall' and round=4 and winner='Hawkes, Brian';



commit;





select count(*) from results;

select count(*) from tourneys;

select max(tmp_date) from results;

select count(*) from results_doubles;

select count(*) from tourneys_doubles;

select max(tmp_date) from results_doubles;




select winner,loser,score,city,event,date,season from results where round='2' and city like '%CA' and event like '% - Mens%' 
order by season desc, tmp_date desc, event asc;


create table results_20200425 as select * from results;
create table tourneys_20200425 as select * from tourneys;
create table seedings_20200425 as select * from seedings;

create table results_doubles_20200425 as select * from results_doubles;
create table tourneys_doubles_20200425 as select * from tourneys_doubles;
create table seedings_doubles_20200425 as select * from seedings_doubles;


truncate table results;
insert into results select * from results_20200425;

truncate table tourneys;
insert into tourneys select * from tourneys_20200425;

truncate table seedings;
insert into seedings select * from seedings_20200425;



truncate table results_doubles;
insert into results_doubles select * from results_doubles_20200425;

truncate table tourneys_doubles;
insert into tourneys_doubles select * from tourneys_doubles_20200425;

truncate table seedings_doubles;
insert into seedings_doubles select * from seedings_doubles_20200425;

call sp_fixname ('Lane, Craig "Clubber"','Lane, Craig');



-- reloading all WOR data; deleting current finals and loading whole draws

select * from results_doubles where event='2017 WOR Championships presented by Pro Kennex - Mens Three Wall';

delete from results_doubes where event='2017 WOR Championships presented by Pro Kennex - Mens Three Wall';
delete from results_doubes where event='2017 WOR Championships presented by Pro Kennex - Womens Three Wall';


select * from results_doubles where tour='WOR Mens Three Wall' and city like '%, CA' and tmp_date < '2017-12-31' order by tmp_date desc;

create table results_doubles_20200813 as select * from results_doubles;

delete from results_doubles where tour='WOR Mens Three Wall' and city like '%, CA' and tmp_date < '2017-12-31' order by tmp_date desc;





select * from results order by season desc;

create table results_20200715 as select * from results;


delete from results where date='Huntington Beach, CA';

delete from results where date='Costa Mesa, CA';

select winner_p1, winner_p2,loser_p1,loser_p2,score,city,event,date,season from results_doubles 
where round='2' and season='2019-20 ' order by tmp_date;

select * from results_doubles order by tmp_date desc;

update results_doubles set season='2019-20' where season like '2019-20%';

update tourneys_doubles set season='2019-20' where season like '2019-20%';

commit;

select distinct season from results order by 1;



select distinct event from results where city like '%NV';


select * from results_doubles where event='2020 11th Annual 3Wallball World Championships - Mens Three Wall';

create table results_doubles_20201019 as select * from results_doubles;

delete from results_doubles  where event='2020 11th Annual 3Wallball World Championships - Mens Three Wall' and loser_p1='?';


select * from results where event='2020 11th Annual 3Wallball World Championships - Mens Three Wall'
and winner='Lavely, Danny' and round=8;

update results set loser='Riffel, Nicholas'
where event='2020 11th Annual 3Wallball World Championships - Mens Three Wall'
and winner='Lavely, Danny' and round=8;


select winner from results where season ='2019-20' and city='Hollywood, FL' and round=2
and tour in ('WOR Mens One Wall','WOR Mens Three Wall');


select winner from results where season ='2020-21' and city='Hollywood, FL' and round=2 and tour ='WOR Mens One Wall';

select winner from results where season ='2020-21' and city='Hollywood, FL' and round=2 and tour ='WOR Mens One Wall';

select winner from results where season ='2020-21' and city like '%, CA' and round=2 and tour ='WOR Mens Three Wall';

select winner from results where season ='2020-21' and city='Las Vegas, NV' and round=2 and tour ='WOR Mens Three Wall';

select winner from results where season ='2020-21' and city='Las Vegas, NV' and round=2 and tour ='WOR Mens One Wall';

select winner_p1,winner_p2 from results_doubles where season ='2019-20' and city='Hollywood, FL' and round=2 and tour ='WOR Mens One Wall';


select  * from results_doubles where season='2019-20';

SET SQL_SAFE_UPDATES = 0;


create table results_doubles_20201021 as select * from results_doubles;


select tour, count(tour) from results_doubles group by tour;

update results_doubles set tour='WOR Mens One Wall' where tour='WORdbls Mens One Wall';
update results_doubles set tour='WOR Mens Three Wall' where tour='WORdbls Mens Three Wall';
update results_doubles set tour='WOR Mixed One Wall' where tour='WORdbls Mixed One Wall';
update results_doubles set tour='WOR Mixed Three Wall' where tour='WORdbls Mixed Three Wall';
update results_doubles set tour='WOR Womens One Wall' where tour='WORdbls Womens One Wall';
update results_doubles set tour='WOR Womens Three Wall' where tour='WORdbls Womens Three Wall';


commit;



select distinct(season) from results where season > '2006-7' order by season desc;

select * from results_doubles where winner_p1='No Division';

select * from results_doubles where event='2007 WOR - Ektelon Championships - Womens Three Wall';

update results_doubles set winner_p1='Rajsich, Rhonda', winner_p2='McDonald, Martha', loser_p1='Kaskawal, Kris', loser_p2='Knecht, Sherri'
where event='2007 WOR - Ektelon Championships - Womens Three Wall';


select * from results_doubles ;

update results_doubles set winner_p1='Ellis, John', winner_p2='Rajsich, Rhonda', loser_p1='Barrera, Georges', loser_p2='Degree, Gay'
where event='2007 WOR - Ektelon Championships - Mixed Three Wall';







