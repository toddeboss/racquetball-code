-- fixing some USA nationals finals participants.  also uploaded new 1988 semis and ifnals

SET SQL_SAFE_UPDATES = 0;

select * from results where event='1986 USA Racquetball National Singles Championships - Mens Open';

delete from results where event='1988 USA Racquetball National Singles Championships - Mens Open';


update results set loser='Roberts, Andy' where event='1987 USA Racquetball National Singles Championships - Mens Open' and round=2;

update results set loser='Roberts, Andy' where event='1986 USA Racquetball National Singles Championships - Mens Open' and round=2;


