-- quick fix to change the tour code for NRC and IRA to distinguish in between men and women for code to work

SET SQL_SAFE_UPDATES = 0;


select tour,count(*) from results group by tour order by 2 desc;

create table results_20191220 as select * from results;

update results set tour='NRCw' where tour='NRC';

update results set tour='IRAw' where tour='IRA';