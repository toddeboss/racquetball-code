/* 12/20/08: fixing Brad Kirch results from nyc pro am 2007 */

use wwwbossconsultingcom;

select * from results where event='New York City Pro Am' order by round;
update results set loser='Kirch, Brad' where event='New York City Pro Am' and round=16 and winner='Huczek, Jack';
update results set winner='Kirch, Brad' where event='New York City Pro Am' and round=32 and loser='Walters, Jordan';