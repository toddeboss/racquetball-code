-- Screwed up Marci Drexler/Greer results; had to re-split them out.  Luckily it looks like they never
-- overlapped.

select * from results where winner like '%Marci%'
union 
select * from results where loser like '%Marci%'
order by tmp_date asc;

create table results_20170119 as select * from results;

update results set winner='Greer, Marci' where winner='Drexler (Greer), Marci' and tmp_date < '1985-09-01';

update results set loser='Greer, Marci' where loser='Drexler (Greer), Marci' and tmp_date < '1985-09-01';

update results set winner='Drexler, Marci' where winner='Drexler (Greer), Marci' and tmp_date > '1985-09-01';

update results set loser='Drexler, Marci' where loser='Drexler (Greer), Marci' and tmp_date > '1985-09-01';


select * from rankings where player like '%Marci%' order by season;

delete from rankings where season in ('1981-82','1982-83','1983-84','1984-85');

insert into rankings select * from rankings_20161209 where season in ('1981-82','1982-83','1983-84','1984-85');

update rankings set player='Greer, Marci' where season in ('1978-79','1980-81','1981-82','1982-83','1983-84','1984-85') and player='Drexler (Greer), Marci';

update rankings set player='Drexler, Marci' where player='Drexler (Greer), Marci';


select * from seedings where player like '%Marci%';

update seedings set player='Drexler, Marci' where player='Drexler (Greer), Marci';


