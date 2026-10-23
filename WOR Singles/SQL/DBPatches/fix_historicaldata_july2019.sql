-- July 2019 fixing some older data 

select * from tourneys order by tmp_date desc;

select * from results where event='2019 46th Outdoor Racquetball Championships - Mens Three Wall';

update results set score='wbf-inj' where event='2019 46th Outdoor Racquetball Championships - Mens Three Wall' and round=2;

commit;


select * from results order by tmp_date asc;




-- loading up corrected old data

create table results_20190716 as select * from results;

select * from results where tour='WOR Mens Three Wall' and tmp_date < '2014-01-01' order by tmp_date desc;

delete from results where tour='WOR Mens Three Wall' and tmp_date < '2014-01-01';



select * from results where event='1981 8th WOR Championships - Mens Three Wall';

update results set loser='?' where event='1981 8th WOR Championships - Mens Three Wall' and round=4 and winner='Southern, Dan';

select * from results where event='1986 13th WOR Championships - Mens Three Wall';

-- was Booth as the semi finalist here, Peck thinks this is the year.
update results set loser='Peck, Gregg' where event='1986 13th WOR Championships - Mens Three Wall' and round=4 and winner='Southern, Dan';
update results set loser='Andrews, Ed' where event='1986 13th WOR Championships - Mens Three Wall' and round=4 and winner='Hawkes, Brian';



commit;
