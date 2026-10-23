-- 7/29/23: fixing Rick "Soda Man" Koll to remove quoted names b/c its breaking queries.

SET SQL_SAFE_UPDATES = 0;

-- singles
create table results_20230729 as select * from results;

-- Rick has no singles results
select * from results where winner like 'Koll%';

update results set winner='Koll, Rick' where winner like 'Koll%';

select * from results where loser like 'Koll%';

update results set loser='Koll, Rick' where loser like 'Koll%';


-- doubles

create table results_doubles_20230729 as select * from results_doubles;

select * from results_doubles where winner_p1 like 'Koll%';

update results_doubles set winner_p1='Koll, Rick' where winner_p1 like 'Koll%';

select * from results_doubles where winner_p2 like 'Koll%';

update results_doubles set winner_p2='Koll, Rick' where winner_p2 like 'Koll%';


select * from results_doubles where loser_p1 like 'Koll%';

update results_doubles set loser_p1='Koll, Rick' where loser_p1 like 'Koll%';

select * from results_doubles where winner_p2 like 'Koll%';

update results_doubles set loser_p2='Koll, Rick' where loser_p2 like 'Koll%';


select * from seedings where player like 'Koll%';

select * from seedings_doubles where player1 like 'Koll%';

update seedings_doubles set player1='Koll, Rick' where player1 like 'Koll%';

update seedings_doubles set player2='Koll, Rick' where player2 like 'Koll%';





commit;
