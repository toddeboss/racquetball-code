SET SQL_SAFE_UPDATES = 0;

select * from results where event='Fayetteville 07' order by round desc;

select * from seedings where event='Fayetteville 07';

select * from tourneys where event='Fayetteville 07';

update results set event='2007 WPRO Outback Steakhouse Blast It!' where event='Fayetteville 07';

update tourneys set event='2007 WPRO Outback Steakhouse Blast It!' where event='Fayetteville 07';

select * from results where event='2007 WPRO Outback Steakhouse Blast It!' order by round desc;

update results set score='(12),8,(9),6,7' where event='2007 WPRO Outback Steakhouse Blast It!' and round =2;

commit;
