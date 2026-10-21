-- had anthony not alejandro in this event

select * from results where event='2017 Lewis 39th Annual Pro-Am';

update results set loser='Herrera, Alejandro' where loser='Herrera, Anthony' and event='2017 Lewis 39th Annual Pro-Am';