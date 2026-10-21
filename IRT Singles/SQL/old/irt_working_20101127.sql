/* 11/15/10: irt working SQL */

use wwwbossconsultingcom;


-- Code used to generate Tourney auditing sql
select * from results where round=2 order by season desc, tmp_date asc;

select season,count(*) as count from results where round=2 group by season order by count desc;

select season,event,max(round) from results group by season,event order by season desc, tmp_date asc

select * results order by tmp_date desc;
