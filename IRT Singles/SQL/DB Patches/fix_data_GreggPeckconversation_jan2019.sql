-- Gregg Peck conversation fixes from 1/25/19 conversation

use cp30725_men;

SET SQL_SAFE_UPDATES = 0;

create table results_20190218 as select * from results;

create table tourneys_20190218 as select * from tourneys;

---- First: had two events in 1985 backwards.


select * from results where event='Ektelon Nationals' and date='5/1/1985';

select * from seedings where event='Ektelon Nationals';

select * from tourneys where event='Ektelon Nationals' and date='5/1/1985';


update results set event='1985 Ektelon Nationals' where event='Ektelon Nationals' and date='5/1/1985';

update tourneys set event='1985 Ektelon Nationals' where event='Ektelon Nationals' and date='5/1/1985';

update results set date='5/15/1985', tmp_date='1985-05-15' where event='1985 Ektelon Nationals';

update tourneys set date='5/15/1985', tmp_date='1985-05-15' where event='1985 Ektelon Nationals';

---

select * from results where event='Cracker Shooter Open' and date='5/15/1985';

select * from seedings where event='Ektelon Nationals';

select * from tourneys where event='Cracker Shooter Open' and date='5/15/1985';

update results set event='1985 Cracker Shooter Open', date='5/1/1985', tmp_date='1985-05-01'
where event='Cracker Shooter Open' and date='5/15/1985';

update tourneys set event='1985 Cracker Shooter Open', date='5/1/1985', tmp_date='1985-05-01'
where event='Cracker Shooter Open' and date='5/15/1985';



---------------------------------------

-- in amateur database:

select * from results where event='1981 USA Racquetball National Singles Championships - Mens Open';

update results set loser='Peck, Gregg' where round=2 and event='1981 USA Racquetball National Singles Championships - Mens Open';
