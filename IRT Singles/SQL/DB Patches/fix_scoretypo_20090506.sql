/* 5/6/09: typo in score resulting in too big of a game */

use wwwbossconsultingcom;

select * from results where score='7,85';

update results set score='7,8,5' where score='7,85';

commit;