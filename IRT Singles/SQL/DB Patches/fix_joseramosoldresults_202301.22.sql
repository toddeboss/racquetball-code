-- 1/22/23 patch
-- Jose Carlos Ramos/Jose Ramos manual fixes: changing all Jose ramos adult records prior to 2011 to be 'Jose Ramos' and all after will be Jose Carlos Ramos

create table results_20230122 as select * from results;

-- run this in IRT, Amateur, Junior
call sp_fixname ('Ramos, Jose Carlos','Ramos, Jose');

-- then just in IRT run these two:
update results set winner='Ramos, Jose' where winner='Ramos, Jose Carlos' and season in ('2007-8','2008-9','2010-11');

update results set loser='Ramos, Jose' where loser='Ramos, Jose Carlos' and season in ('2007-8','2008-9','2010-11');

