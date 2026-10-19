-- fixing incorrectly input 2018 mexican jr nationals event
-- also fixing other incorrectly entered old events.


create table results_20190730 as select * from results;

create table seedings_20190730 as select * from seedings;

create table tourneys_20190730 as select * from tourneys;


SET SQL_SAFE_UPDATES = 0;


--------------------


-- 2019: newly input; no issues.

-- 2018: was using the wrong event; we had in Jr Olympics, not Jr Nationals.  Delete existing, reload from xls


select * from results where event like '2018 Mexico%';

delete from results where event like '2018 Mexico%';

delete from seedings where event like '2018 Mexico%';

delete from tourneys where event like '2018 Mexico%';

-- now re-load from XLS the proper 2018 event.
-- juniors_2018mexiconew.csv
-- juniors_2018mexiconew_seedings.csv

--------------------

-- for 2017, had right tourney, just need to load up all non 18/16 results
-- juniors_2017mexiconew.csv
-- no seeding.

select * from results where event like '2017 Mex%';

update results set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

update results set season='2017' where season like '2017%';

update tourneys set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

----------------------
-- 2016 was using right event, just needed to load more.

-- loaded up juniors_2016mexiconew.csv
select * from results where event like '2016 Mexico%';

call sp_fixname ('Griffen, Guadalupe','Griffin, Guadalupe');

call sp_fixname ('Ramos, Jose Carlos','Ramos, Jose');


----------------------

-- 2015: was using the wrong event; we had in Jr Olympics, not Jr Nationals.  Delete existing, reload from xls


select * from results where event like '2015 Mexico%';

delete from results where event like '2015 Mexico%';

delete from seedings where event like '2015 Mexico%';

delete from tourneys where event like '2015 Mexico%';

-- now re-load from XLS the proper 2015 event.

-- juniors_2015mexiconew.csv
-- juniors_2015mexiconew_seeding.csv

call sp_fixname ('Perez, Montserrat','Perez, Monserrat');

call sp_fixname ('Griffen, Guadalupe','Griffin, Guadalupe');

commit;

----------------------
-- 2014; no r2sports source

----------------------
-- 2013: have right link, need to add in younger winners
-- then, had to change results once got right data from Ryan

delete from results where event='2013 Mexico Junior Nationals - Boys 18U' and tour <> 'Boys 18U';

select * from tourneys where event='2013 Mexico Junior Nationals - Boys 18U';

delete from tourneys where event='2013 Mexico Junior Nationals - Boys 18U';

-- did load, then had to re-do load

delete from results where event like '2013 Mexico%';

delete from seedings where event like '2013 Mexico%';

delete from tourneys where event like '2013 Mexico%';









