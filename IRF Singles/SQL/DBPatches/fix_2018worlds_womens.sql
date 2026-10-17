select * from tourneys order by tmp_date desc;

select * from results where event='2018 World Championships XIX - Womens Open'
and loser='Hickey, Aisling';

create table results_20190329 as select * from results;

update results set loser='Kajino, Harumi' where event='2018 World Championships XIX - Womens Open'
and loser='Hickey, Aisling' and round=16;