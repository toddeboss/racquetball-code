
-- 12/5/16: fixing "seasons" to be year by year.

use cp30725_wrt;

SET SQL_SAFE_UPDATES = 0;



select * from results;

create table results_prefixseasons_20161205 as select * from results;

select year(tmp_date) from results;

update results set season=year(tmp_date);

commit;
