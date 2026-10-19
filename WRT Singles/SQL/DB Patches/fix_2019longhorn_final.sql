-- had to switch winner of 2019 longhorn open b/c it was initially entered into r2sports incorrectly.

select * from results where event like '2019 Long%';

create table results_20190122 as select * from results;

update results set winner='Mar, Javier', loser='Garay, Eduardo'
where event='2019 Longhorn Open' and round=2;

commit;