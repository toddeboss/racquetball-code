-- updating cities of USA nationals from the early days.

-- found a couple of links that helped:

-- http://lindamojer.com/04web_bkup/usra/pub&ref/factbook/timeline.htm
-- http://racquetballmuseum.com/historicaltimeline.html

SET SQL_SAFE_UPDATES = 0;

select * from tourneys where event like '%USA%' and event not like '%Womens%' order by tmp_date desc;

-- question marks start in 74, end in 83

select * from tourneys where event like '1974 USA%';

select * from results where event like '1974 USA%';

create table tourneys_20210125 as select * from tourneys;

create table results_20210125 as select * from results;



update tourneys set city='San Diego, CA' where event like '1974 USA%';
update results set city='San Diego, CA' where event like '1974 USA%';

update tourneys set city='St. Louis, MO' where event like '1975 USA%';
update results set city='St. Louis, MO' where event like '1975 USA%';

update tourneys set city='Chattanooga, TN' where event like '1976 USA%';
update results set city='Chattanooga, TN' where event like '1976 USA%';

update tourneys set city='Southfield, MI' where event like '1977 USA%';
update results set city='Southfield, MI' where event like '1977 USA%';

update tourneys set city='Denver, CO' where event like '1978 USA%';
update results set city='Denver, CO' where event like '1978 USA%';

-- 1979 vegas already insert

update tourneys set city='Miami, FL' where event like '1980 USA%';
update results set city='Miami, FL' where event like '1980 USA%';

update tourneys set city='Boise, ID' where event like '1981 USA%';
update results set city='Boise, ID' where event like '1981 USA%';

-- 1982 in Buffalo ok.

------------------------------------------
-- doubles!

select * from tourneys_doubles where event like '%US%' and event not like '%Women%' order by tmp_date desc;

select * from tourneys_doubles order by tmp_date desc;

select * from results_doubles where round=2 and tmp_date between '2019-01-01' and '2019-12-31';

-- oddly, we're missing 2019 event in tourneys_doubles.

insert into tourneys_doubles (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'N' from results_doubles where tmp_date='2019-02-10';


create table tourneys_doubles_20210129 as select * from tourneys_doubles;

create table results_doubles_20210129 as select * from results_doubles;

-- US Amateur doubles cities all correct.