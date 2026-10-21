-- fixing duplicated losers from bad data entry.
-- 2/14/22 alerted to issue, alos cleaned up some duplicate tourney names.

SET SQL_SAFE_UPDATES = 0;

create table results_20220214 as select * from results;

-- master list.
select event, loser, count(*) from results where loser <> '?' group by event,loser having count(*) > 1;


select * from results where event='2021 Sweet Caroline LPRT Grand Slam Pro-Am';
update results set loser='Tyler, Linda' where winner='Longoria, Paola' and round=32 and event='2021 Sweet Caroline LPRT Grand Slam Pro-Am';

select * from results where event='Chalfont 92';
update results set event='Chalfant Jan 92' where event='Chalfont 92' and date = '1/1/1992';
update results set event='Chalfant Sept 92' where event='Chalfont 92' and date = '9/1/1992';

update tourneys set event='Chalfant Jan 92' where event='Chalfont 92' and date = '1/1/1992';
update tourneys set event='Chalfant Sept 92' where event='Chalfont 92' and date = '9/1/1992';

select * from results where event='20th Christmas Classic';
update results set loser='Hughes, Grace' where winner='Longoria, Paola' and round=16 and event='20th Christmas Classic';
update results set loser='Arias, Mercedes' where winner='Rajsich, Rhonda' and round=16 and event='20th Christmas Classic';

select * from results where event='DP Nationals Boston 85';
update results set loser='?' where winner='Higgins, ?' and round=64 and event='DP Nationals Boston 85';

select * from results where event='Hershey 87';
update results set loser='?' where winner='Kelly (Fischl), Dottie' and round=32 and event='Hershey 87';
insert into results values ('Bevelock, Toni','?','32','','WPRA','Hershey, PA','Hershey 87','4/9/1987',
'Evan Pritchard Research & Data entry','1986-87','','1987-04-09');


select * from results where event='Michael Lanning Pro-Am 01';
update results set loser='?' where winner='Fowler, Doreen' and round=32 and event='Michael Lanning Pro-Am 01';


update results set event='Roanoke Dec 97' where event='Roanoke 97' and date = '12/1/1997';
update results set event='Roanoke Feb 97' where event='Roanoke 97' and date = '2/1/1997';

update tourneys set event='Roanoke Dec 97' where event='Roanoke 97' and date = '12/1/1997';
update tourneys set event='Roanoke Feb 97' where event='Roanoke 97' and date = '2/1/1997';