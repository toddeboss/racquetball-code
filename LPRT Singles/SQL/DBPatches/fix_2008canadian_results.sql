-- typo for the 2008 Canadian tournament; had missing/incorrect finals result.

SET SQL_SAFE_UPDATES = 0;

select * from results where event='2008 Canadian Racquetball Classic' order by round desc;

update results set winner='Longoria, Paola' where event='2008 Canadian Racquetball Classic' and round=2;