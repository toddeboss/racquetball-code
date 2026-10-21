/* 1/18/08: quick fix for NYC player names */

update results set loser='Emmel, Matthew' where loser like '%Emmel%';
commit;