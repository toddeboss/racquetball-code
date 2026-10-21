-- US Open patches/fixes for older matches Nov 2017

SET SQL_SAFE_UPDATES = 0;

select * from results where event like '4th%';

select * from results where event='4th US Open 99';

select * from seedings where event='4th US Open 99';

select * from tourneys where event='4th US Open 99'; 

create table results_20171108 as select * from results;

create table seedings_20171108 as select * from seedings;

create table tourneys_20171108 as select * from seedings;


delete from results where event='4th US Open 99';

delete from seedings where event='4th US Open 99';

delete from tourneys where event='4th US Open 99'; 


select * from seedings where event='Choice Hotels 7th US Open 02';

delete from seedings where event='Choice Hotels 7th US Open 02';