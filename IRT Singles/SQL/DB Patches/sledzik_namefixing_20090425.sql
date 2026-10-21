/* 4/25/09: Sledzik name consolidation */

use wwwbossconsultingcom;

create table results_20090427_clean as select * from results;

truncate table results;
insert into results select * from results_20090427_clean;

select * from results where winner like '%Sledz%'
union
select * from results where loser like '%Sledz%'
order by tmp_date,round desc

update results set loser='Sledzik Jr., Richard' where loser='Sledzick, Ricky';
update results set winner='Sledzik Jr., Richard' where winner='Sledzick, Ricky';

update results set loser='Sledzik Jr., Richard' where loser='Sledzik, Rich';
update results set winner='Sledzik Jr., Richard' where winner='Sledzik, Rich';

update results set loser='Sledzik Jr., Richard' where loser='Sledzik Jr., Rich';
update results set winner='Sledzik Jr., Richard' where winner='Sledzik Jr., Rich';



/* emailed him directly 4/25/09: askign for clarification; answer; all results
for Sledzik in the database should be Richard Sledzik, Jr. */

