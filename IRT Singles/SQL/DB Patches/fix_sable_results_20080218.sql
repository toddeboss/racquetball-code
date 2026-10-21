/* 2/15/08: fixing Dave Sable/Sabeleski results per email from Steve Szabo */

use wwwbossconsultingcom;

select * from results where winner='Sable, Dave';
select * from results where winner=' Sabalesky, Dave';
select * from results where loser like 'Sabal%';

update results set winner = 'Sabelski, Dave' where winner='Sable, Dave';
update results set loser= 'Sabelski, Dave' where loser='Sable, Dave';
update results set loser='Sabelski, Dave' where loser like 'Sabal%';

/* double checking, fixing name again */

update results set winner = 'Sabalesky, Dave' where winner='Sabelski, Dave';
update results set loser= 'Sabalesky, Dave' where loser='Sabelski, Dave';