
-- quick fix of tourney name with "and" veruss "&"

select * from tourneys order by tmp_date desc;

update tourneys set event='2017 IRT Phase IV Scientific Health & Performance Pro-Am'
where tmp_date='2017-09-10';

select * from seedings where event='2017 IRT Phase IV Scientific Health & Performance Pro-Am';

update results set event='2017 IRT Phase IV Scientific Health & Performance Pro-Am'
where event='2017 IRT Phase IV Scientific Health and Performance Pro-Am';

