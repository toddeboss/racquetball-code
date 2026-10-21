/* 4/20/09: fixing Rich Wagner, Rich Wagner Jr's records 

4/25/09: screwed this up, had to re-create results table in totoal

*/

select * from results where loser='Wagner, Rich' 
and tmp_date > '1990-01-01'
order by tmp_date desc



update results set loser='Wagner Jr, Rich' where loser='Wagner, Rich' and winner='Mannino, Jason' and tmp_date > '1990-01-01';

update results set loser='Wagner Jr, Rich' where loser='Wagner, Rich' and winner='Ellis, John' and tmp_date > '1990-01-01';