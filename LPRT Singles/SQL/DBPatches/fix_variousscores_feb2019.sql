
SET SQL_SAFE_UPDATES = 0;

create table results_20190220 as select * from results;

create table seedings_20190212 as select * from seedings;

select * from results where event='Promus Hotels 3rd US Open 98';

update results set loser='OBrien, Molly' where event='Promus Hotels 3rd US Open 98' and round=32 and loser='Kirch (OBrien), Aubrey';

select * from seedings where event='Promus Hotels 3rd US Open 98';


update seedings set player='OBrien, Molly' where event='Promus Hotels 3rd US Open 98' and seeding=6;

select * from results where event='1996 Annapolis Open';

update results set score='1,2,7' where event='1996 Annapolis Open' and loser='Fowler, Doreen' and round=16;
