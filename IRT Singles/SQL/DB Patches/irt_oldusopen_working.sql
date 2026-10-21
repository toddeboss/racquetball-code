SET SQL_SAFE_UPDATES = 0;


select * from results where event='4th US Open';

select * from seedings where event='4th US Open';

select * from tourneys where event='4th US Open'; 

create table results_20171108 as select * from results;

create table seedings_20171108 as select * from seedings;

create table tourneys_20171108 as select * from seedings;


delete from results where event='4th US Open';

delete from seedings where event='4th US Open';

delete from tourneys where event='4th US Open'; 


select * from results where event='Hilton 6th US Open';


select * from results where loser='Boss, Todd';

delete from results where winner='Casillas, Arturo' and loser='Boss, Todd';

delete from results where winner='Ganim, Doug' and loser='Boss, Todd';