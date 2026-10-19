-- 1/29/18: Note from Laura mcCarthy; the 2016 Longhorn open was not an official WRT event.  

create table results_20180127 as select * from results;

SET SQL_SAFE_UPDATES = 0;

select * from results where event='2016 Longhorn Open';


delete from results where event='2016 Longhorn Open';

delete from tourneys where event='2016 Longhorn Open';

delete from seedings where event='2016 Longhorn Open';



delete from results_doubles where event='2016 Longhorn Open';

delete from tourneys_doubles where event='2016 Longhorn Open';

delete from seedings_doubles where event='2016 Longhorn Open';