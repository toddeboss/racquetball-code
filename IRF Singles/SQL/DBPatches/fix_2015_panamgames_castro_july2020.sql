-- Correcting Castro results in 2015 pan am games per Jan Hansen 7/9/20

SET SQL_SAFE_UPDATES = 0;

select * from results where event='2015 Pan American Games - Mens Open';

create table results_20200709 as select * from results;

create table seedings_20200709 as select * from seedings;

update results set loser='Castro, Cesar' where loser='Castro, Pedro' and event='2015 Pan American Games - Mens Open';

update seedings set player='Castro, Cesar' where player='Castro, Pedro' and event='2015 Pan American Games - Mens Open';

truncate table results;

insert into results select * from results_20200709;

commit;