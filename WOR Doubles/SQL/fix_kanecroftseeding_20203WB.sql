-- quick fix of seedings at 2020 3wallball

use cp30725_wor;

SET SQL_SAFE_UPDATES = 0;

create table seedings_doubles_20210405 as select * from seedings_doubles;

select * from seedings_doubles where event='2020 11th Annual 3Wallball World Championships - Mens Three Wall'
order by seeding;

update seedings_doubles set seeding=18 where event='2020 11th Annual 3Wallball World Championships - Mens Three Wall'
and player1='Waselenchuk, Kane';