/* 1/22/09: fixing Shimizu results */

select * from results where winner='Shimizu, Akiko';
select * from results where loser='Shimizu, Akiko';

update results set winner='Shimizu, Akio' where winner='Shimizu, Akiko';
update results set loser='Shimizu, Akio' where loser='Shimizu, Akiko';

select * from results where event='New York City Pro-Am';

update results set loser='Shimizu, Hisao' where event='New York City Pro-Am' and round=64 and winner='Palazzo, Joe';

select * from results where event='Craig McCoy Pro-Am';
insert into results values ('Crosser, Bryan','Shimizu, Hisao',64,'','IRT','Riverside','Craig McCoy Pro-Am','1/15/2006','Hisao Shimizu email','2005-6','','2006-01-15');