-- fixing source links to be proper r2sports.com for a few past US OPens.

select * from results where event='13th US Open Racquetball Championships';

update results set source='https://www.r2sports.com/tourney/home.asp?TID=2473' where event='13th US Open Racquetball Championships';

select * from results where event='14th Annual US Open';

update results set source='https://www.r2sports.com/tourney/viewResults.asp?TID=4359' where event='14th Annual US Open';

select * from results where event='15th Annual US Open';

update results set source='https://www.r2sports.com/tourney/home.asp?TID=7176' where event='15th Annual US Open';


update results set source='https://www.r2sports.com/tourney/home.asp?TID=8251' where event='16th US Open';


update results set source='https://www.r2sports.com/tourney/viewResults.asp?TID=9825' where event='United Healthcare 17th US Open';

update results set source='https://www.r2sports.com/website/event-results.asp?TID=10724' where event='United Healthcare 18th US Open';

update results set source='https://www.r2sports.com/website/event-results.asp?TID=12509' where event='United Healthcare 19th US Open';
