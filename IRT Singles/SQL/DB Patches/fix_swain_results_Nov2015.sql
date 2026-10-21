select * from results where score like '%87%';

update results set score='3,(9),8,7' where score='3,(9),8,87';


select * from seedings where event='2015 Galaxy Custom Printing IRT Pro-Am';

update seedings set player='Herrera, Alejandro' where event='2015 Galaxy Custom Printing IRT Pro-Am'
and seeding=13;

select * from results where event='2015 Galaxy Custom Printing IRT Pro-Am'

update results set loser='Herrera, Alejandro'
where event='2015 Galaxy Custom Printing IRT Pro-Am'
and loser='Herrera, Anthony';


select * from results where winner='Swain, Cliff'
and score='7,(5),2,7';

select * from results where score='7,(5),2,7';