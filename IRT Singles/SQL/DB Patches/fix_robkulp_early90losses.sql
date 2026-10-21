-- Adding in Rob Kulp early round losses From FB conversation 11/15/17

select * from seedings;

select seeding from seedings where event='2017 IRT Phase IV Scientific Health & Performance Pro-Am' and player='Parrilla, Andree';

select * from results where event='7th Annual St. Vincents 1st Coast Classic';

update results set loser='Kulp, Rob', source='Rob Kulp FB conversation 11/15/17' where event='7th Annual St. Vincents 1st Coast Classic' and winner='Hogan, Marty' and round=32;

insert into results values ('Kulp, Rob','?',64,' ','IRT','Jacksonville, FL','7th Annual St. Vincents 1st Coast Classic','12/8/1991',
'Rob Kulp FB conversation 11/15/17','12/8/1991',' ','1991-12-08');

update results set season='1991-2' where season='12/8/1991';




select * from results where event='Memphis Pro-Am (GS #2)';

update results set loser='Kulp, Rob', source='Rob Kulp FB conversation 11/15/17' where event='Memphis Pro-Am (GS #2)' and winner='Roberts, Andy' and round=32;

insert into results values ('Kulp, Rob','?',64,' ','IRT','Memphis, TN','Memphis Pro-Am (GS #2)','3/22/1992',
'Rob Kulp FB conversation 11/15/17','1991-2',' ','1992-03-22');



select * from results where event='Elmwood Summer Cooler' and date='8/23/1992';

update results set loser='Kulp, Rob',source='Rob Kulp FB conversation 11/15/17' where event='Elmwood Summer Cooler' and date='8/23/1992' and winner='Newman, Jack' and round=32;

insert into results values ('Kulp, Rob','?',64,' ','IRT','New Orleans, LA','Elmwood Summer Cooler','8/23/1992',
'Rob Kulp FB conversation 11/15/17','1992-3',' ','1992-08-23');


commit;