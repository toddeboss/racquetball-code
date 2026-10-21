/* 10/8/14: Coby Iwaasa name fixing */

use cp30725_men;

create table results_20141008 as select * from results;


select * from results where winner like '%Iwa%'
union
select * from results where loser like '%Iwa%'
order by tmp_date,round desc;

update results set loser='Iwaasa, Coby' where loser='Iwassa, Coby';
update results set winner='Iwaasa, Coby' where winner='Iwassa, Coby';



