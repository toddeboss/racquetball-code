SET SQL_SAFE_UPDATES = 0;

select * from tourneys where season=1982;

update tourneys set city='Buffalo, NY' where event = '1982 USA Racquetball National Singles Championships - Mens Open';

update tourneys set city='Buffalo, NY' where event = '1982 USA Racquetball National Singles Championships - Womens Open';


update results set city='Buffalo, NY' where event = '1982 USA Racquetball National Singles Championships - Mens Open';

update results set city='Buffalo, NY' where event = '1982 USA Racquetball National Singles Championships - Womens Open';

