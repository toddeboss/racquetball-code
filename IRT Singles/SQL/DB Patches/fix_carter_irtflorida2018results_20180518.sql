select * from results where event='2018 Florida IRT Regional Championships';

create table results_20180518 as select * from results;

update results set loser='Carter, Thomas' where winner='Carson, Rocky' and 
event='2018 Florida IRT Regional Championships'
and round=16;

commit;