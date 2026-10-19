-- fix of Eduardo Garay results in 2015 San Luis open



/* -------------------------------------------------------- */
-- simple instructions

use cp30725_wrt;

SET SQL_SAFE_UPDATES = 0;

create table results_20170616 as select * from results;

select * from results where winner like 'Garay%';

select * from results where loser  like 'Garay%';

select * from results where event='2015 WRT San Luis Open';


update results set loser='Garay, Eduardo' where event='2015 WRT San Luis Open'
and round=16 and winner='Longoria, Christian';

create table seedings_20170616 as select * from seedings;

select * from seedings where event='2015 WRT San Luis Open' order by seeding;

update seedings set player='Garay, Eduardo' where event='2015 WRT San Luis Open' and seeding=24;

-- weird; there was no #25 seed.



