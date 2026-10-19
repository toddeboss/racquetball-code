select * from results where event='2013 USA Junior Nationals - Boys 18U';

select * from seedings where event='2013 USA Junior Nationals - Boys 18U';

select * from tourneys where event='2013 USA Junior Nationals - Boys 18U';

delete from results where event='2013 USA Junior Nationals - Boys 18U';

delete from seedings where event='2013 USA Junior Nationals - Boys 18U';

delete from tourneys where event='2013 USA Junior Nationals - Boys 18U';


select winner,loser,score,city,event,date,season from results 
           where round='2' and season='2013' order by tmp_date asc, event asc;
           
call sp_fixname('Iwaasa, Coby','Iwassa, Coby');           
call sp_fixname('Gonzalez, Lucia Fernandez','Gonzalez, Lucia Fernandex');
call sp_fixname('Gonzalez, Lucia Fernandez','Gonzalez, Lucia');

select * from results where winner='Sauve, Jewel';

update results set loser=' ' where winner='Sauve, Jewel' and event='2016 Canadian Junior Nationals - Girls 18U' and round=2;

select count(*) from results;

select count(*) from tourneys;


select winner,loser,round,score,tour,city,event,date,season,notes 
           from results where 
           winner='Rojas, Daniel (Mauro)' or loser='Rojas, Daniel (Mauro)' order by tmp_date,event,round desc;
           
           
select * from results where score like '%50%';    

create table results_20180624 as select * from results;

update results set score='(5),12,9' where score='(50,12,9';

commit;
       
       
       
       
SET SQL_SAFE_UPDATES = 0;

select * from tourneys order by tmp_date desc;

create table tourneys_20180625 as select * from tourneys;

alter table tourneys add preview_url varchar(200);

alter table tourneys add wrapup_url varchar(200);       


select * from tourneys order by tmp_date desc;


-- USA 2018 jr nats
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/298821220658765' where event='2018 USA Junior Nationals - Girls 16U';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/298821220658765' where event='2018 USA Junior Nationals - Girls 18U';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/298821220658765' where event='2018 USA Junior Nationals - Boys 18U';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/298821220658765' where event='2018 USA Junior Nationals - Boys 16U';

-- mexican 2018 jr nats
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/281229279084626' where event='2018 Mexico Junior Nationals - Boys 14U';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/281229279084626' where event='2018 Mexico Junior Nationals - Boys 16U';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/281229279084626' where event='2018 Mexico Junior Nationals - Boys 18U';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/281229279084626' where event='2018 Mexico Junior Nationals - Girls 14U';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/281229279084626' where event='2018 Mexico Junior Nationals - Girls 16U';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/281229279084626' where event='2018 Mexico Junior Nationals - Girls 18U';

-- canada jr nats 2018

update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/274903743050513' where event='2018 Canadian Junior Nationals - Boys 18U';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/274903743050513' where event='2018 Canadian Junior Nationals - Boys 16U';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/274903743050513' where event='2018 Canadian Junior Nationals - Girls 18U';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/274903743050513' where event='2018 Canadian Junior Nationals - Girls 16U';



commit;