-- fix of tourneys_doubles after incorrectly loading up singles tourneys...

select * from tourneys_doubles order by tmp_date desc;

truncate table tourneys_doubles;

insert into tourneys_doubles select * from tourneys_doubles_precanada;

select * from tourneys_doubles;

select distinct city,event,date,tmp_date,season,'N' from results_doubles_staging;

select distinct city,event,date,tmp_date,season,'N' from results_doubles_staging;

insert into tourneys_doubles (city,event,date,tmp_date,season,major_flag)
select distinct city,event,date,tmp_date,season,'N' from results_doubles order by tmp_date desc;

commit;



