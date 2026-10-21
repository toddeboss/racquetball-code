-- 6/29/17: thanks to input from Evan
-- screwed up results, combining two players accidentally Sofia Soley and Sofia Rascon
-- going back to data entry to hand-correct Soley results

select * from results where loser='Soley (Rascon), Sofia' order by tmp_date asc;

select * from results where winner='Soley (Rascon), Sofia' order by tmp_date asc;

create table results_20170629 as select * from results;

use cp30725_women;

SET SQL_SAFE_UPDATES = 0;

update results set loser='Soley, Sofia' where event='2014 Great Balls of Fire Pro-Am' and loser='Soley (Rascon), Sofia' and round=32;
update results set loser='Soley, Sofia' where event='20th United Healthcare US Open' and loser='Soley (Rascon), Sofia' and round=128;
update results set loser='Soley, Sofia' where event='2016 Mercedes-Benz of Cincinnati Pro Am' and loser='Soley (Rascon), Sofia' and round=32;
update results set loser='Soley, Sofia' where event='2016 Battle at the Alamo Regional Tournament' and loser='Soley (Rascon), Sofia' and round=32 and winner='Longoria, Paola';
update results set winner='Soley, Sofia' where event='2016 Battle at the Alamo Regional Tournament' and round=64;

commit;

-- now whatever is left is actually Sofia Rascon...
update results set winner='Rascon, Sofia' where winner='Soley (Rascon), Sofia';

update results set loser='Rascon, Sofia' where loser='Soley (Rascon), Sofia';

commit;

----------------------------------------

create table seedings_20170629 as select * from seedings;

select * from seedings where player='Soley (Rascon), Sofia' and event='2014 Great Balls of Fire Pro-Am';
update seedings set player='Soley, Sofia' where player='Soley (Rascon), Sofia' and event='2014 Great Balls of Fire Pro-Am';

select * from seedings where player='Soley (Rascon), Sofia' and event='20th United Healthcare US Open';
update seedings set player='Soley, Sofia' where player='Soley (Rascon), Sofia' and event='20th United Healthcare US Open' and seeding=39;

select * from seedings where player='Soley (Rascon), Sofia' and event='2016 Mercedes-Benz of Cincinnati Pro Am';
update seedings set player='Soley, Sofia' where player='Soley (Rascon), Sofia' and event='2016 Mercedes-Benz of Cincinnati Pro Am' and seeding=23;

select * from seedings where player='Soley (Rascon), Sofia' and event='2016 Battle at the Alamo Regional Tournament';
update seedings set player='Soley, Sofia' where player='Soley (Rascon), Sofia' and event='2016 Battle at the Alamo Regional Tournament' and seeding=32;

-- now whatever is left is actually Sofia Rascon...
update seedings set player='Rascon, Sofia' where player='Soley (Rascon), Sofia';

commit;

--------------------------
select * from rankings where player='Soley (Rascon), Sofia' order by season, rank;

-- Soley should have ranking points in 2013-14, 2015-16.  check.

create table rankings_20170629 as select * from rankings;

delete from rankings;

insert into rankings select * from rankings_20170629;

update rankings set player='Soley, Sofia' where season='2013-14' and rank='55T' and player='Soley (Rascon), Sofia';

update rankings set player='Soley, Sofia' where season='2015-16' and rank='44' and player='Soley (Rascon), Sofia';

-- now whatever is left is actually Sofia Rascon...
update rankings set player='Rascon, Sofia' where player='Soley (Rascon), Sofia';

commit;