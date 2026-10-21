/* 1/15/09: fixing a couple of old Mike Orr records */

use wwwbossconsultingcom;

select * from results where winner='Orr, Mike' union 
select * from results where loser='Orr, Mike'
order by tmp_date,round;

update results set loser='Herrera, German' where winner='Orr, Mike' and event='2004 Chicago Open' and round=128;
update results set score='(5),(9),1,0,4' where event='2004 Chicago Open' and round=64 and loser='Orr, Mike';

update results set score='(2),0,(8),7,5' where event='2006 San Diego Open' and winner='Orr, Mike' and round=32;