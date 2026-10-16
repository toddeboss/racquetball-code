-- putting in better details for 88 and 89 women's nationals finals.

SET SQL_SAFE_UPDATES = 0;

select * from results where event='1988 USA Racquetball National Singles Championships - Womens Open';

delete from results where event='1988 USA Racquetball National Singles Championships - Womens Open';


select * from results where score='8,8,6';

update results set score='8,6' where score='8,8,6';



select * from results where event='1989 USA Racquetball National Singles Championships - Womens Open';


delete from results where event='1989 USA Racquetball National Singles Championships - Womens Open';


