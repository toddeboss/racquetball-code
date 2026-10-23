-- Clean up Victoria Rodriguez in WOR, update to (USA) version

SET SQL_SAFE_UPDATES = 0;

select * from cp30725_prs.player_profile where player like '%Rodriguez, Vic%';

-- WOR Singles

select * from results where loser like '%Rodriguez, Victoria%';

select * from results where winner like '%Rodriguez, Victoria%';

update results set loser='Rodriguez, Victoria (USA)' where loser like '%Rodriguez, Victoria%';

update results set winner='Rodriguez, Victoria (USA)' where winner like '%Rodriguez, Victoria%';

update seedings set player='Rodriguez, Victoria (USA)' where player like '%Rodriguez, Victoria%';


-- WOR Doubles


select * from results_doubles where loser_p1 like '%Rodriguez, Victoria%';

select * from results_doubles where loser_p2 like '%Rodriguez, Victoria%';

select * from results_doubles where winner_p1 like '%Rodriguez, Victoria%';

select * from results_doubles where winner_p2 like '%Rodriguez, Victoria%';

select * from results where winner like '%Rodriguez, Victoria%';

update results_doubles set loser_p1='Rodriguez, Victoria (USA)' where loser_p1 like '%Rodriguez, Victoria%';

update results_doubles set loser_p2='Rodriguez, Victoria (USA)' where loser_p2 like '%Rodriguez, Victoria%';

update results_doubles set winner_p1='Rodriguez, Victoria (USA)' where winner_p1 like '%Rodriguez, Victoria%';

update results_doubles set winner_p2='Rodriguez, Victoria (USA)' where winner_p2 like '%Rodriguez, Victoria%';

update seedings_doubles set player1='Rodriguez, Victoria (USA)' where player1 like '%Rodriguez, Victoria%';

update seedings_doubles set player2='Rodriguez, Victoria (USA)' where player2 like '%Rodriguez, Victoria%';


