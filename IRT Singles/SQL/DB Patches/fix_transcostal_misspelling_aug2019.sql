-- fixing misspelled Trans Coastal event names in database

use cp30725_men;

SET SQL_SAFE_UPDATES = 0;

create table results_20190812 as select * from results;

create table seedings_20190812 as select * from seedings;

create table tourneys_20190812 as select * from tourneys;

select distinct(event) from results where event like '%Costal%';

update results set event='5th TransCoastal Grand Nationals (GS #)' where event='5th TransCostal Grand Nationals (GS #3)';

update results set event='TransCoastal Grand Nationals' where event='TransCostal Grand Nationals';

update results set event='TransCoastal Tournament of Champions (GS #4)' where event='TransCostal Tournament of Champions (GS #4)';

update results set event='TransCoastal Tournament of Champs' where event='TransCostal Tournament of Champs';



update tourneys set event='5th TransCoastal Grand Nationals (GS #)' where event='5th TransCostal Grand Nationals (GS #3)';

update tourneys set event='TransCoastal Grand Nationals' where event='TransCostal Grand Nationals';

update tourneys set event='TransCoastal Tournament of Champions (GS #4)' where event='TransCostal Tournament of Champions (GS #4)';

update tourneys set event='TransCoastal Tournament of Champs' where event='TransCostal Tournament of Champs';

select distinct(event) from seedings where event like '%Costal%';
