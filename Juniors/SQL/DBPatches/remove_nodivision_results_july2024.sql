-- 7/3/24: Getting rid of "No Division" lines in data b/c it makes matrix look bad.

-- Plus other 2024 data fixes

SET SQL_SAFE_UPDATES = 0;

create table results_20240703 as select * from results;

delete from results where winner='No Division';

delete from results where winner='(No Division)';

-- why isn't Sam Bredenbeck's account showing up?

select * from results where winner='Bredenbeck, Sam' and round=2;

-- no idea

-- 2024 usa juniors
call sp_fixname('Ali, Eshan','Eli, Eshan');

