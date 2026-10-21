-- 6/19/23: cleaning up Sunshine IRT results, putting them back to Michael

-- technically he transitioned mid 2020, so the 2021 Doubles entry should be Sunshine ... but he fft'd all results.  so, makign consistent

use cp30725_men;

select * from results where winner like 'Arterb%';

select * from results where loser like 'Arterb%';

update results set loser='Arterburn, Michael' where loser='Arterburn, Sunshine';

select * from seedings where player like 'Arterburn%';

update seedings set player='Arterburn, Michael' where player='Arterburn, Sunshine';

select * from rankings where player like 'Arterburn%';

update rankings set player='Arterburn, Michael' where player='Arterburn, Sunshine';

commit;

-- any doubles??  none; we're good.

select * from results_doubles where loser_p1 like 'Arter%';

select * from results_doubles where loser_p2 like 'Arter%';