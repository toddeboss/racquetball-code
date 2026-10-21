select distinct(event) from seedings where event like '%US Open%';

select distinct(event) from tourneys where event like '%US Open%' order by tmp_date desc;

select distinct tmp_date from results where event like '%US Open%' order by tmp_date desc;

-- fix of us open tourney names in seedings table

use cp30725_men;

SET SQL_SAFE_UPDATES = 0;

create table seedings_20180426 as select * from seedings;

update seedings set event='United Healthcare 19th US Open' where event='2014 United Healthcare US Open';

update seedings set event='United Healthcare 18th US Open' where event='2013 United Healthcare US Open';

update seedings set event='United Healthcare 17th US Open' where event='2012 United Healthcare US Open';

commit;


select * from results where event like '2014 Pete Pierces Party with the Pros';

select * from tourneys where event like '2014 Pete Pierces Party with the Pros';

select * from seedings where event like '2014 Pete%s';

update seedings set event='2014 Pete Pierces Party with the Pros'
where event='2014 Pete Pierce''s Party with the Pros';



