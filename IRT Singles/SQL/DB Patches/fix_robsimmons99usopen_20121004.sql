/* 10/4/12: Putting in Rob Simmons US Open 1999 result */

use wwwbossconsultingcom;

select * from results where event='4th US Open'and round=64 and winner='Ganim, Doug';

update results set loser='Simmons, Rob', source='Rob Simmons Recollection'  where event='4th US Open' and round=64 and winner='Ganim, Doug';

commit;