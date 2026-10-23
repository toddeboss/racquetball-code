-- 10/3/25 quick fix to change all 2025 seasons to be 2025-26

SET SQL_SAFE_UPDATES = 0;

select * from information_schema.columns where column_name='season' 
and table_name not like 'results%'
and table_name not like 'rankings%'
and table_name not like 'tourneys%';
order by table_name;

use cp30725_men;


create table results_20251003 as select * from results;
update results set season='2025-26' where season='2025';

create table results_doubles_20251003 as select * from results_doubles;
update results_doubles set season='2025-26' where season='2025';

create table missed_tourney_rpt_20251003 as select * from missed_tourney_rpt;
update missed_tourney_rpt set season='2025-26' where season='2025';

create table rankings_20251003 as select * from rankings;
update rankings set season='2025-26' where season='2025';

create table tour_champions_20251003 as select * from tour_champions;
update tour_champions set season='2025-26' where season='2025';

create table tourneys_20251003 as select * from tourneys;
update tourneys set season='2025-26' where season='2025';


use cp30725_prs;

REPAIR TABLE cp30725_prs.rpt_tracking;

alter table rpt_tracking drop index rpt_tracking_season_ndx ;

create index rpt_tracking_season_ndx on rpt_tracking (season);

create table rpt_tracking_20251003 as select * from rpt_tracking;

update rpt_tracking set season='2025-26' where season='2025';