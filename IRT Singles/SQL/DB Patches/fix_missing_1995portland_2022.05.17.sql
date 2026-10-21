-- quick audit of tourneys found one missing.

SET SQL_SAFE_UPDATES = 0;           
           
select count(*) from tourneys;

select count(distinct(event)) from results;

select * from tourneys where event not in (select distinct(event) from results);

select * from results where event='5th TransCoastal Grand Nationals (GS #)';

select * from results where tmp_date='1992-05-17';

select * from results where event like '%Tournament of Champions%';

select * from tourneys where event like '%Tournament of Champions%';

select * from results where tmp_date='1995-06-11';


update tourneys set event='5th TransCoastal Grand Nationals (GS #3)' where event='5th TransCoastal Grand Nationals (GS #)';


select * from results where score='10,7,(8),3';           

-- turns out we were missing the 1995 Tourney of champions: must have been deleted.  re-loaded

