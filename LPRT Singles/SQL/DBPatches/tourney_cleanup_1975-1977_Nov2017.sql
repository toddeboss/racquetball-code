-- tourney clean up or 1975-1977 tourneys.

use cp30725_women;

SET SQL_SAFE_UPDATES = 0;

create table results_20171122 as select * from results;
create table tourneys_20171122 as select * from tourneys;
create table seedings_20171122 as select * from seedings;


select * from tourneys order by tmp_date asc;

select * from results where event='Southfield 77';

select * from results where event='Lombard 77';

select * from results where event='Newport Beach 77';

select * from results where event='NRC DP/Leach Nationals 77';

select * from seedings where event in ('Southfield 77','Lombard 77','Newport Beach 77','NRC DP/Leach Nationals 77');

select * from tourneys where event in ('Southfield 77','Lombard 77','Newport Beach 77','NRC DP/Leach Nationals 77');



delete from results where event in ('Southfield 77','Lombard 77','Newport Beach 77','NRC DP/Leach Nationals 77');

delete from tourneys where event in ('Southfield 77','Lombard 77','Newport Beach 77','NRC DP/Leach Nationals 77');

delete from seedings where event in ('Southfield 77','Lombard 77','Newport Beach 77','NRC DP/Leach Nationals 77');


select * from tourneys where season = '1975-76';

select * from results where season = '1975-76' order by tmp_date asc, round desc;

delete from results where event='NRC DP/Leach Nationals 76' and source='Evan from racquetballblogspot';

delete from tourneys where event='NRC DP/Leach Nationals 76' and major_flag='N';

update tourneys set major_flag='Y' where event='IRA Nationals 76';