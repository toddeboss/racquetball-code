-- typo in the tourney name for 2014 mexican nationals

SET SQL_SAFE_UPDATES = 0;

select * from results where event='2014 Cameonato Nacional Selectivo - Mens Open';

select * from tourneys where event='2014 Cameonato Nacional Selectivo - Mens Open';

select * from seedings where event='2014 Cameonato Nacional Selectivo - Mens Open';

update results set event='2014 Campeonato Nacional Selectivo - Mens Open' where event='2014 Cameonato Nacional Selectivo - Mens Open';

update tourneys set event='2014 Campeonato Nacional Selectivo - Mens Open' where event='2014 Cameonato Nacional Selectivo - Mens Open';

update seedings set event='2014 Campeonato Nacional Selectivo - Mens Open' where event='2014 Cameonato Nacional Selectivo - Mens Open';


update results set event='2014 Campeonato Nacional Selectivo - Womens Open' where event='2014 Cameonato Nacional Selectivo - Womens Open';

update tourneys set event='2014 Campeonato Nacional Selectivo - Womens Open' where event='2014 Cameonato Nacional Selectivo - Womens Open';

update seedings set event='2014 Campeonato Nacional Selectivo - Womens Open' where event='2014 Cameonato Nacional Selectivo - Womens Open';
