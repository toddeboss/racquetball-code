
SET SQL_SAFE_UPDATES = 0;

select * from results where score='14,(18),(19)12,4';

update results set score='14,(18),(19),12,4' where score='14,(18),(19)12,4';

update results set score='12,17,(19),18' where score='12,17,(19)18';

update results set score='14,(18),(19),12,4' where score='14,(18),(19)12,4';

update results set score='(16),16,(12),18,12' where score='(16),16,(12)18,12';

commit;