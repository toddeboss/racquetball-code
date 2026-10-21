-- dec 17 removing blank spaces from loser field that got input as a carriage return


-- LPRT version
select distinct winner as name from results union
select distinct loser as name from results union
select distinct player from rankings union
select distinct player from seedings 
union select player from player_profile where gender='F'
order by 1;

select distinct loser as name from results order by 1;

select * from results where loser like '%' order by loser;

SELECT * FROM results WHERE NOT loser REGEXP '^[ -~]+$' AND loser !='';

create table results_20171220 as select * from results;

SET SQL_SAFE_UPDATES = 0;

update results set loser='?' where NOT loser REGEXP '^[ -~]+$' AND loser !='';

commit;