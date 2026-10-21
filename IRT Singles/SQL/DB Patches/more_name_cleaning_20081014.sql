/* 10/14/08: more name fixing */

--Mike Pawka eznoh@niceup.com says Green,D is Dolwain Green

-- select * from results where winner='Green,D';

update results set winner='Green, Dolwayne' where winner='Green,D';
update results set loser='Green, Dolwayne' where loser='Green,D';

-- and then misspelled name duh
update results set winner='Green, Dolwain' where winner='Green, Dolwayne';
update results set loser='Green, Dolwain' where loser='Green, Dolwayne';


/* More analysis by sorting all names */

/* diagnosis code:
select * from results where winner in (  'Miller, Darrel','Miller, Darrel' )
union
select * from results where loser in  ( 'Miller, Darrell','Miller, Darrell' )
order by tmp_date,round desc;
*/

update results set winner='Berklehamer, Brian' where winner='Berkelhamer, Brian';
update results set loser='Berklehamer, Brian' where loser='Berkelhamer, Brian';

update results set winner='Carson, Anthony' where winner='Carson, Tony';
update results set loser='Carson, Anthony' where loser='Carson, Tony';

update results set winner='Hernandez, Allen' where winner='Hernandez, Alan';
update results set loser='Hernandez, Allen' where loser='Hernandez, Alan';

update results set winner='Eichenberg, Steve' where winner='Eichenberger, Steve';
update results set loser='HEichenberg, Steve' where loser='Eichenberger, Steve';

update results set winner='Hirsekom, Jorge' where winner='Hirsekorn, Jorge';
update results set loser='Hirsekom, Jorge' where loser='Hirsekorn, Jorge';

update results set winner='Husulak, Nathaniel' where winner='Husalak, Nataniel';
update results set loser='Husulak, Nathaniel' where loser='Husalak, Nataniel';

update results set winner='Jammal, Tony' where winner='Jammal Tony';
update results set loser='Jammal, Tony' where loser='Jammal Tony';

update results set winner='Jammal, Tony' where winner='Jamal, Tony';
update results set loser='Jammal, Tony' where loser='Jamal, Tony';

update results set winner='Kelley, Vince' where winner='Kelly, Vince';
update results set loser='Kelley, Vince' where loser='Kelly, Vince';

update results set winner='Loiaza, Enrique' where winner='Loizza, Enrique';
update results set loser='Loiaza, Enrique' where loser='Loizza, Enrique';

update results set winner='Masxner, Matthew' where winner='Majxner, Matthew';
update results set loser='Masxner, Matthew' where loser='Majxner, Matthew';

update results set winner='Milakovich, Bryce' where winner='Milakovic, Bryce';
update results set loser='Milakovich, Bryce' where loser='Milakovic, Bryce';

update results set winner='Miller, Darrell' where winner='Miller, Darrel';
update results set loser='Miller, Darrell' where loser='Miller, Darrel';

update results set winner='Perdomo, Simon' where winner='Perdoma, Simon';
update results set loser='Perdomo, Simon' where loser='Perdoma, Simon';

