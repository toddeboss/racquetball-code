-- Clean up Soda Man and Clubber names: embedded double quote nicknames corrupted reports



SET SQL_SAFE_UPDATES = 0;

select * from cp30725_prs.player_profile where player like '%Koll%';

update cp30725_prs.player_profile set player='Koll, Rick' where player like '%Koll%';

select * from cp30725_prs.player_profile where player like '%Clubber%';

update cp30725_prs.player_profile set player='Lane, Craig' where player like '%Clubber%';

select * from results where loser like '%Koll%';

select * from results where winner like '%Koll%';

select * from results where loser like '%Clubber%';

select * from results where winner like '%Clubber%';

update results set loser='Lane, Craig' where loser like '%Clubber%';

update results set winner='Lane, Craig' where winner like '%Clubber%';



select * from results_doubles where loser_p1 like '%Koll%';

update results_doubles set loser_p1='Koll, Rick' where loser_p1 like '%Koll%';

select * from results_doubles where loser_p2 like '%Koll%';

update results_doubles set loser_p2='Koll, Rick' where loser_p2 like '%Koll%';

select * from results_doubles where winner_p1 like '%Koll%';

update results_doubles set winner_p1='Koll, Rick' where winner_p1 like '%Koll%';

select * from results_doubles where winner_p2 like '%Koll%';

update results_doubles set winner_p2='Koll, Rick' where winner_p2 like '%Koll%';





select * from results where loser like '%Clubber%';

select * from results where winner like '%Clubber%';



select * from results_doubles where loser_p1 like '%Clubber%';

update results_doubles set loser_p1='Lane, Craig' where loser_p1 like '%Clubber%';

select * from results_doubles where loser_p2 like '%Clubber%';

update results_doubles set loser_p2='Lane, Craig' where loser_p2 like '%Clubber%';

select * from results_doubles where winner_p1 like '%Clubber%';

update results_doubles set winner_p1='Lane, Craig' where winner_p1 like '%Clubber%';

select * from results_doubles where winner_p2 like '%Clubber%';

update results_doubles set winner_p2='Lane, Craig' where winner_p2 like '%Clubber%';

