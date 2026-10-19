-- Note from Laura mcCarthy; have 2015 modesto open final wrong

create table results_20180127 as select * from results;

SET SQL_SAFE_UPDATES = 0;

select  * from results where event='2015 WRT Modesto Open';

update results set winner='Cardona, Alejandro', loser='Bredenbeck, Jake' 
where event='2015 WRT Modesto Open' and round=2;

commit;