-- 3/10/11: fixed quick bug in the event name for the San Diego open just past...

use wwwbossconsultingcom;

select distinct(event) from results where event like '2001%'

update results set event='2011 San Diego Open' where event='2001 San Diego Open';
update tourneys set event='2011 San Diego Open' where event='2001 San Diego Open';
update seedings set event='2011 San Diego Open' where event='2001 San Diego Open';


commit;