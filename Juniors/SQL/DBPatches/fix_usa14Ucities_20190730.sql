-- Fix cities in 14U USA events; corrupted for some reason.

select * from tourneys where event like '%USA%' and event like '%Boys 18U' order by tmp_date desc;

SET SQL_SAFE_UPDATES = 0;

update results set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

update tourneys set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

-- use XLS to generate the below

update tourneys set city='Portland, OR' where event='2019 USA Junior Nationals - Girls 14U';
update tourneys set city='Des Moines, IA' where event='2018 USA Junior Nationals - Girls 14U';
update tourneys set city='Stockton, CA' where event='2017 USA Junior Nationals - Girls 14U';
update tourneys set city='Minneapolis, MN' where event='2016 USA Junior Nationals - Girls 14U';
update tourneys set city='Stockton, CA' where event='2015 USA Junior Nationals - Girls 14U';
update tourneys set city='Denver, CO' where event='2014 USA Junior Nationals - Girls 14U';
update tourneys set city='Des Moines, IA' where event='2013 USA Junior Nationals - Girls 14U';
update tourneys set city='Portland, OR' where event='2005 USA Junior Nationals - Girls 14U';


update tourneys set city='Portland, OR' where event='2019 USA Junior Nationals - Boys 14U';
update tourneys set city='Des Moines, IA' where event='2018 USA Junior Nationals - Boys 14U';
update tourneys set city='Stockton, CA' where event='2017 USA Junior Nationals - Boys 14U';
update tourneys set city='Minneapolis, MN' where event='2016 USA Junior Nationals - Boys 14U';
update tourneys set city='Stockton, CA' where event='2015 USA Junior Nationals - Boys 14U';
update tourneys set city='Denver, CO' where event='2014 USA Junior Nationals - Boys 14U';
update tourneys set city='Des Moines, IA' where event='2013 USA Junior Nationals - Boys 14U';
update tourneys set city='Portland, OR' where event='2005 USA Junior Nationals - Boys 14U';



update results set city='Portland, OR' where event='2019 USA Junior Nationals - Girls 14U';
update results set city='Des Moines, IA' where event='2018 USA Junior Nationals - Girls 14U';
update results set city='Stockton, CA' where event='2017 USA Junior Nationals - Girls 14U';
update results set city='Minneapolis, MN' where event='2016 USA Junior Nationals - Girls 14U';
update results set city='Stockton, CA' where event='2015 USA Junior Nationals - Girls 14U';
update results set city='Denver, CO' where event='2014 USA Junior Nationals - Girls 14U';
update results set city='Des Moines, IA' where event='2013 USA Junior Nationals - Girls 14U';
update results set city='Portland, OR' where event='2005 USA Junior Nationals - Girls 14U';

update results set city='Portland, OR' where event='2019 USA Junior Nationals - Boys 14U';
update results set city='Des Moines, IA' where event='2018 USA Junior Nationals - Boys 14U';
update results set city='Stockton, CA' where event='2017 USA Junior Nationals - Boys 14U';
update results set city='Minneapolis, MN' where event='2016 USA Junior Nationals - Boys 14U';
update results set city='Stockton, CA' where event='2015 USA Junior Nationals - Boys 14U';
update results set city='Denver, CO' where event='2014 USA Junior Nationals - Boys 14U';
update results set city='Des Moines, IA' where event='2013 USA Junior Nationals - Boys 14U';
update results set city='Portland, OR' where event='2005 USA Junior Nationals - Boys 14U';



