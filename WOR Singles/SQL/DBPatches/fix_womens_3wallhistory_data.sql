-- cleanup/ reload of older WOR ladies pro data




select * from results where tour='WOR Womens Three Wall' and tmp_date < '2013-08-01' order by tmp_date desc;

select * from seedings where event in 
  (select event from results where tour='WOR Womens Three Wall' and tmp_date < '2013-08-01' order by tmp_date desc);
  
create table results_20200229 as select * from results;

delete from results where tour='WOR Womens Three Wall' and tmp_date < '2013-08-01';


commit;
