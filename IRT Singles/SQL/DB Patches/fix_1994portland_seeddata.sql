SET SQL_SAFE_UPDATES = 0;

select * from seedings where event='CFC Pro Nationals';

create table seedings_20180318 as select * from seedings;

delete from seedings where event='CFC Pro Nationals' and player='?';

commit;

select * from seedings where player='?';

delete from seedings where player='?';