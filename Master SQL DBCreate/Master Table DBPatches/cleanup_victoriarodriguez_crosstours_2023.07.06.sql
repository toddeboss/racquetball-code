-- Victoria Rodriguez cleanup/conversion to USA vs Mex
-- 7/6/23


-- Ran all of these in Junior, Amateur, LPRT databases (no results in Amateur or LPRT)

SET SQL_SAFE_UPDATES = 0;

select * from results where winner like 'Rodriguez, Victoria%';

select * from results where loser like 'Rodriguez, Victoria%';

select * from seedings where player like 'Rodriguez, Victoria%';

update results set loser='Rodriguez, Victoria (USA)' where loser='Rodriguez, Victoria';

update seedings set player='Rodriguez, Victoria (USA)' where player='Rodriguez, Victoria';


select * from results_doubles where winner_p1 like 'Rodriguez, Victoria%';

select * from results_doubles where winner_p2 like 'Rodriguez, Victoria%';

update results_doubles set winner_p1='Rodriguez, Victoria (USA)' where winner_p1='Rodriguez, Victoria';

update results_doubles set winner_p2='Rodriguez, Victoria (USA)' where winner_p2='Rodriguez, Victoria';


select * from results_doubles where loser_p1 like 'Rodriguez, Victoria%';

update results_doubles set loser_p1='Rodriguez, Victoria (USA)' where loser_p1='Rodriguez, Victoria';

select * from results_doubles where loser_p2 like 'Rodriguez, Victoria%';

update results_doubles set loser_p2='Rodriguez, Victoria (USA)' where loser_p2='Rodriguez, Victoria';

update seedings set player='Rodriguez, Victoria (USA)' where player='Rodriguez, Victoria';

select * from seedings_doubles;

update seedings_doubles set player1='Rodriguez, Victoria (USA)' where player1='Rodriguez, Victoria';

update seedings_doubles set player2='Rodriguez, Victoria (USA)' where player2='Rodriguez, Victoria';
