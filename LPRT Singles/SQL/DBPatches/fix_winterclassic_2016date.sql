-- quick fix of date for LPRT 2016 event

SET SQL_SAFE_UPDATES = 0;

select * from results where event='2016 11th Annual Winter Classic';

update results set date='2/21/2016', tmp_date='2016-02-21' where event='2016 11th Annual Winter Classic';


select * from tourneys where event='2016 11th Annual Winter Classic';

update tourneys set date='2/21/2016', tmp_date='2016-02-21' where event='2016 11th Annual Winter Classic';

commit;