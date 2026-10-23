-- fixing city of Outdoor Nationals

select winner_p1, winner_p2,loser_p1, loser_p2,score,city,event,date,season 
from results_doubles where round='2' and city like '%CA' order by tmp_date desc;

create table results_doubles_20200709 as select * from results_doubles;

select * from results_doubles where city like '%CA' and event like '% - Mens%' and tmp_date < '1991-12-31';

update results_doubles set city='Costa Mesa, CA' where city like '%CA' and tmp_date < '1991-12-31';

create table results_20200709 as select * from results;

select * from results where round='2' and city like '%CA' and event like '% - Mens%' order by tmp_date desc;

update results set city='Costa Mesa, CA' where city like '%CA' and tmp_date < '1991-12-31';

