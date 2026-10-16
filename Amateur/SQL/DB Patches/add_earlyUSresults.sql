use cp30725_amateur;

SET SQL_SAFE_UPDATES = 0;

select * from results where event='1970 USA Racquetball National Singles Championships - Mens Open';

update results set loser='Brumfield, Charlie' where round=2 and event='1970 USA Racquetball National Singles Championships - Mens Open';

select * from results where event='1971 USA Racquetball National Singles Championships - Mens Open';

update results set loser='Finger, Craig' where round=2 and event='1971 USA Racquetball National Singles Championships - Mens Open';