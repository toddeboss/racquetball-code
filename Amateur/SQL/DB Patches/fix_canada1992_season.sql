-- quick fix to correct data entry error for season in Canada nationals

select * from results where event ='1992 Canada Racquetball National Singles Championships - Mens Open';

update results set season='1992' where event ='1992 Canada Racquetball National Singles Championships - Mens Open';

update results set season='1992' where event ='1992 Canada Racquetball National Singles Championships - Womens Open';

commit;