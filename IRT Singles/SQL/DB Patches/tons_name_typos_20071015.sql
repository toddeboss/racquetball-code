/* 10/15/07: some name cleanup from recent events..  Man we've got a 
mess of name updates to do... */


select * from results 
where loser like '%Woj%' 
or winner like '%Woj%' 
order by tmp_date,round;


update results set loser='Landa, Roman' where loser='Landa, Romon';
update results set loser='Landa, Alejandro ' where loser='Landa, Alex';

update results set winner='Anderson, Michael' where winner='Anderson, Mike';

update results set loser='Burrell, Arturo' where loser='Burruel, Arturo'

update results set winner='Crockett, Allan' where winner='Crockett, Alan';

update results set loser='De Los Rios, Juan' where loser='De Los Rios Mendoza, Juan';
update results set winner='De Los Rios, Juan' where winner='De Los Rios Mendoza, Juan';

update results set loser='De Los Rios, Gil' where loser='Rios, Gil De Lo';
update results set winner='De Los Rios, Gil' where winner='Rios, Gil De Lo';

update results set loser='Derocheres, Eric' where loser='Derochers, Eric';
update results set winner='Derocheres, Eric' where winner='Derochers, Eric';
update results set loser='Derocheres, Eric' where loser='Desrochers, Eric';
update results set winner='Derocheres, Eric' where winner='Desrochers, Eric';

update results set loser='Entricken, Todd' where loser='Entriken, Tod';

update results set loser='Filippini, Rafael' where loser='Filippini, Rafael';
update results set winner='Filippini, Rafael' where winner='Filippini, Rafael';
update results set loser='Filippini, Rafael' where loser='Fillipini, Raphael';
update results set winner='Filippini, Rafael' where winner='Fillipini, Raphael';
update results set loser='Filippini, Rafael' where loser='Fillippini, Rafael';
update results set winner='Filippini, Rafael' where winner='Fillippini, Rafael';
update results set loser='Filippini, Rafael' where loser='Fillipini, Rafael';
update results set winner='Filippini, Rafael' where winner='Fillipini, Rafael';

update results set loser='Fredenberg, Brian' where loser='Fredenburg, Brian';
update results set winner='Fredenberg, Brian' where winner='Fredenburg, Brian';

update results set loser='Funatani, Sadao' where loser='Futami, Sadao';
update results set winner='Funatani, Sadao' where winner='Futami, Sadao';
update results set loser='Funatani, Sadao' where loser='Funatini, Sadao';
update results set winner='Funatani, Sadao' where winner='Funatini, Sadao';

update results set loser='Furhmann, Tom' where loser='Furhman, Tom';
update results set winner='Furhmann, Tom' where winner='Furhman, Tom';

update results set loser='Ghafarshad, Dawoud' where loser='Ghafarshad, Dawould';
update results set winner='Ghafarshad, Dawoud' where winner='Ghafarshad, Dawould';

update results set loser='Gutierrez, Polo' where loser='Guitierrez, Polo';
update results set winner='Gutierrez, Polo' where winner='Guitierrez, Polo';

update results set loser='Husalak, Nathaniel' where loser='Husulak, Nathaniel';
update results set winner='Husalak, Nathaniel' where winner='Husulak, Nathaniel';
update results set loser='Husalak, Nathaniel' where loser='Husucak, Nathaniel';
update results set winner='Husalak, Nathaniel' where winner='Husucak, Nathaniel';
update results set loser='Husulak, Nathaniel' where loser='Husalak, Nathaniel';
update results set winner='Husulak, Nathaniel' where winner='Husalak, Nathaniel';

update results set winner='KMessier, Matthieu' where winner='Messier, Matthew';
update results set winner='Messier, Matthieu' where winner='KMessier, Matthieu';

update results set loser='Kono, Michimune' where loser='Kono, Michimine';
update results set winner='Kono, Michimune' where winner='Kono, Michimine';
update results set loser='Kono, Michimune' where loser='Michimune';
update results set winner='Kono, Michimune' where winner='Michimune';

update results set loser='Miller, Darrell' where loser='Miller, Darrel';

update results set loser='Moccia, Mark' where loser='Moccia, Marc';

update results set loser='Patendue, Patrick' where loser='Patenadue, Patrick';

update results set loser='Peinada, Daniel' where loser='Peinado, Daniel';
update results set loser='Peinada, Daniel' where loser='Peinada, Darie';

update results set winner='Perdomo, Simon' where winner='Perdoma, Simon';

update results set loser='Ramirez, Tony' where loser='Rameriz, Tony';

update results set winner='Rojas, Steven' where winner='Rojas, Steve';
update results set loser='Rojas, Steven' where loser='Rojas, Steve';

update results set loser='Schraeder, Caleb' where loser='Schrader, Caleb';

update results set winner='Torres, Juan Carlos' where winner='Torres, Juan';
update results set loser='Torres, Juan Carlos' where loser='Torres, Juan';


update results set winner='Ulliman, Pete' where winner='Ulliman, Peter';

update results set winner='Wojonoski, Ron' where winner='Wojnoski, Ron';
update results set loser='Wojonoski, Ron' where loser='Wojnoski, Ron';
update results set winner='Wojonoski, Ron' where winner='WWojonski, Ron';
update results set loser='Wojonoski, Ron' where loser='Wojonski, Ron';



