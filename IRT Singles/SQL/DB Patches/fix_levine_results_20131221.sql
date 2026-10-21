use cp30725_men;

select * from results where loser like 'Levine%' or winner like 'Levine%';

create table results_20131221 as select * from results;

update results set winner='Levine, Mike' where winner='Levine, Mark';
update results set loser='Levine, Mike' where loser='Levine, Mark';
