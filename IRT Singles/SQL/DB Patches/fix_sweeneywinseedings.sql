create table results_20171203 as select * from results;

create table tourneys_20171203 as select * from tourneys;

SET SQL_SAFE_UPDATES = 0;


select * from results where event='Head Halloween Classic' and date='10/21/1990';

select * from seedings where event='Head Halloween Classic';

select * from tourneys where event='Head Halloween Classic' and date='10/21/1990';

delete from results where event='Head Halloween Classic' and date='10/21/1990';

delete from tourneys where event='Head Halloween Classic' and date='10/21/1990';


select * from seedings where seeding=0;

delete from seedings where seeding=0;

commit;


-------------


select * from results where event='Spalding Toronto Pro-Am'; 