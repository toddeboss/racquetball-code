-- Quick fix of missing Bredenbeck in database for 2015 Minneapolis event.

select winner, s1.seeding as winner_seed,loser, s2.seeding as loser_seed,round,score 
from results r left join seedings s1 on r.winner = s1.player 
and s1.event=r.event left join seedings s2 on r.loser = s2.player and s2.event=r.event 
where r.event='WRT 2015 Midwest Championships' and r.date='5/3/2015' order by r.tmp_date,r.round desc;

select * from results where event='WRT 2015 Midwest Championships';

select * from seedings where event='WRT 2015 Midwest Championships';

use cp30725_wrt;

SET SQL_SAFE_UPDATES = 0;

create table results_20161205 as select * from results;

update results set winner='Bredenbeck, Jake' where event='WRT 2015 Midwest Championships' and round=8 and loser='Martell, Jaime';

