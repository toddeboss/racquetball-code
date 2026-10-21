/* 4/12/11: fixing results for IRT Party with the pros; thanks to emailer Chad Levis */

use wwwbossconsultingcom;

create table results_20110412 as select * from results;

select * from results where event='IRT Party with the Pros' and loser='Croft, Ben' and round=8;

update results set loser='Pratt, Charlie' 
where event='IRT Party with the Pros' and loser='Croft, Ben' and round=8;

commit;


-- antoher error, this time reported by Andy Hawthorne's wife tracey.

select * from results where event='2011 Mexico Open' and loser='Carson, Tony' and round=8;

update results set loser='Hawthorne, Andy' 
where event='2011 Mexico Open' and loser='Carson, Tony' and round=8;

commit;