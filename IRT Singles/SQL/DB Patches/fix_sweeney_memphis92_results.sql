-- fixing Sweeny's lack of a loss in the db.

-- actually have no idea who he lost to in 16s ... guessed based on ranking Yellen.

select * from results where event='Memphis Pro-Am (GS #2)' order by round desc;

create table results_20181203 as select * from results;

delete from results where  event='Memphis Pro-Am (GS #2)' and tmp_date='1992-03-22' and winner='Sweeney, Tim' and round=32;

update results set round=32 where event='Memphis Pro-Am (GS #2)' and tmp_date='1992-03-22' and winner='Sweeney, Tim' and loser='Harnett, Brett';

update results set loser='Sweeney, Tim' where winner='Yellen, Mike' and event='Memphis Pro-Am (GS #2)' and tmp_date='1992-03-22' and round=16;