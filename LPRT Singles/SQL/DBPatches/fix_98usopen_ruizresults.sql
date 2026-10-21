-- 2/12/19: Evan points out a bug in the 98 us open data entry.


SET SQL_SAFE_UPDATES = 0;

create table results_20190212 as select * from results;

create table seedings_20190212 as select * from seedings;

select * from results where event='Promus Hotels 3rd US Open 98';

update results set loser='OBrien, Molly' where event='Promus Hotels 3rd US Open 98' and round=32 and loser='Kirch (OBrien), Aubrey';

select * from seedings where event='Promus Hotels 3rd US Open 98';


update seedings set player='OBrien, Molly' where event='Promus Hotels 3rd US Open 98' and seeding=6;