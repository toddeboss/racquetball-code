-- 5/30/18: accidentally double-loaded Canadian national doubles; need to clean and re-load

use cp30725_amateur;

SET SQL_SAFE_UPDATES = 0;


select * from results_doubles order by tmp_date desc;

create table results_doubles_20180530 as select * from results_doubles;

create table seedings_doubles_20180530 as select * from seedings_doubles;

create table tourneys_doubles_20180530 as select * from tourneys_doubles;


delete from results_doubles where event='2018 Racquetball Canada Nationals - Mens Open';

delete from results_doubles where event='2018 Racquetball Canada Nationals - Womens Open';

delete from seedings_doubles where event='2018 Racquetball Canada Nationals - Mens Open';

delete from seedings_doubles where event='2018 Racquetball Canada Nationals - Womens Open';

delete from tourneys_doubles where event='2018 Racquetball Canada Nationals - Mens Open';

delete from tourneys_doubles where event='2018 Racquetball Canada Nationals - Womens Open';

-- now re-run staging sql