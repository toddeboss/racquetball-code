-- Fixing Mexican tourney names


SET SQL_SAFE_UPDATES = 0;

select * from results where event='2017 Campeonato Nacional Mexicano de Raquetbol Selectivo (Mexican Nationals Selection Event) - Mens Open';

select * from tourneys where event='2017 Campeonato Nacional Mexicano de Raquetbol Selectivo (Mexican Nationals Selection Event) - Mens Open';

select * from seedings where event='2017 Campeonato Nacional Mexicano de Raquetbol Selectivo (Mexican Nationals Selection Event) - Mens Open';

update results set event='2017 Campeonato Nacional Mexicano de Raquetbol Selectivo - Mens Open'
where event='2017 Campeonato Nacional Mexicano de Raquetbol Selectivo (Mexican Nationals Selection Event) - Mens Open';

update tourneys set event='2017 Campeonato Nacional Mexicano de Raquetbol Selectivo - Mens Open'
where event='2017 Campeonato Nacional Mexicano de Raquetbol Selectivo (Mexican Nationals Selection Event) - Mens Open';

update seedings set event='2017 Campeonato Nacional Mexicano de Raquetbol Selectivo - Mens Open'
where event='2017 Campeonato Nacional Mexicano de Raquetbol Selectivo (Mexican Nationals Selection Event) - Mens Open';


update results set event='2017 Campeonato Nacional Mexicano de Raquetbol Selectivo - Womens Open'
where event='2017 Campeonato Nacional Mexicano de Raquetbol Selectivo (Mexican Nationals Selection Event) - Womens Open';

update tourneys set event='2017 Campeonato Nacional Mexicano de Raquetbol Selectivo - Womens Open'
where event='2017 Campeonato Nacional Mexicano de Raquetbol Selectivo (Mexican Nationals Selection Event) - Womens Open';

update seedings set event='2017 Campeonato Nacional Mexicano de Raquetbol Selectivo - Womens Open'
where event='2017 Campeonato Nacional Mexicano de Raquetbol Selectivo (Mexican Nationals Selection Event) - Womens Open';

	
    
update results set event='2016 Campeonato Nacional Mexicano de Raquetbol Selectivo - Mens Open'
where event='2016 Campeonato Nacional Mexicano de Raquetbol Selectivo (Mexican Nationals Selection Event) - Mens Open';

update tourneys set event='2016 Campeonato Nacional Mexicano de Raquetbol Selectivo - Mens Open'
where event='2016 Campeonato Nacional Mexicano de Raquetbol Selectivo (Mexican Nationals Selection Event) - Mens Open';

update seedings set event='2016 Campeonato Nacional Mexicano de Raquetbol Selectivo - Mens Open'
where event='2016 Campeonato Nacional Mexicano de Raquetbol Selectivo (Mexican Nationals Selection Event) - Mens Open';



update results set event='2016 Campeonato Nacional Mexicano de Raquetbol Selectivo - Womens Open'
where event='2016 Campeonato Nacional Mexicano de Raquetbol Selectivo (Mexican Nationals Selection Event) - Womens Open';

update tourneys set event='2016 Campeonato Nacional Mexicano de Raquetbol Selectivo - Womens Open'
where event='2016 Campeonato Nacional Mexicano de Raquetbol Selectivo (Mexican Nationals Selection Event) - Womens Open';

update seedings set event='2016 Campeonato Nacional Mexicano de Raquetbol Selectivo - Womens Open'
where event='2016 Campeonato Nacional Mexicano de Raquetbol Selectivo (Mexican Nationals Selection Event) - Womens Open';

